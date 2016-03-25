//
//  PaiWeiViewController.h
//  HomeAdorn
//
//  Created by mac on 15/7/19.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaiWeiViewController :  BaseViewController<UIScrollViewDelegate,UIWaterflowViewdataSource,UIWaterflowViewdelegate,MJRefreshBaseViewDelegate>
@property (nonatomic,strong) NSDictionary *dicInfo;
@property (nonatomic,assign) NSInteger index;

@end
