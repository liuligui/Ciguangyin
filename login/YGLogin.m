
//
//  YGLogin.m
//  HomeAdorn
//
//  Created by wangxiaoer on 7/25/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import "YGLogin.h"
#import "ElvyoHomeController.h"

@interface YGLogin ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
- (IBAction)registe:(id)sender;
- (IBAction)forgestPwd:(id)sender;
- (IBAction)sureBtnClick:(id)sender;
- (IBAction)WXlogin:(id)sender;
- (IBAction)QQlogin:(id)sender;


@end

@implementation YGLogin

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bgImageView.layer.cornerRadius = 5.0;
    _bgImageView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _bgImageView.layer.borderWidth = 0.5;
    
    UILabel *separateLine = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 260, 1)];
    separateLine.backgroundColor = theme_bg_color;
    [_bgImageView addSubview:separateLine];
}


- (IBAction)registe:(id)sender {
}

- (IBAction)forgestPwd:(id)sender {
}

- (IBAction)sureBtnClick:(id)sender {
    
    [self.navigationController pushViewController:[[ElvyoHomeController alloc] init] animated:YES];
}

- (IBAction)WXlogin:(id)sender {
}

- (IBAction)QQlogin:(id)sender {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
