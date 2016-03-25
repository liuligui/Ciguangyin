//
//  ModifyPwdController.m
//  HomeAdorn
//
//  Created by mac on 15/7/26.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "ModifyPwdController.h"

@interface ModifyPwdController ()

@end

@implementation ModifyPwdController
-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
}

- (void)viewDidLoad {
    _pwd1.delegate = self;
    _pwd2.delegate = self;
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
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    // 移除遮盖
                    [self.navigationController popViewControllerAnimated:YES];
                    return ;
                });
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
