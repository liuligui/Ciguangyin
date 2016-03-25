



//
//  GetCodeViewController.m
//  HomeAdorn
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "GetCodeViewController.h"
#import "LgModifyPwdController.h"
#import "SIAlertView.h"
#import "MBProgressHUD+MJ.h"
@interface GetCodeViewController ()
{
    NSString *msmcode;
    int Seconde;
    UIButton *getCodeBt;
    NSTimer *countDownTimer;
    
}


@property (nonatomic,strong) UITextField    *phoneTextField;
@property (nonatomic,strong) UITextField    *rePwdField;
@property (nonatomic,strong) UITextField    *verificationCodeTextField;
@property (nonatomic,strong) UITextField    *contain;



//验证码
@property (nonatomic, strong) NSTimer       *timerNum;
@property (nonatomic) int                   timeCount;

@property (nonatomic,strong) UIButton *loginBt;

@property (nonatomic,copy) NSString *lastNumber;//上次发送手机号

@end


@implementation GetCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self UIInit];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_timerNum invalidate];
}

-(void)btnb
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)UIInit
{
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    top.backgroundColor = [UIColor grayColor];
    [self.view addSubview:top];
    
    UIButton *btnback = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 25, 25)];
    [btnback setBackgroundImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [btnback addTarget:self action:@selector(btnb) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnback];

    
    UIView *inputBg = [[UIView alloc]initWithFrame:CGRectMake(0, 64, viewW, viewH*0.5)];
    inputBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:inputBg];
    
    UIImageView * leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0,6,32,32)];
    [leftView setImage:[UIImage imageNamed:@"icon_phone"]];
    UIImageView * rightView = [[UIImageView alloc] initWithFrame:CGRectMake(0,200,100,44)];
    rightView.backgroundColor = [UIColor orangeColor];
    //手机号
    _phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 70, 300, 44)];
    _phoneTextField.leftView = leftView;
    _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    _phoneTextField.rightView = rightView;
    _phoneTextField.rightViewMode = UITextFieldViewModeAlways;
    _phoneTextField.layer.masksToBounds = YES;
    _phoneTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _phoneTextField.layer.cornerRadius = 5.0;
    _phoneTextField.layer.borderWidth = 1.0;
    _phoneTextField.tag = 1;
    _phoneTextField.returnKeyType = UIReturnKeyNext;
    _phoneTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneTextField.placeholder = [NSString stringWithFormat:@"请输入手机号码"];
    //    [_phoneTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];//设置placeholder的颜色
    _phoneTextField.font = kFont(16);
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [inputBg addSubview:_phoneTextField];
    
    UIImageView * leftViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0,6,32,32)];
    [leftViewTwo setImage:[UIImage imageNamed:@"icon_edit"]];
    _verificationCodeTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 140, SCREEN_W - 20, 44)];
    _verificationCodeTextField.leftView = leftViewTwo;
    _verificationCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    _verificationCodeTextField.layer.cornerRadius = 5.0;
    _verificationCodeTextField.layer.masksToBounds = YES;
    _verificationCodeTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _verificationCodeTextField.layer.borderWidth = 1.0f;
    _verificationCodeTextField.returnKeyType = UIReturnKeyDone;
    _verificationCodeTextField.placeholder = [NSString stringWithFormat:@"请输入验证码"];
    _verificationCodeTextField.textColor = [UIColor blackColor];
    //    _verificationCodeTextField.font = kFont(16);
    [inputBg addSubview:_verificationCodeTextField];
    
    // 点击获取验证码
    getCodeBt = [[UIButton alloc] initWithFrame:CGRectMake(210, 71, 98, 42)];
    [getCodeBt setBackgroundColor:[UIColor clearColor]];
    getCodeBt.layer.borderColor = (__bridge CGColorRef)([UIColor whiteColor]);
    getCodeBt.layer.borderWidth = 1;
    [getCodeBt setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeBt addTarget:self action:@selector(clickGetCode) forControlEvents:UIControlEventTouchUpInside];
    [inputBg addSubview:getCodeBt];
    
    
    Seconde = 60;
    
    //下一步 按钮
    UIImage *adf = [[UIImage imageNamed:@"themeColorBt"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,10, 0, 10) resizingMode:UIImageResizingModeStretch];
    
    UIButton *signUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signUpBtn.frame = CGRectMake(57,240, 206, 40);
    //    [signUpBtn setBackgroundImage:adf forState:UIControlStateNormal];
    signUpBtn.backgroundColor = [UIColor orangeColor];
    signUpBtn.layer.cornerRadius = 5.0;
    [signUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signUpBtn setTitle:@"下一步" forState:UIControlStateNormal];
    signUpBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [signUpBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [inputBg addSubview:signUpBtn];
    SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"温馨提示"andMessage:@"请输入正确的手机号码"];
}
-(void)timeFireMethod:(NSTimer *)time{
    Seconde--;
     _phoneTextField.enabled = NO;
    getCodeBt.titleLabel.hidden = YES;
    getCodeBt.enabled = NO;
    [getCodeBt setTitle:[NSString stringWithFormat:@"%d秒后获取",Seconde] forState:UIControlStateDisabled];
    if (Seconde == 0) {
        Seconde = 60;
        [getCodeBt setTitle:@"获取验证码" forState:UIControlStateNormal];
        getCodeBt.titleLabel.hidden = NO;
        getCodeBt.enabled = YES;
        [countDownTimer invalidate];
        countDownTimer = nil;
    }
}
-(void)clickGetCode{
    
    if (![AppUtils isValidateMobile:_phoneTextField.text]) {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"温馨提示"
                                                     andMessage:@"请输入正确的手机号码"];
        [alert setTransitionStyle:SIAlertViewTransitionStyleSlideFromTop];
        [alert addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alert){
            [_phoneTextField becomeFirstResponder];
        }];
        [alert show];
        
        return;
    }
    
    NSString *phone= _phoneTextField.text;
    [[CommonFunctions sharedlnstance] getmsmCode:phone reg:@"" requestBlock:^(NSObject *requestData, BOOL IsError) {
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            NSString *phone = dic[@"user_id"];
            NSString *code = dic[@"code"];
            if(phone.length>0&&code.length>0)
            {
                [MBProgressHUD showSuccess:@"获取成功！"];
                msmcode = dic[@"code"];
                if (!countDownTimer) {
                    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod:) userInfo:nil repeats:YES];
                }
                
            }
            
            
        }
        
    }];
    
    
}


