


//
//  CommentViewController.m
//  HomeAdorn
//
//  Created by liuligui on 15/9/10.
//  Copyright (c) 2015年 IWork. All rights reserved.
//
#import "TimeUtils.h"
#import "CommentViewController.h"
#import "CommentTableCell.h"
#import "UIImageView+MJWebCache.h"
#import "PublishViewController.h"
#import "MessageViewController.h"
#import "MyPublishmessageViewController.h"
#import "CommentTableViewCell.h"
#import "CommentsCell.h"
#import "ClassificationController.h"
#import <AGCommon/NSString+Common.h>
#import "introduceNViewController.h"
#import "Globle.h"
#import "CommentViewController.h"
#import "MessageViewCell.h"
#import "PublishViewController.h"
#import "MessageViewController.h"
#import "MyPublishmessageViewController.h"
#import "CommentTableViewCell.h"
#import "CommentsCell.h"
#import "ClassificationController.h"
#import <AGCommon/NSString+Common.h>
#import "introduceNViewController.h"
#import "UIImageView+MJWebCache.h"
#import "Globle.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "CommentViewController.h"
#define CELL_WIDTH  ([[UIScreen mainScreen]bounds].size.width-20)/4
#define CELL_HEIGHT CELL_WIDTH+20
@interface CommentViewController ()
{
    UITableView *mytable;
    NSArray *arr;
    UIImageView *LogoImage;
    UILabel *name;
    UILabel *time;
    UILabel *context;
    NSString *reflID;
    UIView *buttom;
    UIView *_line;
    NSString *MsguserId;
}

@end

@implementation CommentViewController

- (void)viewDidLoad {
    arr = [NSMutableArray array];
    [super viewDidLoad];
    self.title = @"评论";
 
    LogoImage =[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
    LogoImage.image = [UIImage imageNamed:@"yyh"];
    LogoImage.layer.masksToBounds = YES;
    LogoImage.layer.cornerRadius = 25;
    [self.view addSubview:LogoImage];
    
    name = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 200, 15)];
    name.text = @"";
    name.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:name];
    
    time = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 200, 15)];
    time.text = @"";
    time.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:time];
    
    //context
   
    
    CGFloat s = [self heightContentBackgroundView:@""];
    
    context = [[UILabel alloc] initWithFrame:CGRectMake(20, 75, viewW - 30, s)];
    context.text = @"";
    context.font = [UIFont systemFontOfSize:12];
    context.numberOfLines = 0;
    [self.view addSubview:context];
    
    buttom = [[UIView alloc] initWithFrame:CGRectMake(0,85+s, viewW, 30)];
   // buttom.backgroundColor = [UIColor greenColor];
    
   
    UIButton *_Reason = [UIButton buttonWithTitleImage:@"" Title:@"" Frame:CGRectMake(40, 0, 30, 30)];
    [_Reason setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _Reason.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    _Reason.tag = 0;
    [_Reason addTarget:self action:@selector(focusOn:) forControlEvents:UIControlEventTouchUpInside];
    [buttom addSubview:_Reason];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 29, viewW, 1)];
    _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [buttom addSubview:_line];
    
      UIButton *_PointChan = [UIButton buttonWithTitleImage:@"forward" Title:@"" Frame:CGRectMake(viewW-100, 0, 45, 30)];
    [_PointChan setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _PointChan.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    _PointChan.tag = 0;
    [_PointChan addTarget:self action:@selector(InitShareIt) forControlEvents:UIControlEventTouchUpInside];
    [buttom addSubview:_PointChan];
    
    UIButton *_Conmments = [UIButton buttonWithTitleImage:@"comment_normal" Title:@"" Frame:CGRectMake(viewW-50, 0, 50, 30)];
    [_Conmments setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _Conmments.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
    
    [buttom addSubview:_Conmments];
    [self.view addSubview:buttom];
    [_Conmments handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        
         [KTextView becomeFirstResponder];
    }];
    
    mytable = [[UITableView alloc] initWithFrame:CGRectMake(0, 110+s+10, viewW,viewH - 110+s+10)];
    mytable.delegate = self;
    mytable.dataSource = self;
    [self.view addSubview:mytable];
    [self setExtraCellLineHidden:mytable];
    
    [self loadData];
    
    [self InitKeyboardText];
    
}
-(void)KTextValue:(NSString *)text{
    
    if (text.length > 0) {
        [KTextView resignFirstResponder];
        NSString *string = [NSString stringWithFormat:@"%@%@",ServiceAddress,@"cgy/appUserInfo/massegPl.do"];
        NSURL *url = [NSURL URLWithString:string];
        NSString *context =  KTextView.text ;
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:[Globle shareInstance].user_id forKey:@"user_id"];
        [request setPostValue:_idd forKey:@"msg_id"];
        [request setPostValue: context forKey:@"context"];
        request.delegate = self;
        //异步发送请求
        [request startSynchronous]; //startSynchronous

        
    }else{
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = @"请输入评论内容！";
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }
}

