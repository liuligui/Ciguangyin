

//
//  ApplyGameViewController.m
//  HomeAdorn
//
//  Created by mac on 15/7/19.
//  Copyright (c) 2015年 IWork. All rights reserved.
//
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "ApplyGameViewController.h"
#import "Globle.h"
#import "cityPickerViewController.h"
@interface ApplyGameViewController ()<setcityDelegate>

{
    UIButton *btnaddress;
}
@end

@implementation ApplyGameViewController

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
    self.title = @"我要报名";
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];

    
    ;
}

-(void)InitControl{
    NSArray *titleArray = @[@"填表人姓名",@"手机号码",@"地址",@"备注"];
    float y = 20;
    for (int i = 0; i < titleArray.count; i++) {
        UIView *lines = [[UIView alloc] initWithFrame:CGRectMake(y > 20 ? 20:0, y, winsize.width, .5)];
        lines.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:lines];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, y+10, 100, 20)];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.text = [NSString stringWithFormat:@"%@：",titleArray[i]];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:titleLabel];
        if (i!=2) {
            UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, y+5, winsize.width - 100, 40)];
            passwordTextField.placeholder = [NSString stringWithFormat:@"请输入%@",titleArray[i]];
            passwordTextField.font = [UIFont systemFontOfSize:14];
            passwordTextField.tag = 10000+i;
            passwordTextField.delegate = self;
            if (i==1) {
                passwordTextField.keyboardType = UIKeyboardTypePhonePad;
            }
            [self.view addSubview:passwordTextField];
            
            y += 40;
        }
        
        if (i==2) {
            UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, y+5, winsize.width - 100, 40)];
            passwordTextField.placeholder = [NSString stringWithFormat:@"请输入%@",titleArray[i]];
            passwordTextField.font = [UIFont systemFontOfSize:14];
            passwordTextField.tag = 10000+i;
            passwordTextField.delegate = self;
            [self.view addSubview:passwordTextField];

            btnaddress = [[UIButton alloc] initWithFrame:CGRectMake(110, y+5, winsize.width - 100, 40)];
            y += 40;
             btnaddress.tag = 10000+i;
            btnaddress.titleLabel.textAlignment =NSTextAlignmentLeft;
             btnaddress.font = [UIFont systemFontOfSize:14];
            [btnaddress addTarget:self action:@selector(chooseaddreess) forControlEvents:UIControlEventTouchUpInside];

            [self.view addSubview:btnaddress];
        }
        
        if (i == 3) {
            UIView *bottomlines = [[UIView alloc] initWithFrame:CGRectMake(0, y, winsize.width, .5)];
            bottomlines.backgroundColor = [UIColor lightGrayColor];
            [self.view addSubview:bottomlines];
        }
        
    }
        
    UIButton *btnbaoming = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, viewW-60, 40)];
    [btnbaoming setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnbaoming setFont:[UIFont systemFontOfSize:12]];
    [btnbaoming setImage:[UIImage imageNamed:@"btnmo"] forState:UIControlStateNormal];
    [btnbaoming setTitle:@"提交" forState:UIControlStateNormal];
    [btnbaoming setImage:[UIImage imageNamed:@"btnhi"] forState:UIControlStateHighlighted];
    btnbaoming.titleEdgeInsets = UIEdgeInsetsMake(0, -540,0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
    [btnbaoming setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnbaoming.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    btnbaoming.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btnbaoming addTarget:self action:@selector(btnp:) forControlEvents:(UIControlEventTouchUpInside)];

     [self.view addSubview:btnbaoming];
    
    
}

-(void)chooseaddreess
{
    cityPickerViewController *citypick = [[cityPickerViewController alloc] init];
    citypick.delegate =self;
    [self.navigationController pushViewController:citypick animated:YES];
}
-(void)setcity:(NSString *)city
{
    UITextField *new1 = (UITextField *)[self.view viewWithTag:10002];
    new1.text = city;
}

-(void)btnp:(UIButton *)btn
{
    
        if ([self verfy]) {
            [self btnp];
        }
 
    
}

-(void)btnp
{

    //action_id、tbr、phone、address、remarke
    UITextField *old = (UITextField *)[self.view viewWithTag:10000];
    UITextField *new = (UITextField *)[self.view viewWithTag:10001];
    UITextField *new1 = (UITextField *)[self.view viewWithTag:10002];
    UITextField *new2 = (UITextField *)[self.view viewWithTag:10003];

   
    NSString *string = [NSString stringWithFormat:@"%@%@",ServiceAddress,@"cgy/appAction/actionBm.do"];
    NSURL *url = [NSURL URLWithString:string];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:_dicInfo[@"id"] forKey:@"action_id"];
    [request setPostValue:old.text forKey:@"tbr"];
    [request setPostValue:new.text forKey:@"phone"];
    [request setPostValue:new1 forKey:@"address"];
     [request setPostValue:new2.text forKey:@"address"];
    [request setPostValue:[Globle shareInstance].user_id  forKey:@"user_number"];
    request.delegate = self;
    //异步发送请求
    [request startAsynchronous];
    
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *re = request.responseString;
    NSDictionary *rd = [re JSONValue];
    if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
    {
        HUD.mode = MBProgressHUDModeText;
        [HUD setLabelText:@"报名成功！"];
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
        [HUD setLabelText:@"报名失败！"];
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }
    
    
}

-(BOOL)verfy
{
    UITextField *old = (UITextField *)[self.view viewWithTag:10000];
    UITextField *new = (UITextField *)[self.view viewWithTag:10001];
    UITextField *new1 = (UITextField *)[self.view viewWithTag:10002];
    UITextField *new2 = (UITextField *)[self.view viewWithTag:10003];
    
    [old resignFirstResponder];
    [new resignFirstResponder];
    [new1 resignFirstResponder];
    [new2 resignFirstResponder];
    HUD.mode = MBProgressHUDModeCustomView;
    
    
    if (old.text.length == 0) {
        HUD.labelText = @"请输入姓名";
        return false;
    }else if (new.text.length == 0){
        HUD.labelText = @"请输入手机号码";
        return false;
    }else if (new1.text.length == 0){
        HUD.labelText = @"请输入地址";
        return false;
    }
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
    
    return true;
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
            [((UITextField *)[self.view viewWithTag:10003]) resignFirstResponder];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
