






//
//  LgModifyPwdController.m
//  HomeAdorn
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "LgModifyPwdController.h"
#import "LoginViewController.h"
@interface LgModifyPwdController ()

@end

@implementation LgModifyPwdController
-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)btnOK:(id)sender {
    
    
    [[CommonFunctions sharedlnstance] change:_phone Password:_pwd2.text requestBlock:^(NSObject *requestData, BOOL IsError) {
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            
            if ([[dic[@"msg"] stringValue] isEqualToString:@"1"]) {
                HUD.mode = MBProgressHUDModeText;
                [HUD setLabelText:@"修改成功！"];
                [HUD show:YES];
                [HUD hide:YES afterDelay:1];
                LoginViewController *vc = [[LoginViewController alloc] init];
                [self presentViewController:vc animated:NO completion:^{
                    
                }];
            }
            else
            {
                HUD.mode = MBProgressHUDModeText;
                [HUD setLabelText:@"修改失败！"];
                [HUD hide:YES afterDelay:1];
            }
        }
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
