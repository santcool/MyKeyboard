//
//  MyCommon.h
//  Pods
//
//  Created by 文峰张 on 2017/11/22.
//

#ifndef MyCommon_h
#define MyCommon_h

#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SCALE ([UIScreen mainScreen].scale)

#endif /* MyCommon_h */
