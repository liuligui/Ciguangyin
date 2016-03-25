//
//  FengcaiShowViewController.h
//  HomeAdorn
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FengcaiShowViewController  : BaseViewController<UIScrollViewDelegate,UIWaterflowViewdataSource,UIWaterflowViewdelegate,MJRefreshBaseViewDelegate>

@property (nonatomic,strong) NSString* smid;

@end