-(void)nextBtnClick
{
    if (![self checkData]) {
        return;
    }
    
    LgModifyPwdController *ModifyPwd = [[LgModifyPwdController alloc] init];
    ModifyPwd.phone = _phoneTextField.text;
    [self presentViewController:ModifyPwd animated:YES completion:^{
        
    }];

    
   
}

//数据校验
-(BOOL)checkData{
    // 验证是否为手机号码
    if (![AppUtils isValidateMobile:_phoneTextField.text]) {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"温馨提示"
                                                     andMessage:@"请输入正确的手机号码"];
        [alert setTransitionStyle:SIAlertViewTransitionStyleSlideFromTop];
        [alert addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alert){
            [_phoneTextField becomeFirstResponder];
        }];
        [alert show];
        
        return NO;
    }
    
    //  验证码判断
    if (!([_verificationCodeTextField.text length]>0)) {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"温馨提示"
                                                     andMessage:@"请输入验证码"];
        [alert setTransitionStyle:SIAlertViewTransitionStyleSlideFromTop];
        [alert addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alert){
            [_verificationCodeTextField becomeFirstResponder];
        }];
        [alert show];
        return NO;
    }
    if (![msmcode isEqualToString:_verificationCodeTextField.text]) {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"温馨提示"
                                                     andMessage:@"验证码错误"];
        [alert setTransitionStyle:SIAlertViewTransitionStyleSlideFromTop];
        [alert addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alert){
            [_verificationCodeTextField becomeFirstResponder];
        }];
        [alert show];
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
