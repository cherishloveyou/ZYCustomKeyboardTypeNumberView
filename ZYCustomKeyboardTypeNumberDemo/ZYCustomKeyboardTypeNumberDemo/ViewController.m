//
//  ViewController.m
//  ZYCustomKeyboardTypeNumberDemo
//
//  Created by zhangyang@ifensi.com on 15/4/15.
//  Copyright (c) 2015年 张杨. All rights reserved.
//

#import "ViewController.h"
#import "ZYCustomKeyboardTypeNumberView.h"

@interface ViewController ()<ZYCustomKeyboardTypeNumberViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ZYCustomKeyboardTypeNumberView customKeyboardViewWithServiceTextField:_numberTextField Delegate:self];
    
}




#pragma mark - ZYCustomKeyboardTypeNumberViewDelegate
/**
 *  确定
 */
- (void)customKeyboardTypeNumberView_confirmKeyClicked
{
    NSLog(@"--确定按钮点击，并退下键盘--");
}
/**
 *  退下
 */
- (void)customKeyboardTypeNumberView_shrinkKeyClicked
{
    NSLog(@"--键盘退下点击--");
}



@end
