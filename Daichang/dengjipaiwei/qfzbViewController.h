//
//  qfzbViewController.h
//  HomeAdorn
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRadioButton.h"
#import "SuggestionsList.h"
@interface qfzbViewController : BaseViewController<UIScrollViewDelegate,QRadioButtonDelegate,MJRefreshBaseViewDelegate>
@property (nonatomic, strong) NSString *vctitle;
@property (nonatomic,strong) NSDictionary *dicInfo;
@property (nonatomic,assign) NSInteger index;
@property(retain)SuggestionsList *suggList;
//搜索标题
@property (nonatomic,copy) NSString *prompt;

//搜索栏为空时默认显示的灰色字
@property (nonatomic,copy) NSString *placeholder;

//搜索结果数组,用来刷新显示搜索结果
@property (nonatomic,strong) NSMutableArray *searchResultArr;

//搜索参数数组
@property (nonatomic,strong) NSArray *parameterArr;

@property (nonatomic,strong) NSArray *end;

//搜索时的tableView
@property (nonatomic,strong) UITableView *searchTableView;
@end
