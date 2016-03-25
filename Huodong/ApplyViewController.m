//
//  ApplyViewController.m
//  HomeAdorn
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "ApplyViewController.h"

@interface ApplyViewController ()

@end

@implementation ApplyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)InitNavigation{
    [super InitNavigation];
    self.title = @"修改密码";
    [NavLeftBtn setImage:[UIImage imageNamed:@"Backtrack"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [NavRightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [NavRightBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        NSLog(@"保存");
        
        UITextField *old = (UITextField *)[self.view viewWithTag:10000];
        UITextField *new = (UITextField *)[self.view viewWithTag:10001];
        UITextField *new1 = (UITextField *)[self.view viewWithTag:10002];
        
        [old resignFirstResponder];
        [new resignFirstResponder];
        [new1 resignFirstResponder];
        HUD.mode = MBProgressHUDModeCustomView;
        if (old.text.length > 0 && new.text.length > 0 && new1.text.length > 0) {
            if ([old.text isEqualToString:[userDefaults objectForKey:@"password"]]) {
                if ([new.text isEqualToString:new1.text]) {
                    [self updatePassword:old.text password:new.text password1:new1.text];
                }else{
                    HUD.labelText = @"新密码与确认密码不一致";
                    [HUD show:YES];
                    [HUD hide:YES afterDelay:1];
                }
            }else{
                HUD.labelText = @"原始密码不正确";
                [HUD show:YES];
                [HUD hide:YES afterDelay:1];
            }
        }else{
            
            if (old.text.length == 0) {
                HUD.labelText = @"请输入原始密码";
            }else if (new.text.length == 0){
                HUD.labelText = @"请输入新密码";
            }else if (new1.text.length == 0){
                HUD.labelText = @"请输入确认密码";
            }
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
        }
    }];
}

-(void)InitControl{
    NSArray *titleArray = @[@"原始密码",@"新 密 码",@"确认密码"];
    float y = 20;
    for (int i = 0; i < titleArray.count; i++) {
        UIView *lines = [[UIView alloc] initWithFrame:CGRectMake(y > 20 ? 20:0, y, winsize.width, .5)];
        lines.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:lines];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, y+10, 80, 20)];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.text = [NSString stringWithFormat:@"%@：",titleArray[i]];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:titleLabel];
        
        UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, y+10, winsize.width - 100, 20)];
        passwordTextField.secureTextEntry = YES;
        passwordTextField.placeholder = [NSString stringWithFormat:@"请输入%@",titleArray[i]];
        passwordTextField.font = [UIFont systemFontOfSize:14];
        passwordTextField.tag = 10000+i;
        [self.view addSubview:passwordTextField];
        
        y += 40;
        
        if (i == 2) {
            UIView *bottomlines = [[UIView alloc] initWithFrame:CGRectMake(0, y, winsize.width, .5)];
            bottomlines.backgroundColor = [UIColor lightGrayColor];
            [self.view addSubview:bottomlines];
        }
        
    }
}

-(void)updatePassword:(NSString *)old password:(NSString *)new password1:(NSString *)new1{
    [HUD show:YES];
    [[CommonFunctions sharedlnstance] updatePassword:[userDefaults objectForKey:@"verification"] OLD:old New:new New1:new1 requestBlock:^(NSObject *requestData, BOOL IsError) {
        if (!IsError) {
            NSDictionary *dic = (NSDictionary *)requestData;
            if ([[[dic objectForKey:@"result"] stringValue] isEqualToString:@"1"]) {
                [HUD hide:YES];
                [userDefaults setObject:@"" forKey:@"verification"];
                [userDefaults setObject:@"" forKey:@"password"];
                [userDefaults setObject:@"" forKey:@"userInfo"];
                [userDefaults synchronize];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                HUD.mode = MBProgressHUDModeText;
                [HUD setLabelText:@"获取失败！"];
                [HUD hide:YES afterDelay:1];
            }
        }else{
            HUD.mode = MBProgressHUDModeText;
            [HUD setLabelText:(NSString *)requestData];
            [HUD hide:YES afterDelay:1];
        }
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    for (UIView *v in self.view.subviews) {
        if (touch.view != v) {
            [((UITextField *)[self.view viewWithTag:10000]) resignFirstResponder];
            [((UITextField *)[self.view viewWithTag:10001]) resignFirstResponder];
            [((UITextField *)[self.view viewWithTag:10002]) resignFirstResponder];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end