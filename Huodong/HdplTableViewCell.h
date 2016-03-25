//
//  HdplTableViewCell.h
//  HomeAdorn
//
//  Created by mac on 15/7/28.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HdplTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoimage;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *datetime;

@end
