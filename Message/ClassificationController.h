//
//  ClassificationController.h
//  HomeAdorn
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassificationController  : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITableViewDelegate,UIWebViewDelegate>

@property (nonatomic , strong) NSString *type;


@end
