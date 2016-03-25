//
//  YuyuedaochangViewController.h
//  HomeAdorn
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YuyuedaochangViewController  : BaseViewController<UIScrollViewDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic,strong) NSString *smid;
@property (nonatomic,strong) NSString *cometime;
@property (nonatomic,strong) NSString *gotime;
@property (weak, nonatomic) IBOutlet UIScrollView *scroview;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UIButton *sex;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *idno;
@property (weak, nonatomic) IBOutlet UIButton *idaddress;
@property (weak, nonatomic) IBOutlet UIButton *nowaddress;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *familename;
@property (weak, nonatomic) IBOutlet UITextField *familephone;
@property (weak, nonatomic) IBOutlet UIButton *famlieaddress;
@property (weak, nonatomic) IBOutlet UIButton *health;
@property (weak, nonatomic) IBOutlet UIButton *chooseContacts;



//搜索标题
@property (nonatomic,copy) NSString *prompt;

//搜索栏为空时默认显示的灰色字
@property (nonatomic,copy) NSString *placeholder;

//搜索结果数组,用来刷新显示搜索结果
@property (nonatomic,strong) NSMutableArray *searchResultArr;

//搜索参数数组
@property (nonatomic,strong) NSArray *parameterArr;

//搜索时的tableView
@property (nonatomic,strong) UITableView *searchTableView;



















@end
