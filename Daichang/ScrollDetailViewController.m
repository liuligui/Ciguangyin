

//
//  ScrollDetailViewController.m
//  HomeAdorn
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "ScrollDetailViewController.h"

@interface ScrollDetailViewController ()

@end

@implementation ScrollDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
    
}


-(void)InitControl{
    
    
    NSString *textstring = @"   易旅游立足全球资源，致力为旅游行业（旅行社、酒店、景区、航空公司、签证公司、租车公司）搭建并运营一个线 上线下互通的专业化交易平台。 平台函括了PC官网、手机官网、微网站、APP四位一体的交易系统， 以及 环球旅游资源库、 全球分销系统、 ERP管理系统、 支付系统、 信用及评价系统、 APP导游管理系统、 母子销售系统、 可视化看板管理系统、 员工、角色和权限管理系统等； 实现了在线收客、一键采购、一键分销、一键成团、一键组团等强大功能， 是全球最智能、最专业、最具价值的旅游电子商务平台。（本APP为 APP导游助理管理系统）";
    
    CGRect rect = [textstring boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, self.view.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
    
    
    CGFloat w = rect.size.height;
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, self.view.frame.size.height - 64)];
    scroll.showsVerticalScrollIndicator = NO;
    scroll.contentSize = CGSizeMake(0, w);
    [self.view addSubview:scroll];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, viewW-20, 150)];
    imageView.image = [UIImage imageNamed:@"huodong2"];
    [scroll addSubview:imageView];
    
    

    
    UIImageView *uiimage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.5-50, 10, 100, 100)];
    [uiimage setImage:[UIImage imageNamed:@"logo.png"]];
    [scroll addSubview:uiimage];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, self.view.frame.size.width - 20, w)];
    [label setNumberOfLines:0];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.font = [UIFont systemFontOfSize:14];
    label.text =textstring;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, 30)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:14];
    label2.textColor = [UIColor orangeColor];
    label2.text =@"版本号： V1.0"; //广州伊安斯信息科技有限公司
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 30)];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:14];
    label3.textColor = [UIColor orangeColor];
    label3.text =@"广州伊安斯信息科技有限公司";
    
    [scroll addSubview:label3];
    [scroll addSubview:label2];
    [scroll addSubview:label];
}


@end
