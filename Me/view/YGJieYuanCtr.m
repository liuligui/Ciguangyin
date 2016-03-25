//
//  YGJieYuanCtr.m
//  HomeAdorn
//
//  Created by wangxiaoer on 7/24/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import "YGJieYuanCtr.h"
#import "UIImageView+MJWebCache.h"
#import "cityPickerViewController.h"
#import "Globle.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "UIImageView+MJWebCache.h"
#import "UIImageView+LBBlurredImage.h"
#import "CompressionIMAGE.h"
#import "Globle.h"
#import "MBProgressHUD+MJ.h"
@interface YGJieYuanCtr ()<setcityDelegate>
{
    NSArray *record;
    NSString *biz_jy_id;
}

@end

@implementation YGJieYuanCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    _name.delegate = self;
    _phone.delegate = self;
    record = [NSMutableArray array];
    _lbaddress.userInteractionEnabled = YES;
    [_lbaddress addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTouchUpInside:)]];
}

-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
      
    cityPickerViewController *citypick = [[cityPickerViewController alloc] init];
    citypick.delegate =self;
    [self.navigationController pushViewController:citypick animated:YES];
}
-(void)setcity:(NSString *)city
{
   
    _lbaddress.text = city;


}





-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
    self.view.backgroundColor = rgb_color(239, 239, 244, 1);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)InitLoadData
{
    HUD.mode = MBProgressHUDModeIndeterminate;
    [HUD show:YES];
    
    [[CommonFunctions sharedlnstance] getgoods:@"" requestBlock:^(NSObject *requestData, BOOL IsError) {
        
        
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            record = (NSArray *) [dic objectForKey:@"record"];
            
            if (record>0) {
                NSDictionary *dict = (NSDictionary *)record[0];
                NSString *url = dict[@"image_url_big"];
                biz_jy_id = dict[@"id"];
                url = [IMAGEURL stringByAppendingString:url];
                [self showBigImage:url];
                
                
                _scrollview.contentSize = CGSizeMake(92*record.count, 99);
                int x=2;
                for (int i= 0; i < record.count; i ++) {
                    NSDictionary *dict = (NSDictionary *)record[i];
                    NSString *url = dict[@"image_url"];
                    NSString *jyname = dict[@"jy_name"];
                  
                    url = [IMAGEURL stringByAppendingString:url];
                    UIImageView *imagesview = [[UIImageView alloc] initWithFrame:CGRectMake(x, 2, 90, 90)];
                    
                    UILabel *lbanem = [[UILabel alloc] initWithFrame:CGRectMake(x, 95, 90, 15)];
                    lbanem.textAlignment = NSTextAlignmentCenter;
                    lbanem.font = [UIFont systemFontOfSize:12];
                    lbanem.text = jyname;
                    [_scrollview addSubview:lbanem];
                    
                    imagesview.image = [UIImage imageNamed:@"shop2@2x"];
                    imagesview.tag = i;
                    x +=92;
                    [imagesview setImageURLStr:url placeholder:[UIImage imageNamed:@"defaultcgy"]];
                    imagesview.userInteractionEnabled = YES;
                    [imagesview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
                    [_scrollview addSubview:imagesview];
                }
                
                _scrollview.delegate = self;
            }
            
        }
        
    }];
}
- (void)tapImage:(UITapGestureRecognizer *)tap
{
    UIImageView *imageview = (UIImageView *)tap.view;
   
    NSDictionary *dict = (NSDictionary *)record[imageview.tag];
    NSString *url = dict[@"image_url_big"];
    biz_jy_id = dict[@"id"];
    url = [IMAGEURL stringByAppendingString:url];
    [self showBigImage:url];
}
-(void)showBigImage:(NSString *)url
{
    [_image5 setImageURLStr:url placeholder:[UIImage imageNamed:@"defaultcgy"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnCommit:(id)sender {
   
    [self btnp];
}



-(void)btnp
{

    //biz_jy_id、tbr、address、phone
    
    NSString *string = [NSString stringWithFormat:@"%@%@",ServiceAddress,@"cgy/appCgy/buyJyp.do"];
    NSURL *url = [NSURL URLWithString:string];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[Globle shareInstance].user_id forKey:@"user_id"];
    [request setPostValue:biz_jy_id forKey:@"biz_jy_id"];
    [request setPostValue:_name.text forKey:@"tbr"]; //
    [request setPostValue:_lbaddress.text forKey:@"address"]; //
    [request setPostValue:_phone.text forKey:@"phone"];
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

@end
