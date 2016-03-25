//
//  MyAppointmentCell.h
//  HomeAdorn
//
//  Created by wangxiaoer on 7/21/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAppointmentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *orderAddress;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UILabel *yyid;

@property (weak, nonatomic) IBOutlet UILabel *sex;

@end
