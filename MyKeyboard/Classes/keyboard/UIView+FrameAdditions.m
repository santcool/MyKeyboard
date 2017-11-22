//
//  UIView+FrameAdditions.m
//  Quanquan
//
//  Created by YOUPU on 3/15/14.
//  Copyright (c) 2014 quanquan.com. All rights reserved.
//

#import "UIView+FrameAdditions.h"

@implementation UIView (FrameAdditions)

- (float)x {
    return self.frame.origin.x;
}

- (void)setX:(float)newX {
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}

- (float)y {
    return self.frame.origin.y;
}

- (void)setY:(float)newY {
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}

- (float)width {
    return self.frame.size.width;
}

- (void)setWidth:(float)newWidth {
    CGRect frame = self.frame;
    frame.size.width = newWidth;
    self.frame = frame;
}

- (float)height {
    return self.frame.size.height;
}

- (void)setHeight:(float)newHeight {
    CGRect frame = self.frame;
    frame.size.height = newHeight;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)newOrigin {
    CGRect frame = self.frame;
    frame.origin = newOrigin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)newSize {
    CGRect frame = self.frame;
    frame.size = newSize;
    self.frame = frame;
}

- (UIImage *)exportToImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshot;
}

- (UIView *)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    return nil;
}

@end
