//
//  MyTableView.m
//  Demo3DTouch
//
//  Created by AlanYen on 2015/11/12.
//  Copyright © 2015年 17Life. All rights reserved.
//

#import "MyTableView.h"

@implementation MyTableView

- (void)updateForceInfo:(UITouch *)touch {
    self.touchForce = touch.force;
    self.touchMaximumPossibleForce = touch.maximumPossibleForce;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    [self updateForceInfo:touch];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    [self updateForceInfo:touch];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    [self updateForceInfo:touch];
}

@end
