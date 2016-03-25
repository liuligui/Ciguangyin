//
//  HyunFigureTableViewCell.m
//  HomeImprovement
//
//  Created by C C on 14-9-13.
//  Copyright (c) 2014年 IWork. All rights reserved.
//
#import "UIImageView+MJWebCache.h"
#import "CommentTableViewCell.h"
#define webimageUrl @"http://112.74.84.69:8080/imgfile/"
@implementation CommentTableViewCell{
    UIImageView *AvatarImageView;
    UILabel *NikName;
    UIButton *ReplayBtn;
    UILabel *TimeLabel;
    UILabel *ReviewContent;
    
    //评论贴
    UIView *ContentView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        AvatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
        AvatarImageView.layer.masksToBounds = YES;
        AvatarImageView.layer.cornerRadius = 15;
        [self addSubview:AvatarImageView];
        
        NikName = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, winsize.width - 50 - 50, 20)];
        NikName.font = [UIFont systemFontOfSize:14];
        [self addSubview:NikName];
        
        ReplayBtn = [UIButton buttonWithTitleImage:@"" Title:@"回复" Frame:CGRectMake(winsize.width -  50, 5, 50, 30)];
        //[self addSubview:ReplayBtn];
        
        TimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 27, winsize.width - 60 , 20)];
        TimeLabel.textColor = [UIColor lightGrayColor];
        TimeLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:TimeLabel];
        
        ReviewContent = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, winsize.width - 60, 20)];
        ReviewContent.numberOfLines = 0;
        ReviewContent.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:ReviewContent];
        
        ContentView = [[UIView alloc] init];
    
        [self addSubview:ContentView];
        
    }
    return self;
}

-(void)setDatas:(NSObject *)objDatas didSelectedBlock:(didSelectedCell)seletedBlock{
    NSDictionary *dic = (NSDictionary *)objDatas;
    NSDictionary *userInfo = [dic objectForKey:@"userInfo"];
    NSDictionary *blindingly = [dic objectForKey:@"blindingly"];
    NSString * imageUrl = [IMAGEURL stringByAppendingString:[dic objectForKey:@"user_image_url"]];
    NSString * strText = [dic objectForKey:@"context"];

     [AvatarImageView setImageURLStr: imageUrl placeholder:[UIImage imageNamed:@"stations"]];
//    [AvatarImageView setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"stations"]];
    NikName.text = [dic objectForKey:@"user_name"];
    TimeLabel.text = [dic objectForKey:@"fb_time"];
    ReviewContent.text = [dic objectForKey:@"context"];
    
    
    CGRect rect = [strText boundingRectWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height+500) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil];
    // 34是label本来的高度，10是我们计算出内容需要的高度之上新增的预留高度
    CGFloat HH = rect.size.height + 20;
    [ReviewContent removeAllSubviews];
     ReviewContent.frame =CGRectMake(50, 50, winsize.width - 60, HH);
   
    
    for (int i=0; i<_images.count; i++) {
        
        NSDictionary *dicc = _images[i];
         NSString *iurl =[IMAGEURL stringByAppendingString:[dicc objectForKey:@"image_url"]];
       
        [ContentView removeAllSubviews];
       
        int imageh;
        if (_images.count>0 || _images.count<4) {
             UIImageView *contentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*80, +HH+50, 75, 75)];
            
            
#import "UIImageView+MJWebCache.h"
            [contentImageView setImageURLStr: iurl placeholder:[UIImage imageNamed:@"stations"]];
               [self addSubview:contentImageView];
            imageh= HH+80;
        }
        if (_images.count>3 || _images.count<7) {
              UIImageView *contentImageView = [[UIImageView alloc]initWithFrame:CGRectMake((i-4)*80, 80+HH, 75, 75)];
            [contentImageView setImageURLStr: iurl placeholder:[UIImage imageNamed:@"stations"]];
            [self addSubview:contentImageView];

            
            imageh= 160+HH;
        }
        if (_images.count>7 || _images.count<10) {
              UIImageView *contentImageView = [[UIImageView alloc]initWithFrame:CGRectMake((i-7)*80, 160+HH, 75, 75)];
            [contentImageView setImageURLStr: iurl placeholder:[UIImage imageNamed:@"stations"]];
            [self addSubview:contentImageView];

            imageh= 240+HH;
        }

        ContentView.frame = CGRectMake(50,100, winsize.width - 60, 1000);
        
    }
    
}

//打开图片
-(void)handleSingleTap:(UITapGestureRecognizer *)gesture{
    UIImageView *ImView = (UIImageView *)gesture.view;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didShowBaseCellImage:)]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:self.textLabel.text forKey:@"IMAGEURL"];
        [dic setObject:ImView.image forKey:@"PLACEHOLDEL"];
        [self.delegate didShowBaseCellImage:dic];
    }
}

@end

