//
//  tabBarViewController.m
//  tfbpay_mainViewController
//
//  Created by shufitshi on 2/5/15.
//  Copyright (c) 2015 shufitshi. All rights reserved.
//

#import "tabBarViewController.h"
#import "DaochangViewController.h"
#import "HuodongViewController.h"
#import "MeViewController.h"
#import "MessageViewController.h"
@interface tabBarViewController ()

@end

@implementation tabBarViewController

-(id)init
{
    self=[super init];
    if(self)
    {
        self.navigationController.navigationBarHidden = NO;
        DaochangViewController* tfbpayVC=[[DaochangViewController alloc] init];
        
        tfbpayVC.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"通付宝" image:[UIImage imageNamed:@"tabbar_home_unselected"] selectedImage:[UIImage imageNamed:@"tabbar_home_selected"]];
      
            
            HuodongViewController *VC1 = [[HuodongViewController alloc] init];
            VC1.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"代理商" image:[UIImage imageNamed:@"tabbar_agent_unselected"] selectedImage:[UIImage imageNamed:@"tabbar_agent_selected"]];;
        
        
        /*合作宝首页控制器，导入到主工程中将相应的控制器进行替换即可*/
        MessageViewController *VC2 = [[MessageViewController alloc] init];
        VC2.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"合作" image:[UIImage imageNamed:@"tabbar_coop_unselected"] selectedImage:[UIImage imageNamed:@"tabbar_coop_selected"]];
        
        VC2.view.backgroundColor=[UIColor whiteColor];
        
        /*账户首页控制器，导入到主工程中将相应的控制器进行替换即可*/ //tabbar_account_selected
        MeViewController * VC3=[[MeViewController alloc]init];
        VC3.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"账户" image:[UIImage imageNamed:@"tabbar_myself_unselected"] selectedImage:[UIImage imageNamed:@"tabbar_myself_selected"]];
        VC3.view.backgroundColor=[UIColor whiteColor];
        
        NSArray* controllers=[NSArray arrayWithObjects:tfbpayVC,VC1,VC2,VC3, nil];
        [self setViewControllers:controllers animated:YES];
        self.selectedIndex=0;
        
        
    }
    return self;
}
//
//-(id)init
//{
//    self=[super init];
//    if(self)
//    {
//         UIViewController *VC1=[[UIViewController alloc] init];
//        //道场
//        DaochangViewController *daochang = [[DaochangViewController alloc] init];
//        daochang.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"道场礼佛" image:[UIImage imageNamed:@"main_dojo_normal"] selectedImage:[UIImage imageNamed:@"main_dojo_pressed"]];;
//        //管理
//        HuodongViewController *huodong = [[HuodongViewController alloc] init];
//        daochang.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"活动广场" image:[UIImage imageNamed:@"main_maidan_pressed"] selectedImage:[UIImage imageNamed:@"main_maidan_normal"]];;
//        
//        //消息
//        MessageViewController *message = [[MessageViewController alloc] init];
//        daochang.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"消息" image:[UIImage imageNamed:@"main_msg_normal"] selectedImage:[UIImage imageNamed:@"main_msg_pressed"]];;
//        
//        //我的
//        MeViewController *me = [[MeViewController alloc] init];
//        daochang.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"main_user_normal"] selectedImage:[UIImage imageNamed:@"main_user_pressed"]];;
//        NSArray* controllers=[NSArray arrayWithObjects:daochang,huodong,message,me, nil];
//        [self setViewControllers:controllers animated:YES];
//        
//        self.selectedIndex=1;
//        
//        
//    }
//    return self;
//}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
