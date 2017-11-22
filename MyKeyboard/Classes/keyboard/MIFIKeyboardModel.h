//
//  MIFIKeyboardModel.h
//  Keyboard
//
//  Created by 文峰张 on 2017/11/6.
//  Copyright © 2017年 santcool. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <UIKit/UIKit.h>
@interface MIFIBoardBtnModel : JSONModel

@property (copy, nonatomic) NSString *code;//点击按钮所输出的字符

@property (copy, nonatomic) NSString<Optional> *keyLabel;//按钮文字

@property (strong, nonatomic) NSNumber<Optional> *fontSize;//按钮字体大小

@property (copy, nonatomic) NSString<Optional> *keyIcon;//按钮图片

@property (copy, nonatomic) NSString<Optional> *backgroundColor;

@property (copy, nonatomic) NSString<Optional> *textColor;

@property (copy, nonatomic) NSString<Optional> *keyWidth;

@property (copy, nonatomic) NSString<Optional> *keyHeight;

@property (strong, nonatomic) NSNumber<Optional> *disabled;//按钮是否可点击

/**
 按钮的自定义宽高，在配置文件中可能出现百分号，也就是宽高等于屏幕宽高乘以百分比，故通过此方法返回正确的按钮宽高。
 
 @return 正确的宽和高
 */
-(float)getkeyWidth;

-(float)getkeyHeight;

/**
 按钮的自定义图片，支持三种图片：1.图片url  2.图片路径（若路径错误，还会尝试根据名称操作3） 3.images.assets中图片的名称。
 
 @return 如果为网络图片，直接返回url。如果是本地图片，返回UIImage对象
 */
-(id)getKeyIconImage;

@end

@protocol MIFIBoardBtnModel
@end

@interface MIFIBoardRowModel : JSONModel

@property (strong, nonatomic) NSArray <MIFIBoardBtnModel> *items;

@end

@protocol MIFIBoardRowModel
@end

@interface MIFIKeyboardModel : JSONModel

@property (copy, nonatomic) NSString<Optional> *keyDefaultColor;//键盘背景色

@property (copy, nonatomic) NSString<Optional> *keyWidth;//按钮默认宽度

@property (copy, nonatomic) NSString<Optional> *keyHeight;//按钮默认高度

@property (copy, nonatomic) NSString<Optional> *keyLabelTextColor;//按钮字体颜色

@property (strong, nonatomic) NSNumber<Optional> *keyLabelFont;//按钮默认字体大小

@property (copy, nonatomic) NSString<Optional> *keyLabelColor;//按钮背景色

@property (strong, nonatomic) NSNumber<Optional> *keyboardBarHeight;//顶部文字栏高度

@property (strong, nonatomic) NSNumber<Optional> *keyboardBarFont;//文字栏目字体大小

@property (copy, nonatomic) NSString<Optional> *keyboardBarTextColor;//文字栏目字体颜色

@property (copy, nonatomic) NSString<Optional> *keyboardBarTitle;//文字栏目文字

@property (copy, nonatomic) NSString<Optional> *keyboardBarColor;//文字栏目背景色

@property (copy, nonatomic) NSString<Optional> *keyboardLineColor;//线条颜色

@property (strong, nonatomic) NSArray <MIFIBoardRowModel> *row;

/**
 按钮的默认宽高，在配置文件中可能出现百分号，也就是宽高等于屏幕宽高乘以百分比，故通过此方法返回正确的按钮宽高。
 
 @return 正确的宽和高
 */
-(float)getDefaultkeyWidth;
-(float)getDefaultkeyHeight;

/**
 是否所有的按钮宽高都相等
 此属性影响按钮相对位置的计算
 */
-(BOOL)allBtnEqualHeights;

@end
