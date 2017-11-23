//
//  MILKeyboardView.m
//  Keyboard
//
//  Created by santcool on 2017/10/25.
//  Copyright © 2017年 santcool. All rights reserved.
//

#import "MIFIKeyboardView.h"
//#import <MIFIBasicHeader.h>
//#import <MIFICommonHeader.h>
#import "MIFIKeyboardModel.h"
#import "MyCommon.h"
#import "UIButton+YYWebImage.h"

@implementation MIFIKeyboardButton

@end

static int kBtnTagBasic = 10000;

@interface MIFIKeyboardView()

@property (strong, nonatomic) MIFIKeyboardModel *model;

@end

@implementation MIFIKeyboardView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (!CGRectEqualToRect(frame, CGRectZero)) {
            self.model = [[MIFIKeyboardModel alloc] init];
            [self commonInit:frame];
        }
    }
    return  self;
}

-(instancetype)initWithConfig:(NSString *)jsonString{
    if (self = [super init]) {
        NSError *error;
        MIFIKeyboardModel *model = [[MIFIKeyboardModel alloc] initWithString:jsonString error:&error];
        if (!model || error) {
            model = [[MIFIKeyboardModel alloc] init];
        }
        self.model = model;
        [self commonInit:CGRectZero];
    }
    return self;
}

-(void)commonInit:(CGRect)frame{
    self.backgroundColor =  UIColorFromHex([self.class numberWithHexString:self.model.keyDefaultColor]);
    if (self.model.keyboardBarTitle && self.model.keyboardBarTitle.length) {
        [self setupKeyboardBar];
    }
    [self setupButtons:frame];
}

-(void)setupKeyboardBar{
    UIView *topicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self.model.keyboardBarHeight intValue])];
    topicView.layer.borderColor = UIColorFromHex([self.class numberWithHexString:self.model.keyboardLineColor]).CGColor;
    topicView.layer.borderWidth = 0.5;
    topicView.tag = kBtnTagBasic-1;
    topicView.backgroundColor = UIColorFromHex([self.class numberWithHexString:self.model.keyboardBarColor]);
    [self addSubview:topicView];
    
    UIImageView *safeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"keyboard_shield"]];
    [self addSubview:safeView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    label.font = [UIFont systemFontOfSize:[self.model.keyboardBarFont intValue]];
    label.backgroundColor = UIColorFromHex([self.class numberWithHexString:self.model.keyboardBarColor]);
    label.text = self.model.keyboardBarTitle;
    label.textColor = UIColorFromHex([self.class numberWithHexString:self.model.keyboardBarTextColor]);
    label.tag = kBtnTagBasic-1;
    [label sizeToFit];
    label.frame = CGRectMake(topicView.center.x - label.frame.size.width/2 + safeView.frame.size.width/2+5, topicView.center.y - label.frame.size.height/2, label.frame.size.width, label.frame.size.height);
    [topicView addSubview:label];
    
    safeView.center =CGPointMake(label.frame.origin.x - safeView.frame.size.width/2 -5, label.center.y);
    
    UIImageView *downView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"keyboard_hide"]];
    downView.center = CGPointMake(topicView.frame.size.width - downView.frame.size.width/2 - 15, topicView.center.y);
    downView.userInteractionEnabled = true;
    [self addSubview:downView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearKeyboard)];
    [downView addGestureRecognizer:tap];
}

