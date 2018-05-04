
###选择优化的数据类型
选择正确的数据类型对于获得高性能至关重要。
#a.更小的通常更好
    一般情况下，应该尽量使用可以正确存储数据的最小数据类型。更小的数据类型通常更快，因为它们占用更少的磁盘，内存和CPU缓存，并且处理时需要的CPU周期也更少
	但是要确保没有低估需要存储值的范围
#b. 简单就好
    简单的数据类型造作通常需要更少的CPU周期.例如整数比字符操作代价更低,因为字符集和校对规则(排序规则)使字符比较比整形比较更为复杂。
	例:应该使用mysql的内建类型而不是字符来存储日期和时间，另外一个是应该用整形存储IP地址。
#c. 尽量避免 NULL
    null的列使得索引，索引统计和值都更为复杂。可为NULL的列会使用更多的存储空间，在mysql里也需要特殊处理。当可为NULL的列被索引时，每个索引记录都需要一个额外的字节，在MyISAM里甚至可能导致固定大小的索引变成可变大小的索引。	