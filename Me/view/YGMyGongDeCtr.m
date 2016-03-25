
//
//  YGMyGongDeCtr.m
//  HomeAdorn
//
//  Created by wangxiaoer on 7/23/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import "YGMyGongDeCtr.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "APAuthV2Info.h"
@interface YGMyGongDeCtr ()

@property (weak, nonatomic) IBOutlet UITextField *text;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
- (IBAction)btn1:(id)sender;
- (IBAction)btn2:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *text1;

@end

@implementation YGMyGongDeCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgb_color(239, 239, 244, 1);
    _text.delegate = self;
    _text1.delegate = self;
//    UITextField *btn = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
//    btn.backgroundColor = [UIColor redColor];
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(textClick) forControlEvents:UIControlEventTouchUpInside];
//    [_text1 addTarget:self action:@selector(textClick) forControlEvents:UIControlEventTouchUpInside];
    UILabel *leftView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 26)];
    //leftView.backgroundColor = [UIColor greenColor];
    _text1.leftView = leftView;
}

- (IBAction)btn1:(id)sender {
    
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"bg_merit_normal"] forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"bg_merit_normal"] forState:UIControlStateNormal];
    [sender setBackgroundImage:[UIImage imageNamed:@"bg_merit_pressed"] forState:UIControlStateNormal];
}

- (IBAction)btn2:(id)sender {
    
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"bg_merit_normal"] forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"bg_merit_normal"] forState:UIControlStateNormal];
    [sender setBackgroundImage:[UIImage imageNamed:@"bg_merit_pressed"] forState:UIControlStateNormal];
}
- (IBAction)paybtn:(id)sender {
    
    [self Pay];
}

-(void)textClick{
    
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"bg_merit_normal"] forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"bg_merit_normal"] forState:UIControlStateNormal];
//    [_text1 setBackgroundImage:[UIImage imageNamed:@"bg_merit_pressed.9"] forState:UIControlStateNormal];
    [_text1 setBackground:[UIImage imageNamed:@"bg_merit_pressed"]];
}

-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    //    [NavRightBtn  setFrame:CGRectMake(0, 0, 65, 30)];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    //    [NavRightBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    //    [NavRightBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    //    [NavRightBtn addTarget:self action:@selector(modifyPwd) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark -
#pragma mark   ==============点击订单模拟支付行为==============
//
//选中商品调用支付宝极简支付
//
- (void)Pay
{
    
    NSString *d = _text.text;  //留言
    NSString *d1 = _text1.text;//其他金额
    
    
    /*
     *点击获取prodcut实例并初始化订单信息
     */
 //   Product *product = [self.productList objectAtIndex:indexPath.row];
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088911429928915";
    NSString *seller = @"aiyupaopao@aliyun.com";
    NSString *privateKey = @"MIICeQIBADANBgkqhkiG9w0BAQEFAASCAmMwggJfAgEAAoGBAMaefKIRfQrr5oWXi09cNaqP4PREr9BYRdBziw9CYJL78fYSLLOmdqsAp+o0emwjOfLUb/Leo8TxS0gYYjS/v+QHq7n3S9km21MxEOoP6s3JsY+65UQyjasWHmykzEAQSgCBy+1ch04J8/jGgt9Oa3N6+8b/Lgl+jmsv09l4/WcFAgMBAAECgYEAg2cLEbX8QiN7qVpvQhvBLYxuyWw/3Njpp1Up5PiHJ/cjRycTB+/ThqKydJIvhCdyCSNexRFiy8LPiW0IW9mYOzt+90S1fc8SIJfZiA61kaUR3RzAfF6bDr60H+K/qI+ox55E5dAPmM/J7g16KEMI1zeC5tchduc8yFYaksrs9cECQQDxee8vv8rUIOeouxB6/szi3gbXdM/momI++o8lHdCnKIVukM5ttAZz4m8sJV1gy9NMQIuSIlpnY58/ObUaIPQZAkEA0pCrkjPvyFrLpLX5Ffga9akwEmSUd/4NZaFOH+dtiYCRgWEMve3bFHzYARNl3SHTmGsPoJ/Drj/CcMGT5P9HzQJBAJZfEyaN7ZWZhAkbrFCbWSUxk9sZv9lkZ3/GcdtwLJ3bavQGMrY39Ai4CfjYr8R2SPdj/kYbJGbbr7AklHVX7gkCQQCktDLwPp3d61+FbC31SEfWRsvqZzBXF6rlByK0A/ODbcTjHcW4vtfyE6FmXgT8ztvTSlNEAhQvNYJjbpe/tQs1AkEAouIF8KyhG4ZzcNY1NsO5XI42VYeWWWYqDQ0xt4DrUPVd+yoDxGmE24NJYmolRJpgofukoK4db020BgoWOXLFzw==";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
//    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
//    order.productName = product.subject; //商品标题
//    order.productDescription = product.body; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:@"partner=\"2088911429928915\"&seller_id=\"aiyupaopao@aliyun.com\"&out_trade_no=\"0824173417-2106\"&subject=\"本华球Z\"&body=\"支付金额\"&total_fee=\"0.01\"&notify_url=\"http://120.24.98.41/app/order/alipay_notify.do\"&service=\"mobile.securitypay.pay\"&payment_type=\"1\"&_input_charset=\"utf-8\"&it_b_pay=\"30m\"&sign=\"oqvxT%2FJKvMqdjyzB8oP5VUXGFrmjJT70YTockQ9n2UsinQEeExSMfVjrQcMsQ5lEikNo8uEVP7r03raQuItGE7mI7R2h4i7eUKwTtbmfW9b6XaCYUgYUIJusLQdKBPW2E2VVHL4RurDkdKQOhoWx%2BCR%2B4ENnNLgigAzaBzJ4Odo%3D\"&sign_type=\"RSA\"" fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
        
      
    }
}

@end
