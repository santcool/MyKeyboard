//
//  MyCommon.h
//  Pods
//
//  Created by 文峰张 on 2017/11/22.
//

#ifndef MyCommon_h
#define MyCommon_h

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]

#endif /* MyCommon_h */
