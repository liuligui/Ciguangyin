//
//  DaoChangDetailController.h
//  Ciguangyin
//
//  Created by mac on 15/7/13.
//  Copyright (c) 2015年 ddsw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaoChangDetailController  : BaseViewController<UIScrollViewDelegate,MJRefreshBaseViewDelegate>
@property (nonatomic,strong) NSDictionary *dicInfo;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,assign) NSInteger gz;
@end
