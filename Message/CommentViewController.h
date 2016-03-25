//
//  CommentViewController.h
//  HomeAdorn
//
//  Created by liuligui on 15/9/10.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsCell.h"
@interface CommentViewController: BaseViewController<UITableViewDataSource,UITableViewDelegate,UITableViewDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic,strong) CommentsCell *CommentsCell;
@property (nonatomic,strong) NSString *idd;
@end
