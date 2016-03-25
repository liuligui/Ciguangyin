//
//  SUCTableViewCell.m
//  HomeAdorn
//
//  Created by liuligui on 15/11/11.
//  Copyright © 2015年 IWork. All rights reserved.
//

#import "SUCTableViewCell.h"

@implementation SUCTableViewCell


- (void)awakeFromNib {
    
    _bg.layer.masksToBounds = YES;
    _bg.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _bg.layer.cornerRadius = 5.0;
    _bg.layer.borderWidth = 1.0;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
