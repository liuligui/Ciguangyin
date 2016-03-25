//
//  YGRegisteCtr.m
//  HomeAdorn
//
//  Created by wangxiaoer on 7/25/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import "YGRegisteCtr.h"
#import "MBProgressHUD+MJ.h"
#import "Globle.h"
@interface YGRegisteCtr ()
{
    NSString *msmcode;
    int Seconde;
    NSString *code;
     NSTimer *countDownTimer;
}
@property(nonatomic,strong)UITextField *phoneText;
@property(nonatomic,strong)UITextField *verificationCodeText;
@property(nonatomic,strong)UITextField *pwdText;
@property(nonatomic,strong)UITextField *repwdText;
@property(nonatomic,strong)UIButton *getCodeBt;
@property(nonatomic,strong)UILabel *getCodeLabel;
@property (nonatomic, strong) NSTimer       *timerNum;
@property (nonatomic,copy) NSString *lastNumber;//上次发送手机号

@property (nonatomic) int          timeCount;
@property (nonatomic,strong) IBOutlet UIImageView *bgView;
- (IBAction)sureBtnClick:(id)sender;


@end

@implementation YGRegisteCtr

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self UIInit];
}
-(void)OutView
{
    [_phoneText resignFirstResponder];
    [_verificationCodeText resignFirstResponder];
    [_phoneText resignFirstResponder];
    [_pwdText resignFirstResponder];
    [_repwdText resignFirstResponder];
    
}
- (IBAction)btnhid:(id)sender {
    
    [self OutView];
}
- (IBAction)btnout:(id)sender {
    
}

-(void)UIInit
{

    
    
    Seconde = 60;
    UIImageView * leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0,6,32,32)];
    [leftView setImage:[UIImage imageNamed:@"icon_phone"]];
    UIImageView * rightView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,100,35)];
    rightView.backgroundColor = [UIColor orangeColor];
    //手机号
    _phoneText = [[UITextField alloc]initWithFrame:CGRectMake(10, 40+50, 300, 37)];
    _phoneText.leftView = leftView;
    _phoneText.leftViewMode = UITextFieldViewModeAlways;
    _phoneText.rightView = rightView;
    _phoneText.rightViewMode = UITextFieldViewModeAlways;
    _phoneText.layer.masksToBounds = YES;
    _phoneText.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _phoneText.layer.cornerRadius = 5.0;
    _phoneText.layer.borderWidth = 1.0;
    _phoneText.tag = 1;
    _phoneText.returnKeyType = UIReturnKeyNext;
    _phoneText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneText.placeholder = [NSString stringWithFormat:@"请输入手机号码"];
    _phoneText.font = kFont(14);
    _phoneText.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneText];
    //请输入验证码
    UIImageView * leftViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0,6,32,32)];
    [leftViewTwo setImage:[UIImage imageNamed:@"icon_edit"]];
    _verificationCodeText = [[UITextField alloc]initWithFrame:CGRectMake(10, 90+50, 300, 37)];
    _verificationCodeText.leftView = leftViewTwo;
    _verificationCodeText.leftViewMode = UITextFieldViewModeAlways;
    _verificationCodeText.layer.cornerRadius = 5.0;
    _verificationCodeText.layer.masksToBounds = YES;
    _verificationCodeText.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _verificationCodeText.layer.borderWidth = 1.0f;
    _verificationCodeText.returnKeyType = UIReturnKeyDone;
    _verificationCodeText.placeholder = [NSString stringWithFormat:@"请输入验证码"];
    _verificationCodeText.textColor = [UIColor blackColor];
    _verificationCodeText.font = kFont(14);
    _verificationCodeText.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_verificationCodeText];
    //请输入密码
    UIImageView * leftViewThree = [[UIImageView alloc] initWithFrame:CGRectMake(0,6,32,32)];
    [leftViewThree setImage:[UIImage imageNamed:@"icon_edit"]];
    _pwdText = [[UITextField alloc]initWithFrame:CGRectMake(10, 140+50, 300, 37)];
    _pwdText.leftView = leftViewThree;
    _pwdText.leftViewMode = UITextFieldViewModeAlways;
    _pwdText.layer.cornerRadius = 5.0;
    _pwdText.layer.masksToBounds = YES;
    _pwdText.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _pwdText.layer.borderWidth = 1.0f;
    _pwdText.returnKeyType = UIReturnKeyDone;
    _pwdText.placeholder = [NSString stringWithFormat:@"请输入密码"];
    _pwdText.textColor = [UIColor blackColor];
    _pwdText.secureTextEntry = YES;
    _pwdText.font = kFont(14);
    [self.view addSubview:_pwdText];
    //请再次输入密码
    UIImageView * leftViewFour = [[UIImageView alloc] initWithFrame:CGRectMake(0,6,32,32)];
    [leftViewFour setImage:[UIImage imageNamed:@"icon_edit"]];
    _repwdText = [[UITextField alloc]initWithFrame:CGRectMake(10, 190+50, 300, 37)];
    _repwdText.leftView = leftViewFour;
    _repwdText.leftViewMode = UITextFieldViewModeAlways;
    _repwdText.layer.cornerRadius = 5.0;
    _repwdText.layer.masksToBounds = YES;
    _repwdText.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _repwdText.layer.borderWidth = 1.0f;
    _repwdText.returnKeyType = UIReturnKeyDone;
    _repwdText.placeholder = [NSString stringWithFormat:@"请再次输入密码"];
    _repwdText.textColor = [UIColor blackColor];
    _repwdText.secureTextEntry = YES;
    _repwdText.font = kFont(14);
    [self.view addSubview:_repwdText];

    // 点击获取验证码
    _getCodeBt = [[UIButton alloc] initWithFrame:CGRectMake(211, 42+50, 95, 33)];
    [_getCodeBt setBackgroundColor:[UIColor clearColor]];
    _getCodeBt.layer.borderColor = (__bridge CGColorRef)([UIColor whiteColor]);
    _getCodeBt.layer.borderWidth = 1;
    [_getCodeBt setTitle:@"点击获取" forState:UIControlStateNormal];
    [_getCodeBt setFont:[UIFont systemFontOfSize:12]];
    [_getCodeBt addTarget:self action:@selector(clickGetCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getCodeBt];
    
   }

