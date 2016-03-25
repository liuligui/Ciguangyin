//
//  AboutUsViewController.m
//  Ciguangyin
//
//  Created by mac on 15/7/10.
//  Copyright (c) 2015年 ddsw. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, viewW-20, 100)];
    lb.text = @"    慈光音佛教平台顺应时代科技的发展，把移动互联网的生活模式与佛教紧密地结合起来，运用互联网软硬件技术为佛教体系中的各级组织机构以及方丈、住持、法师、义工、护法、信众、以及各种法会、放生、禅修、佛教教育、佛教夏令营等佛事活动等提供信息化的交流和服务。";
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
