//
//  UIView+FrameAdditions.h
//  Quanquan
//
//  Created by YOUPU on 3/15/14.
//  Copyright (c) 2014 quanquan.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameAdditions)

@property float x;
@property float y;
@property float width;
@property float height;
@property CGPoint origin;
@property CGSize size;

- (UIImage *)exportToImage;
- (UIView *)findFirstResponder;

@end
