//
//  DetailsViewController.h
//  HomeAdorn
//
//  Created by mac on 15/7/15.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : BaseViewController<UIScrollViewDelegate,UIWaterflowViewdataSource,UIWaterflowViewdelegate,MJRefreshBaseViewDelegate>

@property (nonatomic,strong) NSDictionary *dicInfo;

@end
