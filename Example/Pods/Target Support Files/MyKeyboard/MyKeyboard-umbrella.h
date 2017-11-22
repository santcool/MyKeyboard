#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MIFIKeyboardModel.h"
#import "MIFIKeyboardView.h"
#import "MyCommon.h"
#import "UIView+FrameAdditions.h"

FOUNDATION_EXPORT double MyKeyboardVersionNumber;
FOUNDATION_EXPORT const unsigned char MyKeyboardVersionString[];

