//
//  MycollectionCell.m
//  HomeAdorn
//
//  Created by wangxiaoer on 7/18/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import "MycollectionCell.h"

@implementation MycollectionCell

- (void)awakeFromNib {
    
    _content = [[UILabel alloc]initWithFrame:CGRectZero];
    _content.font = kFont(12);
    _content.numberOfLines = 0;
    _content.textColor = [UIColor grayColor];
    [self.contentView addSubview:_content];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)collection:(id)sender {
}

- (IBAction)share:(id)sender {
}

- (IBAction)comment:(id)sender {
}

-(void)setData:(NSDictionary *)dataDic{
    
    NSString *url = dataDic[@"headiconurl"];
    
    _content.text = @"我是谁了点金乏术两地分居暗恋撒旦法撒旦法；SD发了；撒旦法善良的法律手段放假啦撒旦法撒旦法撒旦法撒旦法发撒旦法撒旦法撒旦法撒旦法对方；拉开距离姥姥家拉";
}

@end