-(void)setupButtons:(CGRect)frame{

    CGFloat btnWidth = self.model.getDefaultkeyWidth;
    CGFloat btnHeight = self.model.getDefaultkeyHeight;

    UIButton *preBtn = nil;
    UIButton *upBtn = [self viewWithTag:kBtnTagBasic-1];
    int tag = kBtnTagBasic;
    bool equalHeights = [self.model allBtnEqualHeights];
    for (int i = 0; i < self.model.row.count; i++) {
        MIFIBoardRowModel *row = self.model.row[i];
        for (int j = 0; j < row.items.count; j++) {
            MIFIBoardBtnModel *btnModel = row.items[j];
            MIFIKeyboardButton *button = [MIFIKeyboardButton  buttonWithType:UIButtonTypeSystem];
            button.layer.borderColor = UIColorFromHex([self.class numberWithHexString:self.model.keyboardLineColor]).CGColor;
            button.layer.borderWidth = 0.5;
            CGFloat btnX = preBtn?CGRectGetMaxX(preBtn.frame):0;
            CGFloat btnW = btnModel.getkeyWidth>0?btnModel.getkeyWidth:btnWidth;
            CGFloat btnH = btnModel.getkeyHeight>0?btnModel.getkeyHeight:btnHeight;
            CGFloat btnY;
            if (equalHeights) {
                if (i > 0 && j == 0) {
                    upBtn = [self viewWithTag:tag-1];
                }
                btnY = upBtn?CGRectGetMaxY(upBtn.frame):0;
            } else {
                if (i > 0) {
                    MIFIBoardRowModel *upRow  = self.model.row[i-1];
                    upBtn = [self viewWithTag:tag-upRow.items.count];
                }
                btnY = upBtn?CGRectGetMaxY(upBtn.frame):0;
            }
            button.frame = CGRectMake(btnX, btnY, btnW, btnH);
            button.backgroundColor = btnModel.backgroundColor ? UIColorFromHex([self.class numberWithHexString:btnModel.backgroundColor]) : UIColorFromHex([self.class numberWithHexString:self.model.keyLabelColor]);
            button.tag = tag;
            tag++;
            
            [button setTitleColor:btnModel.textColor ? UIColorFromHex([self.class numberWithHexString:btnModel.textColor]) : UIColorFromHex([self.class numberWithHexString:self.model.keyLabelTextColor]) forState:UIControlStateNormal];
            if ([btnModel.getKeyIconImage isKindOfClass:UIImage.class]) {
                [button setImage:btnModel.getKeyIconImage forState:UIControlStateNormal];
            } else if ([btnModel.getKeyIconImage isKindOfClass:NSString.class]){
                [button yy_setImageWithURL:[NSURL URLWithString:btnModel.getKeyIconImage] forState:UIControlStateNormal options:YYWebImageOptionSetImageWithFadeAnimation];
            }
            if (btnModel.disabled && [btnModel.disabled boolValue]) {
                button.userInteractionEnabled = false;
            }
            [button setTitle:btnModel.keyLabel forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:[btnModel.fontSize intValue]>0?[btnModel.fontSize intValue]:[self.model.keyLabelFont intValue]];
            button.character = btnModel.code;
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            if (j < row.items.count - 1) {
                preBtn = button;
            } else {
                preBtn = nil;
            }
        }
    }
    if (CGRectEqualToRect(frame, CGRectZero)) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY([self.subviews lastObject].frame));
    }else{
        CGFloat realHeight = CGRectGetMaxY([self.subviews lastObject].frame);
        self.frame = CGRectMake(frame.origin.x, frame.origin.y + (frame.size.height - realHeight), SCREEN_WIDTH, realHeight);
    }
}

-(void)btnClick:(MIFIKeyboardButton *)sender{
    
    if (self.typingBlock) {
        self.typingBlock(sender.character);
    }
}

-(void)clearKeyboard{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = self.superview.frame.size.height;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)showInView:(UIView *)view{
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[MIFIKeyboardView class]]) {
            [subview removeFromSuperview];
            break;
        }
    }
    if (!view) {
        return;
    }
    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = view.frame.size.height-self.frame.size.height;
        self.frame = frame;
    }];
}

+ (NSInteger)numberWithHexString:(NSString *)hexString{
    
    const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    
    int hexNumber;
    
    sscanf(hexChar, "%x", &hexNumber);
    
    return (NSInteger)hexNumber;
}


@end
