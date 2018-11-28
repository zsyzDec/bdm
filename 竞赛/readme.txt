移动客户流失数据集

每行描述一个客户的信息，一共20个属性（特征），最后一列是目标列，给出客户是否流失的标签。无缺失值

cc_train.csv是训练集
cc_test.csv是测试集，测试集没给出类别标签。参赛者提交在测试集上的预测结果。详细描述见下面。

属性描述

1. Customer ID：编号
2. gender：性别 female, male
3. SeniorCitizen：是否是老年人(1, 0)
4. Partner：是否有父母(Yes, No)
5. Dependents：是否有亲属(Yes, No)
6. tenure：客户在公司工作的月数
7. PhoneService：是否客户有固定电话服务(Yes, No)
8. MultipleLines：是否可以有多个固话服务(Yes, No, No phone service)
9. InternetService：客户的internet服务提供商 (DSL, Fiber optic, No)
10. OnlineSecurity：客户是否有online security 服务(Yes, No, No internet service)
11. OnlineBackup：客户是否有online backup服务(Yes, No, No internet service)
12. DeviceProtection：客户是否有device protection服务(Yes, No, No internet service)
13. TechSupport：客户是否有tech support服务(Yes, No, No internet service)
14. StreamingTV:客户是否有streaming TV服务(Yes, No, No internet service)
15. StreamingMovies：客户是否有streaming movies服务(Yes, No, No internet service)
16. Contract：客户合同期(Month-to-month, One year, Two year)
17. PaperlessBilling：是否客户有无纸化账单服务(Yes, No)
18. PaymentMethod：客户的支付方式(Electronic check, Mailed check, Bank transfer (automatic), Credit card (automatic))
19. MonthlyCharges：每月客户应缴费用
20. TotalCharges：当前客户缴费总量
21. Churn：是否客户流失(Yes or No)


提交的结果文件，应该有1000行
每行或者是“Yes”或者是“No”，注意大小写

提交结果到result文件夹，以姓名+编号.txt方式命名。例如，邱江涛1.txt。每个同学最多提交三个文件。即只能有
邱江涛1.txt
邱江涛2.txt
邱江涛3.txt
三个文件

采用balanced Accuracy做为评测标准

