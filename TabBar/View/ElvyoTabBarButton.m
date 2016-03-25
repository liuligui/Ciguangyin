//
//  ElvyoTabBarButton.m
//  Elvyo
//
//  Created by mac on 11/25/14.
//  Copyright (c) 2014 mac. All rights reserved.
//
// 2.获得RGB颜色
#define ElvyoColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 按钮的默认文字颜色
#define  ElvyoTabBarButtonTitleColor ([UIColor grayColor])
// 按钮的选中文字颜色
#define  ElvyoTabBarButtonTitleSelectedColor ( ElvyoColor(248, 139, 20))
#import "ElvyoTabBarButton.h"

@implementation ElvyoTabBarButton



 - (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:ElvyoTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:ElvyoTabBarButtonTitleSelectedColor forState:UIControlStateSelected];
    }
    return self;
}



//// 重写去掉高亮状态
//- (void)setHighlighted:(BOOL)highlighted {}

//内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageH = contentRect.size.height*0.7;
    CGFloat imageW = contentRect.size.width;
    
    return  CGRectMake(0, 0, imageW, imageH);
    
}
//内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height*0.6;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);

}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 设置文字
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:RGBACOLOR(237, 176, 8, 1.0) forState:UIControlStateSelected];
    
    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
}
@end
