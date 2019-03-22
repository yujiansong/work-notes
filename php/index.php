<?php Pjax::begin(['id' => 'pjax-container']) ?>
    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            // ...
            [
                'class' => 'yii\grid\ActionColumn',
                'buttons' => [
                    'delete' => function ($url) {
                        return Html::a(Yii::t('yii', 'Delete'), '#', [
                            'title' => Yii::t('yii', 'Delete'),
                            'aria-label' => Yii::t('yii', 'Delete'),
                            'onclick' => "
                                if (confirm('ok?')) {
                                    $.ajax('$url', {
                                        type: 'POST'
                                    }).done(function(data) {
                                        $.pjax.reload({container: '#pjax-container'});
                                    });
                                }
                                return false;
                            ",
                        ]);
                    },
                ],
            ],
        ],
    ]); ?>
<?php Pjax::end() ?>