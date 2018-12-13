### redis分布式锁
> 分布式应用进行逻辑处理时经常会遇到并发问题。</br>
> 比如一个操作要修改用户的状态，修改状态需要先读出用户的状态，在内存里进行修改，改完了再存回去。如果这样的操作同时进行了，就会出现并发问题，因为读取和保存状态这两个操作不是原子的。（Wiki 解释：所谓原子操作是指不会被线程调度机制打断的操作；这种操作一旦开始，就一直运行到结束，中间不会有任何 context switch 线程切换。）</br>

>这个时候就要使用到分布式锁来限制程序的并发执行。Redis 分布式锁使用非常广泛，它是面试的重要考点之一，很多同学都知道这个知识，也大致知道分布式锁的原理，但是具体到细节的使用上往往并不完全正确。

#### 分布式锁原理
> 分布式锁本质上要实现的目标就是在 Redis 里面占一个“茅坑”，当别的进程也要来占时，发现已经有人蹲在那里了，就只好放弃或者稍后再试。</br>

> 占坑一般是使用 setnx(set if not exists) 指令，只允许被一个客户端占坑。先来先占， 用完了，再调用 del 指令释放茅坑。

```
127.0.0.1:6379[9]> setnx lock:codehole true
(integer) 1
... do something critical ...
127.0.0.1:6379[9]> del lock:codehole
(integer) 1
```
*但是有个问题，如果逻辑执行到中间出现异常了，可能会导致 del 指令没有被调用，这样就会陷入死锁，锁永远得不到释放。*

**于是我们在拿到锁之后，再给锁加上一个过期时间，比如 5s，这样即使中间出现异常也可以保证 5 秒之后锁会自动释放。**
```
127.0.0.1:6379[9]> setnx lock:codehole true
(integer) 1
127.0.0.1:6379[9]> expire lock:codehole 30
(integer) 1
127.0.0.1:6379[9]> ttl lock:codehole
(integer) 26
127.0.0.1:6379[9]> del lock:codehole
(integer) 1
```
*但是以上逻辑还有问题。如果在 setnx 和 expire 之间服务器进程突然挂掉了，可能是因为机器掉电或者是被人为杀掉的，就会导致 expire 得不到执行，也会造成死锁。*

*这种问题的根源就在于 setnx 和 expire 是两条指令而不是原子指令。如果这两条指令可以一起执行就不会出现问题。也许你会想到用 Redis 事务来解决。但是这里不行，因为 expire 是依赖于 setnx 的执行结果的，如果 setnx 没抢到锁，expire 是不应该执行的。事务里没有 if-else 分支逻辑，事务的特点是一口气执行，要么全部执行要么一个都不执行。*

> 为了治理这个乱象，Redis 2.8 版本中作者加入了 set 指令的扩展参数，使得 setnx 和 expire 指令可以一起执行，彻底解决了分布式锁的乱象。从此以后所有的第三方分布式锁 library 可以休息了。

```
127.0.0.1:6379[9]> set lock:codehole true ex 50 nx
OK
127.0.0.1:6379[9]> keys *
1) "name2"
2) "lock:codehole"
3) "students"
127.0.0.1:6379[9]> ttl lock:codehole
(integer) 36
```
==上面这个指令就是 setnx 和 expire 组合在一起的原子指令，它就是分布式锁的奥义所在。==

#### 超时问题
>  Redis 的分布式锁不能解决超时问题，如果在加锁和释放锁之间的逻辑执行的太长，以至于超出了锁的超时限制，就会出现问题。因为这时候第一个线程持有的锁过期了，临界区的逻辑还没有执行完，这个时候第二个线程就提前重新持有了这把锁，导致临界区代码不能得到严格的串行执行。
为了避免这个问题，Redis 分布式锁不要用于较长时间的任务。如果真的偶尔出现了，数据出现的小波错乱可能需要人工介入解决。

```
#python 版本
tag = random.nextint()  # 随机数
if redis.set(key, tag, nx=True, ex=5):
    do_something()
    redis.delifequals(key, tag)  # 假想的 delifequals 指令
```

```
#php版本
$redis = Helpers::redis();
        $redis->select(8);
        $rand_number = mt_rand();
        if($set = $redis->rawCommand('set', 'lock:codehole', $rand_number, 'ex', 80, 'nx')) {
            print_r('this is somthing logic...');
            if ($rand_number == $redis->get('lock:codehole')) {
                //业务逻辑执行完后，释放锁
                $redis->del('lock:codehole');
                print_r('this is okay');
            }
        }
```
有一个稍微安全一点的方案是为 set 指令的 value 参数设置为一个随机数，释放锁时先匹配随机数是否一致，然后再删除 key，这是为了确保当前线程占有的锁不会被其它线程释放，除非这个锁是过期了被服务器自动释放的。 但是匹配 value 和删除 key 不是一个原子操作，Redis 也没有提供类似于delifequals这样的指令，这就需要使用 Lua 脚本来处理了，因为 Lua 脚本可以保证连续多个指令的原子性执行。

```
#lua 版本
# delifequals
if redis.call("get",KEYS[1]) == ARGV[1] then
    return redis.call("del",KEYS[1])
else
    return 0
end
```
但是这也不是一个完美的方案，它只是相对安全一点，因为如果真的超时了，当前线程的逻辑没有执行完，其它线程也会乘虚而入。

相关方案：https://github.com/zhaocong6/lock

#### Redis分布式锁实现
> 在分布式系统当中, Redis锁是一个很常用的工具. 举个很常见的例子就是: 某个接口需要去查询数据库的数据, 但是请求量却又很大, 所以我们一般会加一层缓存, 并且设定过期时间. 但是这里存在一个问题就是当并发量很大的情况下, 在缓存过期的瞬间, 会有大量的请求穿透去数据库请求数据, 造成缓存雪崩效应. 这时候如果有锁的机制, 那么就可以控制单个请求去更新缓存.
其实对于Redis锁的看法, 网上已经有很多了, 只是大部分都是基于Java来实现的, 这里给出一个PHP实现的版本. 这里考虑的只是单机部署Redis的情况, 相对会简单好理解, 而且也更加的实用. 如果有分布式Redis部署的情况, 可以参考下Redlock算法的实现.

##### 基本要求
实现一个分布式锁定, 我们至少要考虑它能满足一下的这些需求:
1. 互斥, 就是要在任何的时刻, 同一个锁只能够有一个客户端用户锁定.
2. 不会死锁, 就算持有锁的客户端在持有期间崩溃了, 但是也不会影响后续的客户端加锁
3. 谁加锁谁解锁, 很好理解, 加锁和解锁的必须是同一个客户端

相关方案: https://laravel-china.org/articles/6979/implementation-of-redis-distributed-lock