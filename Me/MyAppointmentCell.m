//
//  MyAppointmentCell.m
//  HomeAdorn
//
//  Created by wangxiaoer on 7/21/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import "MyAppointmentCell.h"

@interface MyAppointmentCell()

@property (weak, nonatomic) IBOutlet UILabel *bagroundLable;


@end

@implementation MyAppointmentCell

- (void)awakeFromNib {
    
    _bagroundLable.layer.masksToBounds = YES;
    _bagroundLable.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _bagroundLable.layer.cornerRadius = 5.0;
    _bagroundLable.layer.borderWidth = 1.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
