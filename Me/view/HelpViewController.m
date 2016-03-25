//
//  HelpViewController.m
//  Ciguangyin
//
//  Created by mac on 15/7/10.
//  Copyright (c) 2015年 ddsw. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, viewW-20, viewH/2)];
    lb.text = @"如何修改我的密码？                                                                                            登录界面：点击忘了密码，输入手机号，点击发送验证码，输入验证码，输入新密码，重新输入新密码，点确定，修改密码成功。                                                   选择结缘品需要付费吗？                                                                                                本APP内所有的结缘品都需要付费的，采用货到付款的方式，具体价格见结缘品简介                                                                                     如何查看寺庙的活动？                                                                                               1、进入道场礼佛，点击任意寺庙，在下面的佛事活动里面可以选择您想查看的佛事活动；                                              2、进入活动广场，可以选择您想查看的任意佛事活动；                                                                           注册后我的个人信息不会被泄漏吧                                                                                      请放心，我们的对您的信息只是在相关场景做一个登记处理，不会对您的个人生活造成任何影响。";
    lb.lineBreakMode = UILineBreakModeWordWrap;
    lb.font = [UIFont systemFontOfSize:13];
    lb.numberOfLines = 0;//上面两行设置多行显示
      [self.view addSubview:lb];

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
