//
//  BViewController.h
//  HomeAdorn
//
//  Created by liuligui on 15/10/25.
//  Copyright © 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BViewController : BaseViewController<UIScrollViewDelegate,MJRefreshBaseViewDelegate>


@property (nonatomic,strong) NSString * titless;
@property (nonatomic,strong) NSString * context;
@property (nonatomic,strong) NSString * strid;
@end
