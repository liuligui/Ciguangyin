

//
//  HdcViewController.m
//  HomeAdorn
//
//  Created by mac on 15/7/28.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "HdcViewController.h"
#import "Globle.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "ApplyGameViewController.h"
#import "Globle.h"
@interface HdcViewController ()

@end

@implementation HdcViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad
{
    
    _textfild.delegate = self;
    [_textfild becomeFirstResponder];
    [super viewDidLoad];
}

-(void)InitNavigation{
    [super InitNavigation];
    self.title = @"发表评论";
    [NavRightBtn  setFrame:CGRectMake(0, 0, 50, 25)];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    [NavRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [NavRightBtn setTitle:@"发表" forState:UIControlStateNormal];
    [NavRightBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
      
        NSString *userid = [Globle shareInstance].user_id;
        NSString *context = _textfild.text;
        NSString *idd =_dicInfo[@"id"];
        if (context.length<1) {
            HUD.mode = MBProgressHUDModeText;
            [HUD setLabelText:@"请输入内容！"];
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
        }
        else
        {
            [self btnp];
        }
       
      
    }];
}


-(void)btnp
{
    //user_id，context，action_id
    NSString *userid = [Globle shareInstance].user_id;
    NSString *context = _textfild.text;
    NSString *idd =_dicInfo[@"id"];
    
    
    NSString *string = [NSString stringWithFormat:@"%@%@",ServiceAddress,@"cgy/appAction/actionPl.do"];
    NSURL *url = [NSURL URLWithString:string];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:userid forKey:@"user_id"];
    [request setPostValue:context forKey:@"context"];
    [request setPostValue:idd forKey:@"action_id"];
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
        [HUD setLabelText:@"评论成功！"];
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
        [HUD setLabelText:@"评论失败！"];
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }
    
    
}



@end
