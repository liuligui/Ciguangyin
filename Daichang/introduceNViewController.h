//
//  introduceNViewController.h
//  HomeAdorn
//
//  Created by mac on 15/7/19.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface introduceNViewController   : BaseViewController<UIScrollViewDelegate,UIWaterflowViewdataSource,UIWaterflowViewdelegate,MJRefreshBaseViewDelegate>
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *logo;
@end


