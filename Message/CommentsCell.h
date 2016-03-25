//
//  CommentsCell.h
//  HomeAdorn
//
//  Created by mac on 15/7/28.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@interface CommentsCell  : BaseTableViewCell<MJRefreshBaseViewDelegate>
@property (nonatomic,strong) NSArray* images;

@property (strong,nonatomic) UIImageView *Avatar;
@property (strong,nonatomic) UILabel *NameLabel;
@property (strong,nonatomic) UILabel *TimeLabel;
@property (strong,nonatomic) UILabel *ContentLabel;
@property (strong,nonatomic) UIView *BtnView;
@property (strong,nonatomic) UIButton *PointChan;
@property (strong,nonatomic) UIButton *Conmments;
@property (strong,nonatomic) UIButton *Reason;
@property (strong,nonatomic) NSArray *ImageURLArray;
@property (strong,nonatomic) NSMutableArray *Urls;
@property (strong,nonatomic) UIView *ContentView;
@property (strong,nonatomic) UIView *line;
@property (strong,nonatomic) NSString *msid;
@property (strong,nonatomic) UIButton *jubao;
@property (strong,nonatomic) UILabel *msiid;
@property (strong,nonatomic) UILabel *str;
- (void)setChecked:(BOOL)checked;
@end