-(void)clickGetCode
{
    //校验手机号码
    if (![AppUtils isValidateMobile:_phoneText.text]) {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"温馨提示"
                                                     andMessage:@"请输入正确的手机号码"];
        [alert setTransitionStyle:SIAlertViewTransitionStyleSlideFromTop];
        [alert addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alert){
            [_phoneText becomeFirstResponder];
        }];
        [alert show];
        return;
    }

    NSString *phone= _phoneText.text;
    [[CommonFunctions sharedlnstance] getmsmCode:phone reg:@"1" requestBlock:^(NSObject *requestData, BOOL IsError) {
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
            else
            {
                [MBProgressHUD showSuccess: dic[@"msg_cfg"]];
            }
            
        }
        
    }];
 
}
-(void)timeFireMethod:(NSTimer *)time{
    Seconde--;
    
    _getCodeBt.titleLabel.hidden = YES;
    _getCodeBt.enabled = NO;
    _phoneText.enabled = NO;
    [_getCodeBt setTitle:[NSString stringWithFormat:@"%d秒后获取",Seconde] forState:UIControlStateDisabled];
    if (Seconde == 0) {
        Seconde = 60;
        [_getCodeBt setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeBt.titleLabel.hidden = NO;
        _getCodeBt.enabled = YES;
        [countDownTimer invalidate];
        countDownTimer = nil;
    }
}

//注册密码校验
-(BOOL)checkPWD{
    
    if (([_pwdText.text length]==0)) {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"温馨提示"
                                                     andMessage:@"请输入密码"];
        [alert setTransitionStyle:SIAlertViewTransitionStyleSlideFromTop];
        [alert addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alert){
            [_pwdText becomeFirstResponder];
        }];
        [alert show];
        return NO;
    }
    
    //密码长度
    if (MIN_LEN_OF_PWD > [_pwdText.text length]) {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"温馨提示"
                                                     andMessage:[NSString stringWithFormat:@"密码长度至少为%d位。",MIN_LEN_OF_PWD]];
        [alert setTransitionStyle:SIAlertViewTransitionStyleSlideFromTop];
        [alert addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alert){
            [_pwdText becomeFirstResponder];
        }];
        [alert show];
        return NO;
    }
    
    if ([_pwdText.text length] > MAX_LEN_OF_PWD) {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"温馨提示"
                                                     andMessage:[NSString stringWithFormat:@"密码长度最长为%d位。",MAX_LEN_OF_PWD]];
        [alert setTransitionStyle:SIAlertViewTransitionStyleSlideFromTop];
        [alert addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alert){
            [_pwdText becomeFirstResponder];
        }];
        [alert show];
        return NO;
    }
    
    if (![_pwdText.text isEqualToString:_repwdText.text]) {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"温馨提示"
                                                     andMessage:[NSString stringWithFormat:@"两次密码不一致"]];
        [alert setTransitionStyle:SIAlertViewTransitionStyleSlideFromTop];
        [alert addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alert){
            [_repwdText becomeFirstResponder];
        }];
        [alert show];
        return NO;
    }
    
    return YES;
}


-(void)updateNums
{

    if (_timeCount > 1) {
        --_timeCount;
        _getCodeLabel.text =[NSString stringWithFormat:@"%d(S)",_timeCount];
        _getCodeBt.enabled = NO;

    }else{
        _timeCount = 60;
        [_timerNum invalidate];
        _getCodeBt.enabled = YES;
        _getCodeLabel.text = [NSString stringWithFormat:@"点击重新获取"];
        
    }
    return;
}
- (IBAction)btnback:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)zhuce:(id)sender {
   

}

- (IBAction)sureBtnClick:(id)sender {
    
    if ([_verificationCodeText.text isEqualToString:msmcode]) {
        
        [[CommonFunctions sharedlnstance] userregist:_phoneText.text pws:_pwdText.text requestBlock:^(NSObject *requestData, BOOL IsError) {
            [HUD hide:YES];
            NSDictionary *rd= (NSDictionary *)requestData;
            if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
            {
                [MBProgressHUD showSuccess:@"注册成功！"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [Globle shareInstance].user_id =_phoneText.text;
                    [Globle shareInstance].user_id =_phoneText.text; ;
                    [Globle shareInstance].user_sign =@"";
                    [Globle shareInstance].fansNum =@"0";
                    [Globle shareInstance].userid =_phoneText.text;
                    [Globle shareInstance].message =@"";
                    [Globle shareInstance].user_static =@"";
                    [Globle shareInstance].user_name =@"";
                    [Globle shareInstance].token =@"";
                    [Globle shareInstance].gzNum =@"0";
                    [Globle shareInstance].login_time =@"";
                    

                    
                    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
                    //[delegate backToTFAgent];
                    [delegate backToMain];
                });
               
            }
            else
            {//msg_cfg
                 [MBProgressHUD showError:rd[@"msg_cfg"]];
                
            }
            
        }];
    }
    else
    {

        [MBProgressHUD showError:@"请完善信息！"];
    }
 }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
