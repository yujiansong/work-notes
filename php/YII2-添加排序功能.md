### YII2 添加排序功能

> 背景：yii默认生成的列表排序，无法满足 postGreSql 中的某些类型字段排序（例如数组）<br>
有一个字段"vote_uids" int8[] DEFAULT '{}'::bigint[],
{111111778500000,111111777890000}
存储的数据类型为数组格式，但是默认YII生成的排序规则不准确 <br>
所以需要重写排序规则

> 实现方式
```
class PostsRepliesSearch extends PostsReplies
{
    .
    .
    .
    public function search($params)
    {
        $query = PostsReplies::find();
        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'pagination' => ['pageSize' => 15],
            'sort' => [
                'defaultOrder'=> [
                    'id' => SORT_DESC,
                ],
            ],
        ]);

        // 获取yii自动生成的排序规则
        $sort = $dataProvider->getSort();
        // 添加用户名的排序规则
        $sort->attributes['vote_uids'] = [
			//cardinality PostgreSQL函数，用来返回数组中的总元素数量，或者如果数组是空的则为0
            'asc' => ['cardinality(vote_uids)' => SORT_ASC], 
            'desc' => ['cardinality(vote_uids)' => SORT_DESC],
        ];
        // 设置排序规则
        $dataProvider->setSort($sort);

        if (!($this->load($params) && $this->validate())) {
            return $dataProvider;
        }

        $query->andFilterWhere([
            'id' => $this->id,
            'uid' => $this->uid,
            'categories_id' => $this->categories_id,
        .
        .
        .
}        
```
> index.php
```
 [
    'attribute' => 'vote_uids',
    'value' => function ($model)
    {
        return count($model->vote_uids);
    },
    'contentOptions' => ['width' => '50px', 'align' => 'center', 'disabled' => 'disabled'],
],
```
则可以按 vote_uids 进行排序