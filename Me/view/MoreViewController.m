//
//  MoreViewController.m
//  Ciguangyin
//
//  Created by mac on 15/7/10.
//  Copyright (c) 2015年 ddsw. All rights reserved.
//

#import "MoreViewController.h"
#import "LoginViewController.h"
#import <AGCommon/NSString+Common.h>
#import "AboutUsViewController.h"
#import "HelpViewController.h"
#import "UMSocial.h"
@interface MoreViewController ()
{
    UITableView *moretable;
}
@property (nonatomic, strong)UIActionSheet *sheet;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}
-(void)initView
{
    self.title = @"更多";
    self.navigationController.navigationBarHidden = NO;
    moretable =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH) style:UITableViewStyleGrouped];
    moretable.delegate = self;
    moretable.dataSource =self;
    moretable.scrollEnabled = NO;
    [self.view addSubview:moretable];
    
    // 下一步
    UIButton *_nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextButton setFrame:CGRectMake(10, viewH-200, self.view.frame.size.width-20, 50)];
    [_nextButton setTitle:@"安全退出" forState:UIControlStateNormal];
    [_nextButton setBackgroundColor:[UIColor clearColor]];
    [_nextButton addTarget:nil action:@selector(exitApplication) forControlEvents:UIControlEventTouchUpInside];
     UIImage *imag = [self imageWithColor:RGBACOLOR(219, 98, 32, 1.0) andSize:CGSizeMake(self.view.frame.size.width, 80)];
    [_nextButton setBackgroundImage:imag forState:UIControlStateNormal];
    [self.view addSubview:_nextButton];
}


/**
 *  退出登录
 */
- (void)exitApplication {
    _sheet = [[UIActionSheet alloc] initWithTitle:@"确定要退出登录吗？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
    [_sheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == _sheet.cancelButtonIndex) {
        NSLog(@"取消");
        
    }
    switch (buttonIndex) {
        case 0:
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"password"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            NSString *platformType = [UMSocialSnsPlatformManager getSnsPlatformString:15];
            
            [[UMSocialDataService defaultDataService] requestUnOauthWithType:platformType completion:^(UMSocialResponseEntity *response) {
                NSLog(@"unOauth response is %@",response);
                
            }];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"password"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self backtilogin];
            
            break;
    }
}


-(void)backtilogin
{
    LoginViewController *NavMainView = [[LoginViewController alloc] init];
    [self presentModalViewController:NavMainView animated:NO];
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }
    return 2;
    
}
-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.font = [UIFont systemFontOfSize:14];
    if (indexPath.section == 0){
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"使用帮助";
        }
        
    }
    if(indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"软件分享";
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"关于我们";
        }
        
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
            if(indexPath.section == 0)
            {
                if (indexPath.row == 0) {
                    HelpViewController  *helpview = [[HelpViewController alloc] init];
                    helpview.title = @"使用帮助";
                    [self.navigationController pushViewController:helpview animated:YES];
                }
            }
            if(indexPath.section == 1)
            {
                if (indexPath.row == 0) {
                    [self InitShareIt];
                }
                if (indexPath.row == 1) {
                    AboutUsViewController  *AboutUs = [[AboutUsViewController alloc] init];
                    AboutUs.title = @"关于我们";
                    [self.navigationController pushViewController:AboutUs animated:YES];
                }

            }
    
}



-(void)InitShareIt{
    
    id<ISSContent> publishContent = [ShareSDK content:@"来自慈光音"
                                       defaultContent:@"来自慈光音"
                                                image:nil
                                                title:@"慈光音"
                                                  url:@"https://itunes.apple.com/us/app/ci-guang-yin/id1047549304?ls=1&mt=8"
                                          description:@"来自慈光音"
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
//    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
