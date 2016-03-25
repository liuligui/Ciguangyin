//
//  ClassificationController.m
//  HomeAdorn
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "ClassificationController.h"
#import "PublishViewController.h"
#import "CommentsCell.h"
#import <AGCommon/NSString+Common.h>
#import "Globle.h"
#import "UIImageView+MJWebCache.h"
#import "CommentViewController.h"
@interface ClassificationController ()<MJRefreshBaseViewDelegate>
{
    UITableView *huodongtable;
    NSArray *userRecord;
    NSMutableArray *messageRecord;
     NSMutableArray *messageRecord1;
    NSArray *ImageRecord ;
    NSMutableArray *images;
     NSMutableArray *yesno;
    int totalpage ;
    int pageCount;
    int pageIndex;
    
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    int count;
}

@end

@implementation ClassificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    yesno = [NSMutableArray array];
    for (int i = 0; i <800; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"NO" forKey:@"checked"];
        [yesno addObject:dic];
    }
    userRecord = [NSMutableArray array];
    messageRecord = [NSMutableArray array];
    messageRecord1 = [NSMutableArray array];
    ImageRecord = [NSMutableArray array];
    images = [NSMutableArray array];
    [self initMJRefresh];
    // Do any additional setup after loading the view.
}

#pragma mark 上拉下拉刷新
-(void)initMJRefresh
{
    // 下拉刷新
    if (_header == nil)
    {
        _header = [[MJRefreshHeaderView alloc] init];
        _header.delegate = self;
        _header.scrollView = huodongtable;
        
    }
    
    // 上拉加载更多
    if (_footer == nil)
    {
        _footer = [[MJRefreshFooterView alloc] init];
        _footer.delegate = self;
        _footer.scrollView = huodongtable;
        
    }
}


#pragma mark 上拉下拉刷新的代理方法

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH : mm : ss.SSS";
    if (_header == refreshView)
    {
        pageIndex = 1;
        [self loadDb:@"1"];
        
    }
    else
    {
        if (pageIndex<pageCount) {
            pageIndex++;
            
            NSString *index = [NSString stringWithFormat:@"%d",pageIndex];
            [self loadDb:index];
        }
        else
        {
            [_header endRefreshing];
            [_footer endRefreshing];
            
        }
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)InitNavigation{
    [super InitNavigation];
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];

    
    [NavRightBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    [NavRightBtn setImage:[UIImage imageNamed:@"addicon"] forState:UIControlStateNormal];
    [NavRightBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        PublishViewController *viewController = [[PublishViewController alloc] init];
        viewController.title = @"发布消息";
        [self.navigationController pushViewController:viewController animated:YES];
    }];
    
    
}


