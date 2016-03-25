//
//  ElvyoTabBarController.m
//  Elvyo
//
//  Created by mac on 11/25/14.
//  Copyright (c) 2014 mac. All rights reserved.
//
#import "WXApi.h"
#import <MessageUI/MessageUI.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import <AGCommon/NSString+Common.h>
#import "CommonFunctions.h"
#import "APService.h"
#import "LoginViewController.h"
#import "ElvyoHomeController.h"
#import "MainTabViewController.h"
#import "KYCityListCtr.h"
#import "cityPickerViewController.h"
#import "DaochangViewController.h"
#import "ChatViewController.h"
#import "Globle.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "MainTabViewController.h"
#import "ASIFormDataRequest.h"
#import "NavMainViewController.h"
#import "ElvyoHomeController.h"
#import "DaochangViewController.h"
#import "HuodongViewController.h"
#import "MeViewController.h"
#import "MessageViewController.h"
#import "ElvyoTabBar.h"
#import "ElvyoNavigationController.h"
@interface ElvyoHomeController ()<ElvyoTabBarDelegate>
@property (nonatomic, weak) ElvyoTabBar *customTabBar;
@end

@implementation ElvyoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化tabBar
    [self mun];
    [self setTabBar];
    //初始化子控制器
    [self addChildViewController];
    
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor grayColor]];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
   
}

-(void)mun
{
    [[CommonFunctions sharedlnstance] countNum:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        
        NSDictionary *dic= (NSDictionary *)requestData;
     
        if([dic[@"msg"] intValue] == 1)
        {
            int d = [dic[@"plwd"] intValue];
            NSString *count = [NSString stringWithFormat:@"%d",d];
            [Globle shareInstance].plwd = count;
          
        }
        else
        {
            [Globle shareInstance].plwd = @"0";
        }//ElvyoHomeController
        //  self.window.rootViewController = [[NavMainViewController alloc] init];
//        self.window.rootViewController = [[ElvyoHomeController alloc] init];
//        self.window.backgroundColor = [UIColor whiteColor];
//        [self.window makeKeyAndVisible];
    }];
}

- (void)setTabBar
{
    ElvyoTabBar *customTabBar = [[ElvyoTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)tabBar:(ElvyoTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addChildViewController{
    //道场
    DaochangViewController *daochang = [[DaochangViewController alloc] init];
    [self setUpChildViewConrtoller:daochang title:@"道场礼佛" image:@"main_dojo_normal" selected:@"main_dojo_pressed"];
    //管理
    HuodongViewController *huodong = [[HuodongViewController alloc] init];
    [self setUpChildViewConrtoller:huodong title:@"活动广场" image:@"main_maidan_normal"selected:@"main_maidan_pressed"];
    //消息
    MessageViewController *message = [[MessageViewController alloc] init];
    [self setUpChildViewConrtoller:message title:@"消息" image:@"main_msg_normal"selected:@"main_msg_pressed"];
    //我的
    MeViewController *me = [[MeViewController alloc] init];
    [self setUpChildViewConrtoller:me title:@"我的" image:@"main_user_normal" selected:@"main_user_pressed"];
    
    [self createScroll];

}
- (void)setUpChildViewConrtoller :(UIViewController *)uiView title:(NSString *)title image:(NSString *)image selected:(NSString *)selectedImage
{
    uiView.title = title;
    uiView.tabBarItem.image = [UIImage imageNamed:image];
    uiView.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
   
    ElvyoNavigationController *nav = [[ElvyoNavigationController alloc] initWithRootViewController:uiView];
    [self addChildViewController:nav];
    
    //添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:uiView.tabBarItem];
}


-(void)createScroll{
    if (![userDefaults boolForKey:@"everLaunched"]) {
        NSLog(@"first launch");
        
        UIScrollView *_scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, winsize.width, winsize.height);
        CGFloat width = winsize.width;
        CGFloat height = winsize.height;
        
        [self.view addSubview:_scrollView];
        
        for (int i = 0; i < 4; i++) {
            NSString *imageName = [NSString  stringWithFormat:@"Intro_2-%d.png" ,i+1];
            UIImage *image = [UIImage imageNamed: imageName];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(i*width, 0, width, height);
            [_scrollView addSubview:imageView];
            
            if(i==3){
                UIButton *buttonST = [UIButton buttonWithImage:@""];
                buttonST.frame =  CGRectMake(winsize.width * 3 + 70, 0.7535 * winsize.height,winsize.width-140, 65);
                [buttonST handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
                    [userDefaults setBool:YES forKey:@"everLaunched"];
                    [userDefaults setBool:YES forKey:@"firstLaunch"];
                    [_scrollView removeFromSuperview];
                }];
                [_scrollView addSubview:buttonST];
            }
        }
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(4*width, height);
        _scrollView.pagingEnabled = YES;
        self.navigationController.navigationBarHidden = YES;
    }else {
        [userDefaults setBool:NO forKey:@"firstLaunch"];
        NSLog(@"second launch");
    }
}



@end
