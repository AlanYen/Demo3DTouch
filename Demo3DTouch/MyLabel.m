//
//  MyLabel.m
//  Demo3DTouch
//
//  Created by AlanYen on 2015/11/12.
//  Copyright © 2015年 17Life. All rights reserved.
//

#import "MyLabel.h"

@implementation MyLabel

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth / [[UIScreen mainScreen] scale];
}

@end