#pragma mark - 初始化加载
-(void)InitControl{
    
    
    huodongtable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH-64)];
    huodongtable.delegate = self;
    huodongtable.dataSource =self;
    huodongtable.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    [self.view addSubview:huodongtable];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int count=messageRecord.count;
    
    return count;

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [images removeAllObjects];
    NSDictionary *dic = messageRecord[indexPath.row];
    NSString * strText = [dic objectForKey:@"context"];
    NSString *msmid = [dic objectForKey:@"id"];
    for (int i=0; i< ImageRecord.count; i++) {
        NSDictionary *d = ImageRecord[i];
        NSString *im =d[@"msg_id"];
        if ([im isEqualToString:msmid]) {
            [images addObject:ImageRecord[i]];
        }
    }
    
    CGFloat HH = [self heightContentBackgroundView:strText];
    if(images.count > 0){//发表的图片
        int count = images.count > 9 ? 9 : (int)images.count;
        int heightCount = 0;
        
        if (count>0&&count <= 3) {
            heightCount = 1;
            
        }else if (count > 3 && count <= 6){
            heightCount = 2;
        }else if (count > 6 ){
            heightCount = 3;
        }
        
        float h = heightCount * 60;
        return HH+h+85;
        
    }
    
    return  85+HH;

}
//  [_PointChan addTarget:self action:@selector(shareQ) forControlEvents:UIControlEventTouchUpInside];


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    
    static  NSString *cellIn=@"haha";
    CommentsCell *Cell=[tableView dequeueReusableCellWithIdentifier:cellIn];
    
    if(Cell==nil){
        Cell=[[CommentsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIn];
    }
    
    
    
   
    [images removeAllObjects];
    NSDictionary *dic = messageRecord[indexPath.row];
    
    NSString *imageurl = [IMAGEURL stringByAppendingString:dic[@"user_image_url"]];
  

     [Cell.Avatar setImageURLStr:imageurl placeholder:[UIImage imageNamed:@"defaultcgy"]];
    
//    NSString * strText = [dic objectForKey:@"context"];
//    Cell.NameLabel.text = [dic objectForKey:@"user_name"];
//    Cell.ContentLabel.text = [dic objectForKey:@"context"];
//    NSString *msmid = [dic objectForKey:@"id"];
//    Cell.msid = msmid;
//    Cell.TimeLabel.text = [[dic objectForKey:@"fb_time"] substringToIndex:10];
//    Cell.ImageURLArray = ImageRecord;
//    [Cell.PointChan addTarget:self action:@selector(InitShareIt) forControlEvents:UIControlEventTouchUpInside];
//    [Cell.Conmments addTarget:self action:@selector(Conmments:) forControlEvents:UIControlEventTouchUpInside];
//    [Cell.Reason addTarget:self action:@selector(focusOn:) forControlEvents:UIControlEventTouchUpInside];
//    Cell.selectionStyle =UITableViewCellSelectionStyleNone;
//    return Cell;
    
    
    Cell.NameLabel.text = [dic objectForKey:@"user_name"];
    Cell.ContentLabel.text = [dic objectForKey:@"context"];
    NSString *msmid = [dic objectForKey:@"id"];
    Cell.msid = msmid;
    
    NSString *strtime = [dic[@"fb_time"] substringToIndex:19];
    
    NSString *times = [TimeUtils intervalSinceNow:strtime];
    
    NSUInteger row = [indexPath row];
    NSMutableDictionary *dictt = [yesno objectAtIndex:row];
    
    if ([dictt[@"checked"] isEqualToString:@"YES"]) {
        //[Cell.Reason setBackgroundImage:[UIImage imageNamed:@"collect_pressed"] forState:UIControlStateNormal];
        [Cell setChecked:YES];
    }
    else
    {
        //[Cell.Reason setBackgroundImage:[UIImage imageNamed:@"collect_uppressed"] forState:UIControlStateNormal];
        [Cell setChecked:NO];
    }
    
    
    
    Cell.TimeLabel.text = times;
    Cell.ImageURLArray = ImageRecord;
    Cell.selectionStyle =UITableViewCellSelectionStyleNone;
    [Cell.PointChan addTarget:self action:@selector(InitShareIt) forControlEvents:UIControlEventTouchUpInside];
    Cell.Conmments.titleLabel.text = msmid;
    [Cell.Conmments addTarget:self action:@selector(Conmments:) forControlEvents:UIControlEventTouchUpInside];
    [Cell.jubao addTarget:self action:@selector(jubao:) forControlEvents:UIControlEventTouchUpInside];
    Cell.Reason.titleLabel.text =msmid;
    Cell.Reason.tag = 10000;
    Cell.msiid.text = msmid;
    [Cell.Reason handleControlEvent:UIControlEventTouchUpInside withBlock:^(UIButton *btn)
     {
         NSUInteger row = [indexPath row];
         NSMutableDictionary *dictt = [yesno objectAtIndex:row];
         
         if ([[dictt objectForKey:@"checked"] isEqualToString:@"NO"]) {
             [dictt setObject:@"YES" forKey:@"checked"];
             
             [btn setBackgroundImage:[UIImage imageNamed:@"collect_pressed"] forState:UIControlStateNormal];
             
             [[CommonFunctions sharedlnstance] shoucang:[Globle shareInstance].user_id sm_id:msmid type:@"1" requestBlock:^(NSObject *requestData, BOOL IsError) {
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
             
             
             
             
             
         }else {
             [btn setBackgroundImage:[UIImage imageNamed:@"collect_uppressed"] forState:UIControlStateNormal];
             [dictt setObject:@"NO" forKey:@"checked"];
             [[CommonFunctions sharedlnstance] shoucang:[Globle shareInstance].user_id sm_id:msmid type:@"0" requestBlock:^(NSObject *requestData, BOOL IsError) {
                 NSDictionary *rd= (NSDictionary *)requestData;
                 if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
                 {
                     HUD.mode = MBProgressHUDModeText;
                     [HUD setLabelText:@"取消成功！"];
                     [HUD show:YES];
                     [HUD hide:YES afterDelay:1];
                     
                 }
                 else
                 {
                     HUD.mode = MBProgressHUDModeText;
                     [HUD setLabelText:@"取消失败！"];
                     [HUD show:YES];
                     [HUD hide:YES afterDelay:1];
                     
                 }
             }];
             
             
             
         }
         
         
         
         
     }];
    
    Cell.str.text =[NSString stringWithFormat:@"%@|%@|%@",dic[@"user_id"],dic[@"user_name"],dic[@"user_image_url"]];//
    Cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return Cell;
    
    
    
    
    
}



-(void)focusOn:(UIButton *)btn
{
    NSString *idd = btn.titleLabel.text;
    [[CommonFunctions sharedlnstance] shoucang:[Globle shareInstance].user_id sm_id:idd type:@"2" requestBlock:^(NSObject *requestData, BOOL IsError) {
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

-(void)Conmments:(UIButton *)btn{
    NSString *idd = btn.titleLabel.text;
    CommentViewController *vc= [[CommentViewController alloc] init];
    vc.idd = idd;
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)loadDb:(NSString *)index
{
    HUD.mode = MBProgressHUDModeIndeterminate;
    [HUD show:YES];
    
    [[CommonFunctions sharedlnstance] getappListMsgPageNum:index type:_type userid:@"" curr_user:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        
        [HUD hide:YES];
        NSDictionary *dic = (NSDictionary *)requestData;
        NSDictionary *dicxxImage = [dic objectForKey:@"xxImage"];
        NSDictionary *dicmessage = [dic objectForKey:@"message"];
        NSDictionary *dicuser = [dic objectForKey:@"user"];
        pageCount =  dic[@"message"][@"totalpage"];
        userRecord =dicuser[@"record"];
      
        
        messageRecord1 =dicmessage[@"record"];
        
        if ([index isEqualToString:@"1"]) {
            [messageRecord removeAllObjects];
        }
        if (messageRecord1.count>0) {
            for (int i=0; i<messageRecord1.count; i++) {
                [messageRecord addObject:messageRecord1[i]];
            }
            
        }
        
        if (messageRecord.count>0) {
            for (int i=0; i<messageRecord.count; i++) {
                NSDictionary *dic = messageRecord[i];
                NSString *sfsc = [dic objectForKey:@"sfsc"];
                NSMutableDictionary *dictt = [yesno objectAtIndex:i];
                if ([sfsc isEqualToString:@"true"]) {
                    
                    [dictt setObject:@"YES" forKey:@"checked"];
                }
                else
                {
                    
                    [dictt setObject:@"NO" forKey:@"checked"];
                }
                
            }
            
        }

        
        ImageRecord =(NSArray *)dicxxImage;
        [_header endRefreshing];
        [_footer endRefreshing];
        [huodongtable reloadData];
        
        
        totalpage = [dicmessage[@"totalpage"] intValue];
        pageCount = totalpage;
    }
     
     ];
    
    
}
-(void)InitLoadData
{
  
    [self loadDb:@"1"];
    
    
}


- (CGFloat)heightContentBackgroundView:(NSString *)content
{
    CGFloat height = [self heigtOfLabelForFromString:content fontSizeandLabelWidth:viewW-55  andFontSize:13.0];
    ;
    return height;
}

- (CGFloat)heigtOfLabelForFromString:(NSString *)text fontSizeandLabelWidth:(CGFloat)width andFontSize:(CGFloat)fontSize
{
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, 20000)];
    return size.height;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
}


@end
