//
//  MainTabViewController.m
//  HomeImprovement
//
//  Created by C C on 14-9-9.
//  Copyright (c) 2014年 IWork. All rights reserved.
//

#import "MainTabViewController.h"
#import "DaochangViewController.h"
#import "HuodongViewController.h"
#import "MeViewController.h"
#import "BaseNavigationController.h"
#import "MessageViewController.h"
typedef void (^Message)(NSObject *requestData);

@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self InitTabBar];

    [self.tabBarController.tabBar setBackgroundColor:RGBACOLOR(100, 100, 100, 1.0)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PushNotifications:) name:@"PushNotifications" object:nil];
}

-(void)InitTabBar{
    
    DaochangViewController* vc1=[[DaochangViewController alloc] init];
    
    vc1.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"道场礼佛" image:[UIImage imageNamed:@"main_dojo_normal"] selectedImage:[UIImage imageNamed:@"main_dojo_pressed"]];
    
    
    HuodongViewController* vc2=[[HuodongViewController alloc] init];
    
    vc2.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"活动广场" image:[UIImage imageNamed:@"main_maidan_normal"] selectedImage:[UIImage imageNamed:@"main_maidan_pressed"]];
    
    
    MessageViewController* vc3=[[MessageViewController alloc] init];
    
    vc3.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"消息" image:[UIImage imageNamed:@"main_msg_normal"] selectedImage:[UIImage imageNamed:@"main_msg_pressed"]];
    
    
    MeViewController* vc4=[[MeViewController alloc] init];
    
    vc4.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"main_user_normal"] selectedImage:[UIImage imageNamed:@"main_user_pressed"]];
    

    
    //设置UIself控制器的viewControllers属性为我们之前生成的数组controllerArray
    NSArray *mControllerArray =[[NSArray alloc] initWithObjects:
                                vc1,
                                vc2,
//                                mBaikeNavigationController,
                                vc3,
                                vc4,nil];
    
    self.viewControllers = mControllerArray;
    CGRect frame = CGRectMake(0.0, 0, viewW, 49);
    UIView *v = [[UIView alloc] initWithFrame:frame]; // RGBACOLOR(56, 67, 69, 1.0);
    [v setBackgroundColor:[[UIColor alloc] initWithRed:56/255.0
                                                 green:67/255.0
                                                  blue:69/255.0
                                                 alpha:1.0]];
    [self.tabBar insertSubview:v atIndex:0];
    [self Cycling];
    [self createScroll];
}

-(void)PushNotifications:(NSNotification *)userInfo{
    NSLog(@"%@",userInfo.object);
    NSDictionary *dic = (NSDictionary *)userInfo.object;
    
    if ([[dic objectForKey:@"type"] isEqualToString:@"0"]) {
        
    }else if ([[dic objectForKey:@"type"] isEqualToString:@"1"]){
        [userDefaults setObject:@"YES" forKey:@"PushNot"];
        [userDefaults setObject:dic forKey:@"PushUserInfo"];
        self.selectedIndex = 1;
    }
}

-(void)Cycling{
//    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(Message) userInfo:nil repeats:YES];
}

-(void)Message{
    if ([userDefaults objectForKey:@"verification"]) {
        [[CommonFunctions sharedlnstance] getMessageByUserId:[userDefaults objectForKey:@"verification"] Page:0 Size:10 Type:9 Status:0 requestBlock:^(NSObject *requestData, BOOL IsError) {
            if (!IsError) {
                NSDictionary *dic = (NSDictionary *)requestData;
                if ([[[dic objectForKey:@"result"] stringValue] isEqualToString:@"1"]) {
                    NSString *counts = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"data"] count]];
                    [userDefaults setValue:counts forKey:@"Cycling"];
                    [userDefaults synchronize];
                }
            }
        }];
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
