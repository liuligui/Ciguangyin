//
//  YGMyContactCell.h
//  HomeAdorn
//
//  Created by wangxiaoer on 7/24/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGMyContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *phone;

@property (weak, nonatomic) IBOutlet UIImageView *userLogo;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIButton *concern;
@end
