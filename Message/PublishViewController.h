//
//  PublishViewController.h
//  HomeAdorn
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishViewController : BaseViewController<UIScrollViewDelegate,UIWaterflowViewdataSource,UIWaterflowViewdelegate,MJRefreshBaseViewDelegate>

@property (assign,nonatomic) NSString *TitleName;
@property (assign,nonatomic) NSString *msgid;

@end