-(void)btncom
{
    
}

- (CGFloat)heightContentBackgroundView:(NSString *)content
{
    CGFloat height = [self heigtOfLabelForFromString:content fontSizeandLabelWidth:viewW-70 andFontSize:12.0];
    ;
    return height;
}

- (CGFloat)heigtOfLabelForFromString:(NSString *)text fontSizeandLabelWidth:(CGFloat)width andFontSize:(CGFloat)fontSize
{
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, 20000)];
    return size.height;
}


-(void)focusOn:(UIButton *)btn
{
    NSString *idd = btn.titleLabel.text;
    [[CommonFunctions sharedlnstance] shoucang:[Globle shareInstance].user_id sm_id:idd type:@"1" requestBlock:^(NSObject *requestData, BOOL IsError) {
        NSDictionary *rd= (NSDictionary *)requestData;
        if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
        {
            HUD.mode = MBProgressHUDModeText;
            [HUD setLabelText:@"收藏成功！"];
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
            
        }
        else
        {
            HUD.mode = MBProgressHUDModeText;
            [HUD setLabelText:@"收藏失败！"];
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
            
        }
    }];
    
    
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




-(void)loadData
{
    [[CommonFunctions sharedlnstance] getCommit:_idd user_id:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        NSDictionary *rd= (NSDictionary *)requestData;
        NSArray *arry =(NSArray *)rd[@"pl_info"][@"record"];
        NSDictionary *msgInfo= rd[@"msgInfo"];
        NSString *dd =[IMAGEURL stringByAppendingString:[msgInfo objectForKey:@"image_url"]];
        [LogoImage setImageURLStr: [IMAGEURL stringByAppendingString:[msgInfo objectForKey:@"image_url"]] placeholder:[UIImage imageNamed:@"defaultcgy"]];
        
        
        CGFloat s = [self heightContentBackgroundView:msgInfo[@"context"]];
        name.text = msgInfo[@"user_name"];
        NSString *strtime = [msgInfo[@"fb_time"] substringToIndex:19];
        
        NSString *times = [TimeUtils intervalSinceNow:strtime];
        time.text = times;
        context.text = msgInfo[@"context"];
        MsguserId  = msgInfo[@"user_id"];
        [context setFrame:CGRectMake(context.frame.origin.x, context.frame.origin.y, viewW-30, s)];
        
        
         [buttom setFrame:CGRectMake(0,80+s, viewW, 30)];
       
          [mytable setFrame:CGRectMake(0, 110+s, viewW, viewH- 110-s)];
        if(arry.count>0)
        {
            arr = arry;
            [mytable reloadData];
        }
    }];
}
-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = arr[indexPath.row];
    CGFloat s = [self heightContentBackgroundView:dic[@"context"]];
    s = 35 + s;
    
    if (s<65) {
        s = 67;
    }
    else
    {
        s = 10+s;
    }
    return s;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellTableIdentifier = @"CommentTableCell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"CommentTableCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    CommentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                   CellTableIdentifier];
    NSDictionary *dic = arr[indexPath.row];
    cell.username.text = dic[@"user_name"];
    CGFloat s = [self heightContentBackgroundView:dic[@"context"]];
  
    [cell.commenttext setFrame:CGRectMake(cell.commenttext.frame.origin.x, cell.commenttext.frame.origin.x, viewW - 70, s)];
     cell.commenttext.numberOfLines = 0;

    
    cell.commenttext.text = dic[@"context"];
    


    NSString *strtime = [[dic objectForKey:@"pl_time"] substringToIndex:19];

    NSString *times = [TimeUtils intervalSinceNow:strtime];
   
    cell.time.text =times;
    NSString *imageurl =[IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]];
    cell.userLogo.layer.masksToBounds = YES;
    cell.userLogo.layer.cornerRadius = 25;
    [cell.userLogo setImageURLStr: [IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]] placeholder:[UIImage imageNamed:@"defaultcgy"]];
    return cell;
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavRightBtn  setFrame:CGRectMake(0, 0, 60, 25)];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    KTextView.text = nil;
    
    NSString *re = request.responseString;
    NSDictionary *dic = [re JSONValue];
    
  

    [self loadData];
    
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
