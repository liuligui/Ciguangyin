//
//  YuyuepwViewController.h
//  HomeAdorn
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YuyuepwViewController  : BaseViewController<UIScrollViewDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic,strong) NSString *smid;
@property (weak, nonatomic) IBOutlet UITextField *time1;
@property (weak, nonatomic) IBOutlet UITextField *time2;
@property (weak, nonatomic) IBOutlet UIDatePicker *datetime;

@property (weak, nonatomic) IBOutlet UIView *viewB;
@property (weak, nonatomic) IBOutlet UILabel *week1;
@property (weak, nonatomic) IBOutlet UILabel *week2;

@end
