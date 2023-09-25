

## interface

### Study 界面

![img](assets/d8005077-29a7-4f71-860b-e2c83009ba10.png)

step_num输入要测试的step序号（从1开始），然后点击”测试配置参数“，在左下角状态里面会看到错误信息，或生成的日期的ID，点击ID跳转到添加的任务界面

![img](assets/9aed6d92-0a89-4121-a2d4-1d8a16d6e1bf.png)

除第一步外，其他step测试需要在data_in中增加data_for_test参数，用于模拟上一步传来的数据。数据结构可从上一步添加的任务的JSON结果中查看。若为list时，只要用一条数据测试即可，比如：

![img](assets/4a781c22-8bbd-469f-b37f-aee666a356db.png)

点击”测试配置参数“后，只有状态处显示OK，并且有任务ID出现时，才能证明当前任务配置无误。

![img](assets/17ccbc95-a808-4a39-877b-9ea7b85b5632.png)

这一步只是测试了增加任务，并没有测试data_out中的参数，需点击状态中的任务ID，等其下载完成且转移后，study_msg显示ok，才说明任务的data_out参数没问题。

data_for_test 可以保存在steps中，实际运行时，不会其作用，只有在测试时被调用。

------

### task 界面

![image-20230920151628130](assets/image-20230920151628130.png)
