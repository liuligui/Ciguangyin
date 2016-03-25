//
//  ApplyGameViewController.h
//  HomeAdorn
//
//  Created by mac on 15/7/19.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyGameViewController : BaseViewController<UIScrollViewDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic,strong) NSDictionary *dicInfo;
@end
