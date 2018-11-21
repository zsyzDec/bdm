# bdm

商业数据挖掘课程讲义和相关资源。

(1)data文件夹保存了上课需要用到的一些数据集。

(2)以日期为文件名的r文件就是当天上课时的代码

(3)下载需要的库https://pan.baidu.com/s/1wwdWki1_PkMj02GYQK7R2w

(4) cart-c50-knn-breast.R是使用cart, cart-prune, C50, Knn在wisconsion breast cancer数据集上进行的10折交叉确认评价模型性能。
cart-c50-knn-breast（normallized）.R是把数据集进行了规范化后进行的实验。

(5)在adult数据集上的数据分析。

adult.data是训练集

adult.test是测试集

adult_cart_c50.R 在训练集上训练cart和c50模型

adult_knn.R 训练KNN模型

adult_SVM.R 训练SVM模型

最后挑选C50在整个训练集上训练模型，在测试集上测试结果

(6)supervised_ratio.R包含两个函数supervised_ratio和woe，用于将categorical数据转换成数值类型

(7)神经网络

nn_fit.R是用神经网络做函数拟合

nn_booston.R在boston housing value数据集上做回归预测

nn_multiclass.R做多类分类

(8)Ensemble

adaboost_baggin_cart_RF.R是adaboost, bagging, cart和随机森林在german credit数据集的比较程序

boostedtree.R是在german credit数据集上的boosted Tree的程序

boostedtree_multi.R是用boosted tree做一个多类分类的示例
