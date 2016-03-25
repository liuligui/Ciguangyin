


//
//  introduceNViewController.m
//  HomeAdorn
//
//  Created by mac on 15/7/19.
//  Copyright (c) 2015年 IWork. All rights reserved.
//
#import "CommentViewController.h"
#import "UIImageView+MJWebCache.h"
#import "introduceNViewController.h"
#import "MeTableViewCell.h"
#import "MoreViewController.h"
#import "YGMyrecordCtr.h"
#import "YGMyOffencontactCtr.h"
#import "WSZLViewController.h"
#import "PublishViewController.h"
#import "MessageViewController.h"
#import "MyPublishmessageViewController.h"
#import "CommentTableViewCell.h"
#import "CommentsCell.h"
#import "ClassificationController.h"
#import <AGCommon/NSString+Common.h>
#import "introduceNViewController.h"
#import "Globle.h"
#import "YGMyReleaseInforCtr.h"
#import "YGBookshelfCtr.h"
#import "YGMycollectionCtr.h"
#import "YGMyGongDeCtr.h"
#import "YGMyContactCtr.h"
#import "YGJieYuanCtr.h"
#import "Globle.h"
#import "ChatViewController.h"
#import "UIImageView+LBBlurredImage.h"
#import "HeContactCtr.h"
@interface introduceNViewController ()<MJRefreshBaseViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *metableview;
    UIImage *avatarImage;
    UISegmentedControl *segment;
    UITextView *textView;
    BOOL IsKV;
    NSMutableArray *topArray,*newArray,*myArray;
    int NewpageIndex,HotpageIndex,mypageIndex;
    NSString *reflID;
    UICollectionView *collectionview;
    NSArray *userRecord;
    NSMutableArray *messageRecord ;
    NSMutableArray *messageRecord1;
    NSArray *ImageRecord ;
    NSDictionary *userInfodic;
    int totalpage ;
    int pageCount;
    int pageIndex;
    UITableView *huodongtable;
    
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    int count;
    NSMutableArray *images;
    UILabel *lvmessage;
    UILabel *lvguanzhu;
    UILabel *lvfans;
 
    
    
}
@property(nonatomic,strong) UIImageView *avatarImageView;
@end

@implementation introduceNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UIInitTop];
    userRecord = [NSMutableArray array];
    messageRecord = [NSMutableArray array];
     messageRecord1 = [NSMutableArray array];
    ImageRecord = [NSMutableArray array];
    images = [NSMutableArray array];
    userInfodic = [[NSDictionary alloc] init];
   [self initMJRefresh];
    [self loadDb:@"1"];
    
}

