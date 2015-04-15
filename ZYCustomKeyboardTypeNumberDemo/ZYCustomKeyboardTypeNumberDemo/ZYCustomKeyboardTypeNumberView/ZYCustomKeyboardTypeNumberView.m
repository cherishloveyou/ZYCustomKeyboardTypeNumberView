//
//  ZYCustomKeyboardTypeNumberView.m
//  ZYCustomKeyboardTypeNumberDemo
//
//  Created by zhangyang@ifensi.com on 15/4/15.
//  Copyright (c) 2015年 张杨. All rights reserved.
//

#import "ZYCustomKeyboardTypeNumberView.h"

static const CGFloat mKeyboardHeight = 202;
CG_INLINE CGFloat GTFixFloat(CGFloat oldValue) {
    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
    if (mainFrme.size.height/1096*2 < 1) { return oldValue; }
    oldValue = (oldValue)*mainFrme.size.width/640*2;
    return oldValue;
}
#define mScreenWidth  ([[UIScreen mainScreen] bounds].size.width)
#define mScreenHeight ([[UIScreen mainScreen] bounds].size.height)
/** RGB颜色转换（16进制->10进制） */
#define HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0\
                                    green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                    blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation ZYCustomKeyboardTypeNumberView

+ (instancetype)customKeyboardViewWithServiceTextField:(UITextField *)textField Delegate:(id<ZYCustomKeyboardTypeNumberViewDelegate>)delegate{
    
    ZYCustomKeyboardTypeNumberView *keyboardView = [[ZYCustomKeyboardTypeNumberView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, GTFixFloat(mKeyboardHeight))];
    keyboardView.serviceTextField = textField;
    textField.inputView = keyboardView;
    keyboardView.delegate = delegate;
    return keyboardView;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textString = @"";
        [self setBackgroundColor:HexColor(0xa2a8ae)];
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOffset:CGSizeMake(0, -0.8)];
        [self.layer setShadowOpacity:0.05];
        
        CGFloat gapWidth = 0.5;
        CGFloat gapHeight = 0.5;
        CGFloat width = (frame.size.width - gapWidth * 3) / 4;
        CGFloat height = (frame.size.height - gapHeight * 3) / 4;
        
        [self addSubview:[self addNumKeyWithFrame:CGRectMake(0, 0, width, height) Title:@"1"]];
        [self addSubview:[self addNumKeyWithFrame:CGRectMake(gapWidth * 1 + width, 0, width, height) Title:@"2"]];
        [self addSubview:[self addNumKeyWithFrame:CGRectMake(gapWidth * 2 + width * 2, 0, width, height) Title:@"3"]];
        [self addSubview:[self addNumKeyWithFrame:CGRectMake(0, gapHeight + height, width, height) Title:@"4"]];
        [self addSubview:[self addNumKeyWithFrame:CGRectMake(gapWidth * 1 + width, gapHeight + height, width, height) Title:@"5"]];
        [self addSubview:[self addNumKeyWithFrame:CGRectMake(gapWidth * 2 + width * 2, gapHeight + height, width, height) Title:@"6"]];
        [self addSubview:[self addNumKeyWithFrame:CGRectMake(0, gapHeight * 2 + height * 2, width, height) Title:@"7"]];
        [self addSubview:[self addNumKeyWithFrame:CGRectMake(gapWidth * 1 + width, gapHeight * 2 + height * 2, width, height) Title:@"8"]];
        [self addSubview:[self addNumKeyWithFrame:CGRectMake(gapWidth * 2 + width * 2, gapHeight * 2 + height * 2, width, height) Title:@"9"]];
        [self addSubview:[self addNumKeyWithFrame:CGRectMake(0, gapHeight * 3 + height * 3, width, height) Title:@"."]];
        [self addSubview:[self addNumKeyWithFrame:CGRectMake(gapWidth * 1 + width, gapHeight * 3 + height * 3, width, height) Title:@"0"]];
        [self addSubview:[self addBackspaceKeyWithFrame:CGRectMake(gapWidth * 3 + width * 3, 0, width, height * 2 + gapHeight) Image:@"ZYCustomKeyboardTypeNumberView.bundle/deleteBtn@2x.png"]];
        [self addSubview:[self addKeyboardKeyWithFrame:CGRectMake(gapWidth * 2 + width * 2, gapHeight * 3 + height * 3, width, height) Image:@"ZYCustomKeyboardTypeNumberView.bundle/closeBtn@2x.png"]];
        [self addSubview:[self addConfirmKeyWithFrame:CGRectMake(gapWidth * 3 + width * 3, gapHeight * 2 + height * 2, width, height * 2 + gapHeight) Title:@"确定"]];
    }
    return self;
}
#pragma mark - 添加数字
- (UIButton *)addNumKeyWithFrame:(CGRect)frame Title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:GTFixFloat(26)]];
    UIImage * aImage = [UIImage imageNamed:@"ZYCustomKeyboardTypeNumberView.bundle/keyboardNum_w.png"];
    UIEdgeInsets edgeInset = UIEdgeInsetsMake(0, 0, frame.size.width, frame.size.height);
    aImage = [aImage resizableImageWithCapInsets:edgeInset resizingMode:UIImageResizingModeTile];
    [button setBackgroundImage:aImage forState:UIControlStateNormal];
    UIImage * highlightImage = [UIImage imageNamed:@"ZYCustomKeyboardTypeNumberView.bundle/keyboardNum_g.png"];
    highlightImage = [highlightImage resizableImageWithCapInsets:edgeInset resizingMode:UIImageResizingModeTile];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(numKeyAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
#pragma mark - 删除
- (UIButton *)addBackspaceKeyWithFrame:(CGRect)frame Image:(NSString *)imageName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - image.size.width) / 2, (frame.size.height - image.size.height) / 2, image.size.width, image.size.height)];
    imgView.image = image;
    [button addSubview:imgView];
    [button setBackgroundImage:[UIImage imageNamed:@"ZYCustomKeyboardTypeNumberView.bundle/keboard_gray_normal.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"ZYCustomKeyboardTypeNumberView.bundle/keboard_gray_highlighted.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(backspaceKeyAction) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
#pragma mark - 关闭键盘
- (UIButton *)addKeyboardKeyWithFrame:(CGRect)frame Image:(NSString *)imageName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - image.size.width) / 2, (frame.size.height - image.size.height) / 2, image.size.width, image.size.height)];
    imgView.image = image;
    [button addSubview:imgView];
    UIImage * aImage = [UIImage imageNamed:@"ZYCustomKeyboardTypeNumberView.bundle/keyboardNum_w.png"];
    UIEdgeInsets edgeInset = UIEdgeInsetsMake(0, 0, frame.size.width, frame.size.height);
    aImage = [aImage resizableImageWithCapInsets:edgeInset resizingMode:UIImageResizingModeTile];
    [button setBackgroundImage:aImage forState:UIControlStateNormal];
    UIImage * highlightImage = [UIImage imageNamed:@"ZYCustomKeyboardTypeNumberView.bundle/keyboardNum_g.png"];
    highlightImage = [highlightImage resizableImageWithCapInsets:edgeInset resizingMode:UIImageResizingModeTile];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(closeKeyAction) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor whiteColor]];
    return button;
}
#pragma mark - 确定
- (UIButton *)addConfirmKeyWithFrame:(CGRect)frame Title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:20]];
    [button setBackgroundImage:[UIImage imageNamed:@"ZYCustomKeyboardTypeNumberView.bundle/keyboard_blue_normal.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"ZYCustomKeyboardTypeNumberView.bundle/keyboard_blue_highlighted.png"] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(confirmKeyAction) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
#pragma mark - 数字点击
- (void)numKeyAction:(UIButton *)button {
    
    [self assertServiceTextField];
    
    self.textString = self.serviceTextField.text;
    
    if ([button.titleLabel.text isEqualToString:@"."]) {
        if ([self.textString isEqualToString:@""]) {
            self.textString = @"0";
            
        }
        //        else if ([self.textString containsString:@"."]) {
        //            return;
        //        }
    }
    
    self.textString = [NSString stringWithFormat:@"%@%@",self.textString, button.titleLabel.text];
    self.serviceTextField.text = self.textString;
    if ([self.delegate respondsToSelector:@selector(customKeyboardTypeNumberView_changeTextFieldWithText:)]) {
        [self.delegate customKeyboardTypeNumberView_changeTextFieldWithText:self.textString];
    }
}
/**
 *  删除点击事件
 */
- (void)backspaceKeyAction {
    [self assertServiceTextField];
    self.textString = self.serviceTextField.text;
    NSInteger length = self.textString.length;
    if (length == 0) {
        self.textString = @"";
        return;
    }
    
    NSString *substring = [self.textString substringWithRange:NSMakeRange(0, length - 1)];
    self.textString = substring;
    self.serviceTextField.text = substring;
    if ([self.delegate respondsToSelector:@selector(customKeyboardTypeNumberView_changeTextFieldWithText:)]) {
        [self.delegate customKeyboardTypeNumberView_changeTextFieldWithText:self.textString];
    }
}
/**
 *  关闭键盘点击事件
 */
- (void)closeKeyAction {
    [self assertServiceTextField];
    self.textString = self.serviceTextField.text;
    //    self.serviceTextField.text = @"";
    [self.serviceTextField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(customKeyboardTypeNumberView_shrinkKeyClicked)]) {
        [self.delegate customKeyboardTypeNumberView_shrinkKeyClicked];
    }
}
/**
 *  确定点击事件
 */
- (void)confirmKeyAction {
    [self assertServiceTextField];
    self.textString = self.serviceTextField.text;
    [self.serviceTextField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(customKeyboardTypeNumberView_confirmKeyClicked)]) {
        [self.delegate customKeyboardTypeNumberView_confirmKeyClicked];
    }
}

-(void)assertServiceTextField
{
    NSAssert(self.serviceTextField != nil, @"serviceTextField不能为空!!!");
}


@end
