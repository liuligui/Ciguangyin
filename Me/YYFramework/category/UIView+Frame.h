//
//  UIView+Frame.h
//  WiappSeller
//
//  Created by chenliang on 15-4-17.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

#define strNull @""

@interface UIView (Frame)

- (id)initWithMainFrame;
+ (CGRect)mainFrame;

+ (CGRect)fullScreenBound;

- (CGFloat)left;
- (CGFloat)right;
- (CGFloat)top;
- (CGFloat)bottom;
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)centerX;
- (CGFloat)centerY;
- (void)setLeft:(CGFloat)left;
- (void)setRight:(CGFloat)right;
- (void)setBottom:(CGFloat)bottom;
- (void)setSize:(CGSize)size;
- (void)setTop:(CGFloat)top;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setOrigin:(CGPoint)point;
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;


@end
