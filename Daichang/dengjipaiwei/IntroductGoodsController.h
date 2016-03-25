//
//  IntroductGoodsController.h
//  HomeAdorn
//
//  Created by mac on 15/7/22.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRadioButton.h"
@interface IntroductGoodsController : BaseViewController<UIScrollViewDelegate,QRadioButtonDelegate,MJRefreshBaseViewDelegate>


@property (nonatomic,assign) int i;

@end
