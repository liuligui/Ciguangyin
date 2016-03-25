//
//  YGMycollectionCtr.h
//  HomeAdorn
//
//  Created by wangxiaoer on 7/18/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import "BaseViewController.h"

@interface YGMyReleaseInforCtr   : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITableViewDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic , strong) NSString *type;

@end
