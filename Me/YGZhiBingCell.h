//
//  YGZhiBingCell.h
//  HomeAdorn
//
//  Created by wangxiaoer on 7/22/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGZhiBingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *no;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *illname;
@property (weak, nonatomic) IBOutlet UILabel *datetime;

@property (weak, nonatomic) IBOutlet UILabel *result;
@property (weak, nonatomic) IBOutlet UILabel *huifan;
@property (weak, nonatomic) IBOutlet UILabel *sex;

@property (weak, nonatomic) IBOutlet UIButton *btnhuifang;



@end
