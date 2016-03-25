//
//  communController.h
//  HomeAdorn
//
//  Created by mac on 15/7/19.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface communController  : BaseViewController<UIScrollViewDelegate,MJRefreshBaseViewDelegate>
@property (nonatomic,strong) NSDictionary *dicInfo;

@end
