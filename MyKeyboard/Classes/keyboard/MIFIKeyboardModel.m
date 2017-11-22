//
//  MIFIKeyboardModel.m
//  Keyboard
//
//  Created by 文峰张 on 2017/11/6.
//  Copyright © 2017年 santcool. All rights reserved.
//

#import "MIFIKeyboardModel.h"
#import <UIKit/UIKit.h>
#import "MyCommon.h"
//#import <MIFIKit/MIFICommonHeader.h>

@implementation MIFIBoardBtnModel

-(float)getkeyWidth{
    if (_keyWidth && [_keyWidth rangeOfString:@"%%"].length) {
        return SCREEN_WIDTH * [_keyWidth floatValue]/100.0;
    }
    return [_keyWidth intValue];
}

-(float)getkeyHeight{
    if (_keyHeight && [_keyHeight rangeOfString:@"%%"].length) {
        return SCREEN_WIDTH * [_keyHeight floatValue]/100.0;
    }
    return [_keyHeight intValue];
}

-(id)getKeyIconImage{
    if (!_keyIcon || !_keyIcon.length || ![_keyIcon isKindOfClass:NSString.class]) {
        return nil;
    }
    if ([_keyIcon rangeOfString:@"http"].length) {
        return _keyIcon;
    } else if ([_keyIcon rangeOfString:@"/"].length) {
        UIImage *image = [UIImage imageWithContentsOfFile:_keyIcon];
        if (!image) {
            image = [UIImage imageNamed:[_keyIcon componentsSeparatedByString:@"/"].lastObject];
        }
        return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        return [[UIImage imageNamed:_keyIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}

@end

@implementation MIFIBoardRowModel

@end

@implementation MIFIKeyboardModel

-(float)getDefaultkeyWidth{
    if (_keyWidth && [_keyWidth rangeOfString:@"%"].length) {
        return SCREEN_WIDTH * [_keyWidth floatValue]/100.0;
    }
    return [_keyWidth intValue] > 0 ? [_keyWidth intValue] : SCREEN_WIDTH/3.0;
}

-(float)getDefaultkeyHeight{
    if (_keyHeight && [_keyHeight rangeOfString:@"%"].length) {
        return SCREENH_HEIGHT * [_keyHeight floatValue]/100.0;
    }
    return [_keyHeight intValue] > 0 ? [_keyHeight intValue] : 54;
}

-(NSString<Optional> *)keyDefaultColor{
    return _keyDefaultColor?:@"0xffffff";
}

-(NSNumber *)keyLabelFont{
    return [_keyLabelFont intValue] > 0?_keyLabelFont:@(20);
}

-(NSString *)keyLabelColor{
    return _keyLabelColor ? : @"0xffffff";
}

-(NSString *)keyLabelTextColor{
    return _keyLabelTextColor ? : @"0x000000";
}

-(NSNumber<Optional> *)keyboardBarHeight{
    return [_keyboardBarHeight longLongValue] > 0?_keyboardBarHeight:[NSNumber numberWithInt:38];
}

-(NSString *)keyboardBarColor{
    return _keyboardBarColor ? : @"0xffffff";
}

-(NSString *)keyboardBarTextColor{
    return _keyboardBarTextColor ? : @"0x666666";
}

-(NSNumber *)keyboardBarFont{
    return [_keyboardBarFont intValue] > 0?_keyboardBarFont:@(14);
}

-(NSString<Optional> *)keyboardLineColor{
    return _keyboardLineColor ? : @"0xcccccc";
}

-(NSArray<MIFIBoardRowModel *> *)row{
    if (_row.count) {
        return _row;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        MIFIBoardRowModel *model = [[MIFIBoardRowModel alloc] init];
        NSMutableArray *row = [NSMutableArray array];
        for (int j = 0; j < 3; j++) {
            MIFIBoardBtnModel *btnModel = [[MIFIBoardBtnModel alloc] init];
            int index = i*3+j+1;
            if (index < 10) {
                btnModel.code = [NSString stringWithFormat:@"%d",index];
                btnModel.keyLabel = [NSString stringWithFormat:@"%d",index];
            }else if (index == 10){
                btnModel.code = @".";
                btnModel.keyLabel = @".";
                btnModel.backgroundColor = @"0xd5d8db";
            }else if (index == 11){
                btnModel.code = @"0";
                btnModel.keyLabel = @"0";
            }else if (index == 12){
                btnModel.code = @"\b";
                btnModel.keyIcon = @"delete";
                btnModel.backgroundColor = @"0xd5d8db";
            }
            [row addObject:btnModel];
            model.items = (NSArray<MIFIBoardBtnModel> *)row;
        }
        [array addObject:model];
    }
    return array;
}

-(BOOL)allBtnEqualHeights{
    MIFIBoardRowModel *firstRow  = self.row.firstObject;
    int firstHeight = (int)[(MIFIBoardBtnModel *)[firstRow.items firstObject] getkeyHeight];
    if (firstHeight <= 0) {
        firstHeight = self.getDefaultkeyHeight;
    }
    bool equalHeights = true;
    for (MIFIBoardRowModel *row in self.row) {
        for (MIFIBoardBtnModel *model in row.items) {
            if (model.getkeyHeight > 0 && model.getkeyHeight != firstHeight) {
                equalHeights = false;
                break;
            }
        }
    }
    return equalHeights;
}

@end
