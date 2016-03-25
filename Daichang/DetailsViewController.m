//
//  DetailsViewController.m
//  HomeAdorn
//
//  Created by mac on 15/7/15.
//  Copyright (c) 2015年 IWork. All rights reserved.
//
#import "communController.h"
#import "DetailsViewController.h"
#import <AGCommon/NSString+Common.h>
#import "ApplyGameViewController.h"
@interface DetailsViewController ()
{
       UIWebView *_webView;
       UIActivityIndicatorView *activityIndicator;
}

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self InitControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
    
}


-(void)InitControl{

    self.title = @"活动详情";
    [self loadHtml:_dicInfo[@"hd_url"]];
    UIButton *btnshare = [[UIButton alloc] initWithFrame:CGRectMake(30, viewH-115, 30, 30)];
    [btnshare setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnshare setFont:[UIFont systemFontOfSize:12]];
    [btnshare setImage:[UIImage imageNamed:@"shore"] forState:UIControlStateNormal];
    [btnshare addTarget:self action:@selector(btnp:) forControlEvents:(UIControlEventTouchUpInside)];
    btnshare.tag = 101;
    btnshare.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,btnshare.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
    btnshare.titleEdgeInsets = UIEdgeInsetsMake(0, -550, 0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
    [btnshare setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnshare.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    btnshare.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化
    
    [self.view addSubview:btnshare];

    
    UIButton *btncomm = [[UIButton alloc] initWithFrame:CGRectMake(viewW*0.25+10, viewH-115, 30, 35)];
    [btncomm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btncomm setFont:[UIFont systemFontOfSize:12]];
    [btncomm setTitle:@"评论" forState:UIControlStateNormal];
    [btncomm setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    [btncomm addTarget:self action:@selector(btnp:) forControlEvents:(UIControlEventTouchUpInside)];
    btncomm.tag = 102;
    btncomm.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,btncomm.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
    btncomm.titleEdgeInsets = UIEdgeInsetsMake(-10,-200, -100, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
    [btncomm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btncomm.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    btncomm.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化

    [self.view addSubview:btncomm];
    
    
    UIButton *btnbaoming = [[UIButton alloc] initWithFrame:CGRectMake(viewW*0.5, viewH-115, viewW*0.5, 57)];
    [btnbaoming setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnbaoming setFont:[UIFont systemFontOfSize:12]];
    [btnbaoming setTitle:@"我要报名" forState:UIControlStateNormal];
    [btnbaoming addTarget:self action:@selector(btnp:) forControlEvents:(UIControlEventTouchUpInside)];
    [btnbaoming setBackgroundColor:rgb_color(238, 173, 39, 1.0)];
//    [btnbaoming setImage:[UIImage imageNamed:@"baoming"] forState:UIControlStateNormal];
    btnbaoming.tag = 103;
    
//    btnbaoming.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,btnbaoming.titleLabel.bounds.size.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
//    btnbaoming.titleEdgeInsets = UIEdgeInsetsMake(-10, -310, -10, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
//    [btnbaoming setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btnbaoming.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
//    btnbaoming.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化
    

    [self.view addSubview:btnbaoming];
   
    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(viewW/4-15, viewH-66-25, viewW/4, 30)];
    [lb1 setText:@"评论"];
    [lb1 setTextAlignment:NSTextAlignmentCenter];
    [lb1 setTextColor:[UIColor blackColor]];
    lb1.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:lb1];
    
    int d= self.view.frame.size.height;
    UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(5, viewH-66-25, viewW/4, 30)];
    [lb2 setText:@"分享"];
    [lb2 setTextAlignment:NSTextAlignmentCenter];
    [lb2 setTextColor:[UIColor blackColor]];
    lb2.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:lb2];

}

-(void)btnp:(UIButton *)btn
{
    if (btn.tag==101) {
        [self InitShareIt];
    }
    if (btn.tag==102) {
        communController *commun = [[communController alloc] init];
        commun.dicInfo = _dicInfo;
        [self.navigationController pushViewController:commun animated:YES];
    }
    if (btn.tag==103) {
        
        //ApplyViewController
        ApplyGameViewController *Apply = [[ApplyGameViewController alloc] init];
        Apply.dicInfo = _dicInfo;
        [self.navigationController pushViewController:Apply animated:YES];
        
    }
}


-(void)InitShareIt{
    
    id<ISSContent> publishContent = [ShareSDK content:@"慈光音佛教平台顺应时代科技的发展，把移动互联网的生活模式与佛教紧密地结合起来，运用互联网软硬件技术为佛教体系中的各级组织机构以及方丈、住持、法师、义工、护法、信众、以及各种法会、放生、禅修、佛教教育、佛教夏令营等佛事活动等提供信息化的交流和服务。"
                                       defaultContent:@"慈光音佛教平台顺应时代科技的发展，把移动互联网的生活模式与佛教紧密地结合起来，运用互联网软硬件技术为佛教体系中的各级组织机构以及方丈、住持、法师、义工、护法、信众、以及各种法会、放生、禅修、佛教教育、佛教夏令营等佛事活动等提供信息化的交流和服务。"
                                                image:[ShareSDK pngImageWithImage:[UIImage imageNamed:@"shareImage"]]
                                                title:@"慈光音"
                                                  url:_dicInfo[@"hd_url"]
                                          description:@"慈光音佛教平台顺应时代科技的发展，把移动互联网的生活模式与佛教紧密地结合起来，运用互联网软硬件技术为佛教体系中的各级组织机构以及方丈、住持、法师、义工、护法、信众、以及各种法会、放生、禅修、佛教教育、佛教夏令营等佛事活动等提供信息化的交流和服务。"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    if ([[UIDevice currentDevice].systemVersion versionStringCompare:@"7.0"] != NSOrderedAscending)
    {
        //7.0以上只允许发文字，定义Line信息
        [publishContent addLineUnitWithContent:INHERIT_VALUE
                                         image:nil];
    }
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:self.view arrowDirect:UIPopoverArrowDirectionUp];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:mAppDelegate.mAGVivewDelegate
                                               authManagerViewDelegate:mAppDelegate.mAGVivewDelegate];
    
//    //在授权页面中添加关注官方微博
//    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
//                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"慈光音"],
//                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
//                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"慈光音"],
//                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
//                                    nil]];
    
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"内容分享"
                                                              oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                               qqButtonHidden:NO
                                                        wxSessionButtonHidden:NO
                                                       wxTimelineButtonHidden:NO
                                                         showKeyboardOnAppear:YES
                                                            shareViewDelegate:mAppDelegate.mAGVivewDelegate
                                                          friendsViewDelegate:mAppDelegate.mAGVivewDelegate
                                                        picViewerViewDelegate:mAppDelegate.mAGVivewDelegate];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:shareOptions
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@",[error errorCode], [error errorDescription]);
                                }
                            }];
}


