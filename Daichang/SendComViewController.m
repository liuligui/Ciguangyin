


//
//  SendComViewController.m
//  HomeAdorn
//
//  Created by mac on 15/7/19.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "SendComViewController.h"

@interface SendComViewController ()

@end

@implementation SendComViewController

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
    [NavRightBtn  setFrame:CGRectMake(0, 0, 80, 25)];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    [NavRightBtn setTitle:@"发表" forState:UIControlStateNormal];
    [NavRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [NavRightBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        
   
    }];
    
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
