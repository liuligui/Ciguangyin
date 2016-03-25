//
//  YGMyOffencontactCell.h
//  HomeAdorn
//
//  Created by wangxiaoer on 7/22/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGMyOffencontactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *iid;

@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UIButton *deletetbn;
@end