-(void)loadHtml:(NSString *)weburl
{

    [_webView setScalesPageToFit:YES];  //大小自适应
    _webView = [[ UIWebView alloc]  initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-64-50)];
    [ _webView setUserInteractionEnabled: YES ]; //是否支持交互
    [ _webView setDelegate: self ]; //委托
    //[ webViewForCUD setOpaque: NO ]; //透明,背景变成灰色的
    [ self.view addSubview : _webView]; //加载到自己的view
     NSURL *url = [NSURL URLWithString:weburl];
    [_webView loadRequest:[ NSURLRequest requestWithURL: url ]]; //笔者习惯采用loadRequest方式，你可以采用其他方式
    //    webView.hidden = YES;
    NSString *js_result2 = [_webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    
    activityIndicator = [[ UIActivityIndicatorView alloc] initWithFrame: CGRectMake( 10 , 10 , 20 , 20 )];//需要
    [ activityIndicator setCenter : _webView.center ];//位置
    [ activityIndicator setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleGray]; //颜色根据不同的界面自己整
     [ self.view addSubview : activityIndicator];
}



//几个代理方法

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"webViewDidStartLoad");
    
}

- (void)webViewDidFinishLoad:(UIWebView *)web{
    
    NSLog(@"webViewDidFinishLoad");
    
}

-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error{
    
    NSLog(@"DidFailLoadWithError");
    
}



@end
