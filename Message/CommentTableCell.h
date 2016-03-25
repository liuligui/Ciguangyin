//
//  CommentTableCell.h
//  HomeAdorn
//
//  Created by liuligui on 15/9/10.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userLogo;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *commenttext;
@property (weak, nonatomic) IBOutlet UILabel *time;
@end
