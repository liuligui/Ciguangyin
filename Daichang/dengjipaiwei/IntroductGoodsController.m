


//
//  IntroductGoodsController.m
//  HomeAdorn
//
//  Created by mac on 15/7/22.
//  Copyright (c) 2015年 IWork. All rights reserved.
//
#import "UIImageView+MJWebCache.h"
#import "IntroductGoodsController.h"
#import "Globle.h"
@interface IntroductGoodsController ()

@end

@implementation IntroductGoodsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)InitNavigation{
    self.title = @"结缘品介绍";
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
    NSDictionary *dic = [Globle shareInstance].end[_i];
    UIImageView  *topview =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH/3)];
    
    NSString *dd = [IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url_big"]] ;
    [topview setImageURLStr:dd  placeholder:[UIImage imageNamed:@"defaultcgy"]];
    [self.view addSubview:topview];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10,  viewH/3 + 10, viewW-20,viewH - viewH/3+10)];
    lb.numberOfLines = 0;
    lb.font = [UIFont systemFontOfSize:13];
    lb.textAlignment = NSTextAlignmentLeft;
    lb.text =dic[@"jy_xq"];
    [self.view addSubview:lb];
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
