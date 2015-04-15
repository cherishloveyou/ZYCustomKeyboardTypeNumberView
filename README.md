# ZYCustomKeyboardTypeNumberView
##效果图

![ZY icon](http://i2.tietuku.com/422acb0efd8cbfab.jpg)

##简单用法

*   导入头文件：`#import "ZYCustomKeyboardTypeNumberView.h"`
*   创建只需要一句话：`numberTextField`为想要添加数字键盘的textField并遵守`ZYCustomKeyboardTypeNumberViewDelegate`协议
```
[ZYCustomKeyboardTypeNumberView customKeyboardViewWithServiceTextField:numberTextField Delegate:self];
```
*   实现两个代理方法来监听键盘退下和确定按钮 
```
- (void)customKeyboardTypeNumberView_confirmKeyClicked
{
    NSLog(@"--确定按钮点击，并退下键盘--");
}
- (void)customKeyboardTypeNumberView_shrinkKeyClicked
{
    NSLog(@"--键盘退下点击--");
}
```
