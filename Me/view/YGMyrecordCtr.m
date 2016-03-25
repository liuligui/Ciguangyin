//
//  MyrecordViewController.m
//  Ciguangyin
//
//  Created by mac on 15/7/10.
//  Copyright (c) 2015年 ddsw. All rights reserved.
//

#import "YGMyrecordCtr.h"
#import "YGMyAppointmentCtr.h"
#import "YGRegistPaiWeiCtr.h"
#import "YGZhiBingCtr.h"
#import "YGGongDeCtr.h"

@interface YGMyrecordCtr ()

@end

@implementation YGMyrecordCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i=0; i<3; i++) {
        NSArray *arr = @[@"用户预约",@"牌位登记",@"健康关怀"];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, i*41, SCREEN_W, 40)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = 110 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *seperatorLine = [[UILabel alloc]initWithFrame:CGRectMake(0, (i+1)*40, SCREEN_W, 0.7)];
        seperatorLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:btn];
        [self.view addSubview:seperatorLine];

    }
}

-(void)btnClick:(UIButton *)btn{
    
    if (btn.tag == 110) {
        NSLog(@"用户预约");
        YGMyAppointmentCtr *ctr1 = [[YGMyAppointmentCtr alloc]init];
        ctr1.navigationItem.title = @"用户预约";
        [self.navigationController pushViewController:ctr1 animated:YES];
    }else if (btn.tag == 111){
        NSLog(@"牌位登记");
        YGRegistPaiWeiCtr *ctr2 = [[YGRegistPaiWeiCtr alloc]init];
        ctr2.navigationItem.title = @"牌位登记";
        [self.navigationController pushViewController:ctr2 animated:YES];

    }else if (btn.tag == 112){
        NSLog(@"请法治病");
        YGZhiBingCtr *ctr3 = [[YGZhiBingCtr alloc]init];
        ctr3.navigationItem.title = @"健康关怀";
        [self.navigationController pushViewController:ctr3 animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}
-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
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
