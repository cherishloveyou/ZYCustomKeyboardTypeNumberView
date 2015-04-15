//
//  ZYCustomKeyboardTypeNumberView.h
//  ZYCustomKeyboardTypeNumberDemo
//
//  Created by zhangyang@ifensi.com on 15/4/15.
//  Copyright (c) 2015年 张杨. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYCustomKeyboardTypeNumberViewDelegate <NSObject>

@required
/*** 键盘退下 */
- (void)customKeyboardTypeNumberView_shrinkKeyClicked;
/***  确定按钮 */
- (void)customKeyboardTypeNumberView_confirmKeyClicked;

@optional
/***  文本框文本的变化 */
- (void)customKeyboardTypeNumberView_changeTextFieldWithText:(NSString *)string;
/***  TODO 注销第一响应者 */
- (void)customKeyboardTypeNumberView_resignTextFieldFirstResponder;
@end


@interface ZYCustomKeyboardTypeNumberView : UIView
/***  服务的textField */
@property(nonatomic,weak) UITextField *serviceTextField;
@property(nonatomic,copy) NSString *textString;
@property(nonatomic,weak) id <ZYCustomKeyboardTypeNumberViewDelegate> delegate;
/***  创建方法 */
+ (instancetype)customKeyboardViewWithServiceTextField:(UITextField *)textField Delegate:(id<ZYCustomKeyboardTypeNumberViewDelegate>)delegate;
@end
