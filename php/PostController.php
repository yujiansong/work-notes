<?php
class PostController extends Controller
{
    // ...
    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        if (!Yii::$app->request->isAjax) {
            return $this->redirect(['index']);
        }
    }
}