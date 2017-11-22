//
//  MILKeyboardView.h
//  Keyboard
//
//  Created by santcool on 2017/10/25.
//  Copyright © 2017年 santcool. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kMILDeleteStr = @"\b";

static NSString *kMILEnterStr = @"\r";

static NSString *kMILChangePwdStr = @"change";

@interface MIFIKeyboardButton : UIButton

@property (copy, nonatomic) NSString *character;

@end

@interface MIFIKeyboardView : UIView



/**
 * 输入框回调。直接返回对应的code。
 */
@property(copy, nonatomic) void (^typingBlock)(NSString *str);

/**
 根据配置文件，自定义按钮布局。因为json含有按钮的宽高布局等属性，故不用设置frame。

 @param jsonString 按钮配置的jsonString
 @return 键盘
 */
-(instancetype)initWithConfig:(NSString *)jsonString;

/**
 添加键盘到view，从下往上的动画

 @param view 键盘将要被添加的view
 */
-(void)showInView:(UIView *)view;


/**
 移除键盘
 */
-(void)clearKeyboard;

@end
