//
//  ElvyoTabBar.h
//  Elvyo
//
//  Created by mac on 11/25/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ElvyoTabBar;
@protocol ElvyoTabBarDelegate <NSObject>

@optional

- (void)tabBar:(ElvyoTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
@end
@interface ElvyoTabBar : UIView


- (void)addTabBarButtonWithItem: (UITabBarItem *)item;

@property (nonatomic,weak)id<ElvyoTabBarDelegate>  delegate;

@end
