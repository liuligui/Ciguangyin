//
//  YGAddContaccCtr.m
//  HomeAdorn
//
//  Created by wangxiaoer on 7/22/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import "YGAddContaccCtr.h"
#import "Globle.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "cityPickerViewController.h"
@interface YGAddContaccCtr ()<setcityDelegate>
{
    NSString *str;
}


- (IBAction)sureBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation YGAddContaccCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    _name.delegate = self;
    _age.delegate = self;
    _gender.delegate = self;
    _idcard.delegate = self;
    _idcardaddress.delegate = self;
    _nowaddress.delegate = self;
    _phone.delegate = self;
    _email.delegate = self;
    _honephone.delegate = self;
    
    _name.text = _contactName;
    
    _scrollview.contentSize=CGSizeMake(viewW, 300);
    _address1.userInteractionEnabled=YES;
    _address1.tag = 1000;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    
    UITapGestureRecognizer *labelTapGestureRecognizer1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    
    UITapGestureRecognizer *labelTapGestureRecognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    
    UITapGestureRecognizer *labelTapGestureRecognizer3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelsexTouchUpInside:)];
    
    [_address1 addGestureRecognizer:labelTapGestureRecognizer];
    
    _address2.userInteractionEnabled=YES;
    _address2.tag = 1001;
    [_address2 addGestureRecognizer:labelTapGestureRecognizer1];
    

    _address3.userInteractionEnabled=YES;
    _address3.tag = 1002;
    [_address3 addGestureRecognizer:labelTapGestureRecognizer2];
    
    _lbsex.userInteractionEnabled=YES;
    _lbsex.tag = 1002;
    [_lbsex addGestureRecognizer:labelTapGestureRecognizer3];
    
    
}

- (IBAction)sureBtnClick:(id)sender {
    
    NSLog(@"提交");
        
    [self btnp];

}
-(void) labelsexTouchUpInside:(UITapGestureRecognizer *)recognizer{
    if ([_lbsex.text isEqualToString:@"男"]) {
        _lbsex.text = @"女";
    }
    else
    {
        _lbsex.text = @"男";
    }
}

-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
    UILabel *label=(UILabel*)recognizer.view;
    if (label.tag == 1000) {
        str = @"1";
    }
    if (label.tag == 1001) {
        str = @"2";
    }
    if (label.tag == 1002) {
        str = @"3";
    }
    NSLog(@"%@被点击了",label.text);
    cityPickerViewController *citypick = [[cityPickerViewController alloc] init];
    citypick.delegate =self;
    [self.navigationController pushViewController:citypick animated:YES];
}

-(void)setcity:(NSString *)city
{
    if ([str isEqualToString:@"1"]) {
        _address1.text = city;
    }
    if ([str isEqualToString:@"2"]) {
        _address2.text = city;
    }
    if ([str isEqualToString:@"3"]) {
        _address3.text = city;
    }
}



-(void)btnp{
    
    NSString *string = [NSString stringWithFormat:@"%@%@",ServiceAddress,@"cgy/appUserInfo/addCylxr.do"];
    NSURL *url = [NSURL URLWithString:string];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[Globle shareInstance].user_id forKey:@"user_id"];
    [request setPostValue:_name.text forKey:@"lx_name"];
    [request setPostValue:_age.text forKey:@"lx_age"];
    if ([_lbsex.text isEqualToString:@"男"]) {
        [request setPostValue: @"1" forKey:@"lx_sex"];
    }
    else
    {
        [request setPostValue: @"2" forKey:@"lx_sex"];
    }
    [request setPostValue:_idcard.text forKey:@"lx_id"];
    [request setPostValue:_address1.text forKey:@"id_address"];
    [request setPostValue:_address2.text forKey:@"now_address"];
    [request setPostValue:_phone.text forKey:@"phone"];
    [request setPostValue:_email.text forKey:@"lx_email"];
    [request setPostValue:_honephone.text forKey:@"other_phone"];
    [request setPostValue:_address3.text forKey:@"other_address"];
    
    
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
        [HUD setLabelText:@"提交成功！"];
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
        [HUD setLabelText:@"提交失败！"];
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }
    
    
}



-(void)InitNavigation{
    [super InitNavigation];
    self.navigationItem.title = @"增加联系人";
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
