//
//  MycollectionCell.h
//  HomeAdorn
//
//  Created by wangxiaoer on 7/18/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MycollectionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headicon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
- (IBAction)collection:(id)sender;

- (IBAction)share:(id)sender;

- (IBAction)comment:(id)sender;

@property (strong, nonatomic)  UILabel *content;


-(void)setData:(NSDictionary *)dataDic;

@end
