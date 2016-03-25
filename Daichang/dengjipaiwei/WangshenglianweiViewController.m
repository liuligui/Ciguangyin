//
//  WangshenglianweiViewController.m
//  HomeAdorn
//
//  Created by mac on 15/7/19.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "WangshenglianweiViewController.h"
#import "CSLWViewController.h"
#import "ptwslwViewController.h"
#import "lcdtylpwViewController.h"
#import "fzcswzlpwViewController.h"
#import "tsjbViewController.h"
#import "tshyzViewController.h"
#import "cdhjViewController.h"
@interface WangshenglianweiViewController ()
{
    UIScrollView *ViewScroll;

}
@end

@implementation WangshenglianweiViewController

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
    NSArray *title =@[@"普通往生莲位",@"流产、堕胎婴灵牌位",@"非正常死亡者牌位",@"特殊疾病者牌位",@"特殊行业者牌位",@"超度合家牌位"];
    NSArray *btnImage =@[@"lianweitop",@"lianweim",@"lianweim",@"lianweim",@"lianweim",@"lianwieb"];
    int h=20;
    for (int i=0; i<btnImage.count; i++) {
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, h, viewW-40, viewH/7)];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setFont:[UIFont systemFontOfSize:14]];
        [btn setImage:[UIImage imageNamed:btnImage[i]] forState:UIControlStateNormal];
        [btn setTitle:title[i] forState:UIControlStateNormal];

        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
//        btn.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,btn.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
//        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -550, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        btn.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
//        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化
        [ViewScroll addSubview:btn];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, h+viewH/14-6, viewW, 13)];
        lb.font = [UIFont systemFontOfSize:12];
        lb.text = title[i];
        lb.textAlignment = NSTextAlignmentCenter;
        [ViewScroll addSubview:lb];
        
        h+= (viewH-40)/7;
        btn.tag = 1000+i;
        
        UIImageView *imagelogo = [[UIImageView alloc] initWithFrame:CGRectMake(40, h- (viewH-40)/7+10, 30, viewH/10)];
        [imagelogo setImage:[UIImage imageNamed:@"paiwei"]];
        [ViewScroll addSubview:imagelogo];

        
    }
    
}




- (void)btnClick:(UIButton*)btn
{
    //@"长生禄位",@"怨家债主",@"往生莲位",@"家庭事业障碍登记"
    if (btn.tag==1000) {
        ptwslwViewController *vc = [[ptwslwViewController alloc] init];
     
        vc.vctitle = btn.titleLabel.text;
        vc.dicInfo = _dicInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag==1001) {
        lcdtylpwViewController *vc = [[lcdtylpwViewController alloc] init];
        vc.vctitle = btn.titleLabel.text;
        vc.dicInfo = _dicInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag==1002) {
        fzcswzlpwViewController *vc = [[fzcswzlpwViewController alloc] init];
        vc.vctitle = btn.titleLabel.text;
        vc.dicInfo = _dicInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag==1003) {
        tsjbViewController *vc = [[tsjbViewController alloc] init];
        vc.vctitle = btn.titleLabel.text;
        vc.dicInfo = _dicInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag==1004) {
        tshyzViewController *vc = [[tshyzViewController alloc] init];
        vc.vctitle = btn.titleLabel.text;
        vc.dicInfo = _dicInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (btn.tag==1005) {
        cdhjViewController *vc = [[cdhjViewController alloc] init];
        vc.vctitle = btn.titleLabel.text;
        vc.dicInfo = _dicInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}




@end