-(void)InitNavigation
{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
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
        if (pageIndex<totalpage) {
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



#pragma mark - 初始化加载
-(void)InitControl{
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(viewW/4-20, 130, 40, 20)];
  //  [btn1 setImage:[UIImage imageNamed:@"care@2x"] forState:UIControlStateNormal];
    [btn1 setTitle:@"+关注" forState:UIControlStateNormal];
    //[btn1 setBackgroundColor:[UIColor orangeColor]];
    btn1.layer.masksToBounds = YES;
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn1.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    btn1.layer.cornerRadius = 5.0;
    btn1.layer.borderWidth = 1.0;
    
    btn1.layer.cornerRadius = 4;
    
    btn1.font = [UIFont systemFontOfSize:12];
    [btn1 addTarget:self action:@selector(focus) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(viewW/4*3-20, 130, 40, 20)];
    //[btn2 setImage:[UIImage imageNamed:@"cared@2x"] forState:UIControlStateNormal];
    [btn2 setTitle:@"私信" forState:UIControlStateNormal];
    btn2.layer.cornerRadius = 4;
    btn2.layer.masksToBounds = YES;
    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn2.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    btn2.layer.cornerRadius = 5.0;
    btn2.layer.borderWidth = 1.0;

    
    btn2.font = [UIFont systemFontOfSize:12];
    [btn2 addTarget:self action:@selector(chat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

    
    huodongtable = [[UITableView alloc] initWithFrame:CGRectMake(0, 160, viewW, viewH-64-160)];
    huodongtable.delegate = self;
    huodongtable.dataSource =self;
    huodongtable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.view addSubview:huodongtable];
}


//按钮点击

- (void)taplb:(UITapGestureRecognizer *)tap
{
    
    HeContactCtr *vc = [[HeContactCtr alloc] init];
    vc.user_id = _userid;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)focus
{
    [[CommonFunctions sharedlnstance] guanzhu:[Globle shareInstance].user_id bei_gz_user:[NSString stringWithFormat:@"%@",_userid] requestBlock:^(NSObject *requestData, BOOL IsError) {
        NSDictionary *rd= (NSDictionary *)requestData;
        if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
        {
            HUD.mode = MBProgressHUDModeText;
            [HUD setLabelText:@"关注成功！"];
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
            
        }
        else
        {
            HUD.mode = MBProgressHUDModeText;
            [HUD setLabelText:@"关注失败！"];
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
            
        }
    }];
    
    
}
-(void)chat
{
    ChatViewController *v = [[ChatViewController alloc] init];
    v.getId = _userid;
    [self.navigationController pushViewController:v animated:YES];
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
    NSString *Userlogo=@"";
    NSString * d= _logo;
   
    if(d.length < 1)
    {
       Userlogo = @"http://p4.qhimg.com/t01b8baead606564a12.jpg";
    }
    else
    {
      Userlogo = [IMAGEURL stringByAppendingString:d];
        
    }
    
    [Cell.Avatar setImageURLStr:Userlogo placeholder:[UIImage imageNamed:@"defaultcgy"]];
  
    [images removeAllObjects];
    NSDictionary *dic = messageRecord[indexPath.row];
    NSString * strText = [dic objectForKey:@"context"];
    Cell.NameLabel.text = [dic objectForKey:@"user_name"];
    Cell.ContentLabel.text = [dic objectForKey:@"context"];
    NSString *msmid = [dic objectForKey:@"id"];
    Cell.msid = msmid;
    
    NSString *strtime = [dic[@"fb_time"] substringToIndex:19];
    
    NSString *times = [TimeUtils intervalSinceNow:strtime];
    

    
    Cell.TimeLabel.text = times;
    
    Cell.ImageURLArray = ImageRecord;
    [Cell.PointChan addTarget:self action:@selector(InitShareIt) forControlEvents:UIControlEventTouchUpInside];
    Cell.Conmments.titleLabel.text = msmid;
    [Cell.Conmments addTarget:self action:@selector(Conmments:) forControlEvents:UIControlEventTouchUpInside];
    Cell.Reason.titleLabel.text =  msmid;
    [Cell.Reason addTarget:self action:@selector(focusOn:) forControlEvents:UIControlEventTouchUpInside];
    Cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return Cell;
}

-(void)Conmments:(UIButton *)btn{
    NSString *idd = btn.titleLabel.text;
    CommentViewController *vc= [[CommentViewController alloc] init];
    vc.idd = idd;
    [self.navigationController pushViewController:vc animated:YES];
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

-(void)loadDb:(NSString *)index
{
    HUD.mode = MBProgressHUDModeIndeterminate;  //_userid
    [HUD show:YES];
    
    [[CommonFunctions sharedlnstance] getappListMsgPageNum:index type:@"" userid:_userid  curr_user:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        
        [HUD hide:YES];
        NSDictionary *dic = (NSDictionary *)requestData;
        NSDictionary *dicxxImage = [dic objectForKey:@"xxImage"];
        NSDictionary *dicmessage = [dic objectForKey:@"message"];
        NSDictionary *dicuser = [dic objectForKey:@"user"];
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

        totalpage = [dicmessage[@"totalpage"] intValue];
        pageCount = totalpage;
        
        userInfodic = dic[@"userInfo"];
        ImageRecord =(NSArray *)dicxxImage;
        
        lvmessage.text =[NSString stringWithFormat:@"消息：%@",userInfodic[@"xx_num"]];
        
        lvguanzhu.text =[NSString stringWithFormat: @"关注：%@",userInfodic[@"gz_num"]];
        
        lvfans.text = [NSString stringWithFormat:@"粉丝：%@",userInfodic[@"bei_gz_num"]];
        
        
        [_header endRefreshing];
        [_footer endRefreshing];
        [huodongtable reloadData];
        //
        //totalpage = [dicmessage[@"totalpage"] intValue];
    }
     
     ];
    
    

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



-(void)UIInitTop
{
    userRecord = [NSMutableArray array];
    messageRecord = [NSMutableArray array];
    ImageRecord = [NSMutableArray array];
    UIImage *imag = [self imageWithColor:RGBACOLOR(56, 67, 69, 1.0) andSize:CGSizeMake(self.view.frame.size.width, 80)];
    [self.navigationController.navigationBar setBackgroundImage:imag forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    
    UIImageView *topview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewW, 120)];
    
    
    NSString *Userlogo=@"";
    NSString * d= _logo;
    if (d!=nil) {
        Userlogo = [IMAGEURL stringByAppendingString:d];
    }
    if(Userlogo.length>1)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
            NSURL *portraitUrl = [NSURL URLWithString: Userlogo];
            UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [topview setImageToBlur:protraitImg
                             blurRadius:kLBBlurredImageDefaultBlurRadius
                        completionBlock:^(){
                            
                        }];
            });
        });
    }
    else
    {
        _avatarImageView.image =  [UIImage imageNamed:@"defaultcgy"];
    }
    
    
    
    [self.view addSubview:topview];
    
    
    
    avatarImage = [UIImage imageNamed:@"yyh"];
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.5-35,10 , 70, 70)];
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = _avatarImageView.frame.size.width/2;
    _avatarImageView.image =avatarImage;
    // [NLUtils getLogos];
    
    if(Userlogo.length>1)
    {
        [_avatarImageView setImageURLStr:Userlogo placeholder:[UIImage imageNamed:@"defaultcgy"]];
    }
    else
    {
        _avatarImageView.image =  [UIImage imageNamed:@"defaultcgy"];
    }
    
    
    UILabel *lvtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, viewW, 20)];
    lvtitle.text = self.title;
    lvtitle.textAlignment = NSTextAlignmentCenter;
    lvtitle.textColor = [UIColor whiteColor];
    lvtitle.font = [UIFont systemFontOfSize: 16];
    [topview addSubview:_avatarImageView];
    [topview addSubview:lvtitle];
    
    
    lvmessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, viewW*0.33, 20)];
  //  lvmessage.text =[NSString stringWithFormat:@"消息：%@",userInfodic[@"xx_num"]];
    lvmessage.textAlignment = NSTextAlignmentRight;
    lvmessage.textColor = [UIColor whiteColor];
    lvmessage.font = [UIFont systemFontOfSize: 12];
    lvmessage.tag = 1000;
  
   
    lvmessage.userInteractionEnabled = YES;
    [lvmessage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(teleButtonEvent:)]];
    [topview addSubview:lvmessage];
    
    lvguanzhu = [[UILabel alloc] initWithFrame:CGRectMake(viewW*0.33, 100, viewW*0.33, 20)];
  //  lvguanzhu.text =[NSString stringWithFormat: @"关注：%@",userInfodic[@"gz_num"]];
     lvguanzhu.tag = 1001;
    lvguanzhu.textAlignment = NSTextAlignmentCenter;
    lvguanzhu.textColor = [UIColor whiteColor];
    lvguanzhu.font = [UIFont systemFontOfSize: 12];
    lvguanzhu.userInteractionEnabled = YES;
    lvguanzhu.userInteractionEnabled = YES;
    [lvguanzhu addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taplb:)]];
    [self.view addSubview:lvguanzhu];
    lvfans = [[UILabel alloc] initWithFrame:CGRectMake(viewW*0.66, 100, viewW*0.33, 20)];
 //   lvfans.text = [NSString stringWithFormat:@"粉丝：%@",userInfodic[@"bei_gz_num"]];
    lvfans.textAlignment = NSTextAlignmentLeft;
    lvfans.textColor = [UIColor whiteColor];
    lvfans.font = [UIFont systemFontOfSize: 12];
    lvfans.tag = 1002;
    lvfans.userInteractionEnabled = YES;
    [lvfans addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taplb:)]];
    [self.view addSubview:lvfans];

    
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


@end


