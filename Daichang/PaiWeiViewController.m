//
//  PaiWeiViewController.m
//  HomeAdorn
//
//  Created by mac on 15/7/19.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "PaiWeiViewController.h"
#import "PaiweizhinanViewController.h"
#import "WangshenglianweiViewController.h"
#import "CSLWViewController.h"
#import "yjzzViewController.h"
#import "jtsyzaViewController.h"
@interface PaiWeiViewController ()
{
    UIScrollView *ViewScroll;
}

@end

@implementation PaiWeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)InitNavigation
{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
}

-(void)InitLoadData
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)InitControl
{
    ViewScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height -64)];
    ViewScroll.userInteractionEnabled = YES;
    ViewScroll.backgroundColor = [UIColor colorWithRed:247 green:247 blue:247 alpha:0.8];
    [ViewScroll setContentSize:CGSizeMake(viewW, 560)];
    [self.view addSubview:ViewScroll];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, viewW-40, 80)];
    [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    NSArray *title =@[@"长生禄位",@"怨家债主",@"往生莲位",@"家庭事业障碍登记"];
    NSArray *btnImage =@[@"changsheng",@"yuanjia",@"wangsheng",@"jiatinghemu"];
    
    int h=60;
    
    UIButton *btntop = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, viewW, 30)];
    [btntop setTitle:@"点击阅读填写排位指南" forState:UIControlStateNormal];
    [btntop setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btntop addTarget:self action:@selector(toNextView) forControlEvents:(UIControlEventTouchUpInside)];
    [btntop setFont:[UIFont systemFontOfSize:15]];
    [ViewScroll addSubview:btntop];
    
    
    for (int i=0; i<btnImage.count; i++) {
        UIButton *btnpaiwei = [[UIButton alloc] initWithFrame:CGRectMake(20, h, viewW-40, 80)];
        [btnpaiwei setImage:[UIImage imageNamed:btnImage[i]] forState:UIControlStateNormal];
        [btnpaiwei setFont:[UIFont systemFontOfSize:15]];
         [btnpaiwei setTitle:title[i] forState:UIControlStateNormal];
       
        [btnpaiwei addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, h+34, viewW, 13)];
        lb.font = [UIFont systemFontOfSize:12];
        lb.text = title[i];
        lb.textAlignment = NSTextAlignmentCenter;
        h+= viewH/5;
        btnpaiwei.tag = 1000+i;

      [ViewScroll addSubview:btnpaiwei];
      [ViewScroll addSubview:lb];
    }
    
}

-(void)toNextView
{
    PaiweizhinanViewController *PaiweizhinanView = [[PaiweizhinanViewController alloc] init];
    [self.navigationController pushViewController:PaiweizhinanView animated:YES];
}


- (void)btnClick:(UIButton*)btn
{
    //@"长生禄位",@"怨家债主",@"往生莲位",@"家庭事业障碍登记"
    if (btn.tag==1000) {
        NSArray *arrayInfo = (NSArray *)_dicInfo;
        NSDictionary *dic = arrayInfo[_index];
        CSLWViewController *vc = [[CSLWViewController alloc] init];
        vc.vctitle = btn.titleLabel.text;
        vc.dicInfo = dic;
        [self.navigationController pushViewController:vc animated:YES];

    }
    if (btn.tag==1001) {
        
        NSArray *arrayInfo = (NSArray *)_dicInfo;
        NSDictionary *dic = arrayInfo[_index];
        yjzzViewController *vc = [[yjzzViewController alloc] init];
        vc.vctitle = btn.titleLabel.text;
        vc.dicInfo = dic;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag==1002) {
        WangshenglianweiViewController *vc = [[WangshenglianweiViewController alloc] init];
        NSArray *arrayInfo = (NSArray *)_dicInfo;
        NSDictionary *dic = arrayInfo[_index];
        vc.vctitle = btn.titleLabel.text;
        vc.dicInfo = dic;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag==1003) {
      //jtsyzaViewController
        NSArray *arrayInfo = (NSArray *)_dicInfo;
        NSDictionary *dic = arrayInfo[_index];
        jtsyzaViewController *vc = [[jtsyzaViewController alloc] init];
        vc.vctitle = btn.titleLabel.text;
        vc.dicInfo = dic;
        [self.navigationController pushViewController:vc animated:YES];

    }
    
    
    
}


@end
