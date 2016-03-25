//
//  BaomingnustknowController.m
//  HomeAdorn
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "BaomingnustknowController.h"
#import "YuyuepwViewController.h"
@interface BaomingnustknowController ()
{
    UITextView *ContentTextView;
    NSString *textstring;
    UILabel *label;
}

@end

@implementation BaomingnustknowController


-(void)InitNavigation{
    [super InitNavigation];
     self.title = @"报名需知";
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavRightBtn  setFrame:CGRectMake(0, 0, 50, 25)];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    [NavRightBtn setTitle:@"同意" forState:UIControlStateNormal];
    [NavRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [NavRightBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        
        YuyuepwViewController *vc = [[YuyuepwViewController alloc] init];
        vc.smid = _smid;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}

-(void)InitLoadData{
   // NSArray *arrayInfo = (NSArray *)_dicInfo;
  //  NSDictionary *dic = arrayInfo[_index]; dic[@"id"]
    [[CommonFunctions sharedlnstance] bmxz:_smid requestBlock:^(NSObject *requestData, BOOL IsError) {
        
        if (!IsError) {
            NSDictionary *dic = (NSDictionary *)requestData;
            
            NSString *context = dic[@"context"];
           
                [self settext:context];
           
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
//    HUD.mode = MBProgressHUDModeText;
//    [HUD setLabelText:@"没有数据！"];
//    [HUD show:YES];
//    [HUD hide:YES afterDelay:2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)heightContentBackgroundView:(NSString *)content
{
    CGFloat height = [self heigtOfLabelForFromString:content fontSizeandLabelWidth:viewW-55 andFontSize:13.0];
    ;
    return height;
}

- (CGFloat)heigtOfLabelForFromString:(NSString *)text fontSizeandLabelWidth:(CGFloat)width andFontSize:(CGFloat)fontSize
{
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, 20000)];
    return size.height;
}

-(void)settext:(NSString *)context
{
    if(context.length< 2)
    {
        UILabel *lb= [[UILabel alloc] initWithFrame:CGRectMake(0, viewH*0.5, viewW, 15)];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = @"暂无报名须知哦！";
        lb.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:lb];
    }
    else
    {
        
        UIWebView *_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
        
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        _webView.delegate = self;
        
        
        [_webView loadHTMLString:context  baseURL:[NSURL fileURLWithPath:[ [NSBundle mainBundle] bundlePath]]];
        [self.view addSubview:_webView];
        

    }
        
    

}


@end
