//
//  MessageViewController.m
//  Ciguangyin
//
//  Created by mac on 15/7/9.
//  Copyright (c) 2015年 ddsw. All rights reserved.
//
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
#import "MyBlockUI.h"
#import "YGMyReleaseInforCtr.h"
#import "CommentViewController.h"
#define CELL_WIDTH  ([[UIScreen mainScreen]bounds].size.width-20)/4
#define CELL_HEIGHT CELL_WIDTH+20
@interface MessageViewController ()<MJRefreshBaseViewDelegate>{
    UIScrollView *mScrollView;
    UISegmentedControl *segment;
    UITextView *textView;
    BOOL IsKV;
    NSMutableArray *topArray,*newArray,*myArray;
    int NewpageIndex,HotpageIndex,mypageIndex;
    NSString *reflID;
    UICollectionView *collectionview;
    NSArray *userRecord;
    NSMutableArray *messageRecord1 ;
    NSMutableArray *messageRecord ;
    NSArray *ImageRecord ;
    int totalpage ;
    int pageCount;
    int pageIndex;
    UITableView *TableView;
 
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    int count;
    NSMutableArray *images;
    UIScrollView *v1;
    NSString *str;
    NSMutableArray *yesno;
    
}

@end


@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
     [self loadDb:@"1"];
    
}
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
    ImageRecord = [NSMutableArray array];
    messageRecord1 = [NSMutableArray array];
    UIImage *imag = [self imageWithColor:RGBACOLOR(56, 67, 69, 1.0) andSize:CGSizeMake(self.view.frame.size.width, 80)];
    [self.navigationController.navigationBar setBackgroundImage:imag forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    pageIndex = 1;
   [self InitKeyboardText];
   [self initMJRefresh];
    
   
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self InitLoadData];
}



-(void)loadDb:(NSString *)indexPage
{
    
    [[CommonFunctions sharedlnstance] getmessBypgeNum:indexPage serid:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        
        [HUD hide:YES];
        NSDictionary *dic = (NSDictionary *)requestData;
        NSDictionary *dicxxImage = [dic objectForKey:@"xxImage"];
        NSDictionary *dicmessage = [dic objectForKey:@"message"];
    
//        NSString *d = [NSString stringWithFormat:@"%ld",dicmessage[@"totalpage"]];
       
        NSDictionary *dicuser = [dic objectForKey:@"user"];
        userRecord =dicuser[@"record"];
        messageRecord1 =dicmessage[@"record"];
        if ([indexPage isEqualToString:@"1"]) {
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
        
        [_header endRefreshing];
        [_footer endRefreshing];

        ImageRecord =(NSArray *)dicxxImage;
        totalpage = [dicmessage[@"totalpage"] intValue];
        pageCount = totalpage;
        [TableView reloadData];
        
        if (userRecord.count>0) {
            [ self tuijian ];
        }
    }
     
  ];

}


#pragma mark 上拉下拉刷新
-(void)initMJRefresh
{
    // 下拉刷新
    if (_header == nil)
    {
        _header = [[MJRefreshHeaderView alloc] init];
        _header.delegate = self;
        _header.scrollView = TableView;
        
    }
    
    // 上拉加载更多
    if (_footer == nil)
    {
        _footer = [[MJRefreshFooterView alloc] init];
        _footer.delegate = self;
        _footer.scrollView = TableView;
        
    }
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

-(void)InitNavigation{
    [super InitNavigation];
    [NavRightBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    [NavRightBtn setImage:[UIImage imageNamed:@"addicon"] forState:UIControlStateNormal];
    [NavLeftBtn setTitle:@"我的消息" forState:UIControlStateNormal];
    [NavLeftBtn setFont:[UIFont systemFontOfSize:12]];
    [NavLeftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [NavRightBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        PublishViewController *viewController = [[PublishViewController alloc] init];
        viewController.title = @"发布消息";
        [self.navigationController pushViewController:viewController animated:YES];
    }];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        YGMyReleaseInforCtr *vl = [[YGMyReleaseInforCtr alloc] init];
        vl.title = @"我发布的信息";
        [self.navigationController pushViewController:vl animated:YES];

    }];
    
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






#pragma mark - 加载控件
-(void)InitControl{
    pageIndex = 0;
    images = [NSMutableArray array];
    segment = [[UISegmentedControl alloc] initWithItems:@[@"动态",@"分类"]];
   // segment.segmentedControlStyle = UISegmentedControlStylePlain;
    segment.frame = CGRectMake(0,0, viewW, 30);
    segment.selectedSegmentIndex = 0;
    [segment setTintColor:[UIColor colorWithRed:252.0/255.0 green:175.0/255.0 blue:58.0/255.0 alpha:1.0]];
    [segment addTarget:self action:@selector(segmentedChangeds:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
    mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, winsize.width, winsize.height - 44 - 64 - 30)];
    mScrollView.showsHorizontalScrollIndicator = NO;
    mScrollView.showsVerticalScrollIndicator = NO;
    mScrollView.delegate = self;
    mScrollView.pagingEnabled = YES;
    mScrollView.contentSize = CGSizeMake(winsize.width *2, winsize.height - 44 - 64 - 30);
    mScrollView.contentOffset = CGPointMake(0, 0);
    [mScrollView scrollRectToVisible:CGRectMake(0, 0, winsize.width, winsize.height  - 44 - 64 - 30) animated:NO];
     [self.view addSubview:mScrollView];
    
    //-115
    TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 75, winsize.width, viewH-64-30-80-44)];
    TableView.tag = 10001;
    TableView.delegate = self;
    TableView.dataSource =self;
    TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [mScrollView addSubview:TableView];

  
     v1= [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewW, 60)];
    [v1 setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [mScrollView addSubview:v1];
    
    
    UIView *v2= [[UIView alloc] initWithFrame:CGRectMake(viewW, 0, viewW, winsize.height  - 44 - 64 - 30)];
    [v2 setBackgroundColor:[UIColor grayColor]];
    //[mScrollView addSubview:v2];
    
    UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing=0.0;
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(viewW, 0, viewW, winsize.height  - 44 - 64 - 30) collectionViewLayout:flowLayout];
    collectionview.dataSource=self;
    collectionview.delegate=self;
    collectionview.tag = 100;
  
     [collectionview setBackgroundColor:[UIColor clearColor]];
     
     [collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
     // 5.注册cell要用到的xib
     [collectionview registerNib:[UINib nibWithNibName:@"MessageViewCell" bundle:nil] forCellWithReuseIdentifier:@"MessageViewCell"];
     [mScrollView addSubview:collectionview];
}

-(void)tuijian
{
   
    
    [v1 removeFromSuperview];
     v1= [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,viewW, 75)];
    [v1 setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    v1.showsHorizontalScrollIndicator = YES;
    v1.showsVerticalScrollIndicator = YES;
    v1.delegate = self;
    v1.contentSize = CGSizeMake(viewW/4 * userRecord.count, 75);
    v1.contentOffset = CGPointMake(0, 0);
    
    [mScrollView  addSubview:v1];
  
    int w =20;
    for (int i=0; i<userRecord.count; i++) {
        NSDictionary *dic = userRecord[i];
        NSString *imageurl = [IMAGEURL stringByAppendingString:dic[@"image_url"]];
        
        UIImageView *v2 = [[UIImageView alloc] initWithFrame:CGRectMake(w, 5, 50, 50)];
        v2.layer.masksToBounds = YES;
        v2.layer.cornerRadius = 25;
        [v2 setImageURLStr: imageurl placeholder:[UIImage imageNamed:@"defaultcgy"]];
        [v1 addSubview:v2];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(w, 5, 50, 50)];
        [btn addTarget:self action:@selector(introduceView:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.text =[NSString stringWithFormat:@"%@|%@|%@",dic[@"user_id"],dic[@"user_name"],dic[@"image_url"]];//
      //  btn.tag = [dic[@"user_id"] intValue];
        [v1 addSubview:btn];
        
        UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(w, 55, 50, 20)];
        lb1.font = [UIFont systemFontOfSize:12];
        [lb1 setText:dic[@"user_name"]];
        lb1.textAlignment = NSTextAlignmentCenter;
        [v1 addSubview:lb1];
        w+= viewW/4;

    }

}

-(void)introduceView:(UIButton *)btn
{
    introduceNViewController *vc = [[introduceNViewController alloc] init];
    NSString *str =btn.titleLabel.text;
    NSArray *b = [str componentsSeparatedByString:@"|"];
    NSString *userid = [b objectAtIndex:0];
    NSString *username = [b objectAtIndex:1];
     NSString *imagelogo = [b objectAtIndex:2];
    vc.userid =userid;
    vc.title = username;
    vc.logo = imagelogo;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
        return  HH+h+85;

    }

    return  HH+85;

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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int count=messageRecord.count;

    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier;
   
    static  NSString *cellIn=@"haha";
    CommentsCell *Cell=[tableView dequeueReusableCellWithIdentifier:cellIn];

    if(Cell==nil){
        Cell=[[CommentsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIn];
    }
 
    [images removeAllObjects];
    NSDictionary *dic = messageRecord[indexPath.row];
    NSString *imageurl = [IMAGEURL stringByAppendingString:dic[@"user_image_url"]];
    NSString * strText = [dic objectForKey:@"context"];
   
    
    
    if([[Globle shareInstance].isLogThree  isEqualToString:@"y"])
    {
        NSString *name1 = [dic objectForKey:@"user_name"];
        if ([name1 isEqualToString:[Globle shareInstance].user_name]) {
             [Cell.Avatar setImageURLStr: [Globle shareInstance].image_url placeholder:[UIImage imageNamed:@"defaultcgy"]];
        }
        else
        {
            [Cell.Avatar setImageURLStr: imageurl placeholder:[UIImage imageNamed:@"defaultcgy"]];
        }
    }
    else
    {
         [Cell.Avatar setImageURLStr: imageurl placeholder:[UIImage imageNamed:@"defaultcgy"]];
    }
    
    
    UITapGestureRecognizer *labelTapGestureRecognizer3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTouchUpInside:)];
    
    Cell.Avatar.userInteractionEnabled=YES;
    [Cell.Avatar addGestureRecognizer:labelTapGestureRecognizer3];
    
    //NSString *sfsc = [dic objectForKey:@"sfsc"];
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
    
    
    
    Cell.NameLabel.text = [dic objectForKey:@"user_name"];
    Cell.ContentLabel.text = [dic objectForKey:@"context"];
    NSString *msmid = [dic objectForKey:@"id"];
    Cell.msid = msmid;
    
    NSString *strtime = [dic[@"fb_time"] substringToIndex:19];
    
    NSString *times = [TimeUtils intervalSinceNow:strtime];
    
    
    
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
   // [Cell.Reason addTarget:self action:@selector(focusOn:) forControlEvents:UIControlEventTouchUpInside];
    
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

-(void) imageTouchUpInside:(UITapGestureRecognizer *)recognizer{
    UILabel *label=(UILabel*)recognizer.view.superview.subviews[4];
    
    
    introduceNViewController *vc = [[introduceNViewController alloc] init];
    NSArray *b = [label.text componentsSeparatedByString:@"|"];
    NSString *userid = [b objectAtIndex:0];
    NSString *username = [b objectAtIndex:1];
    NSString *imagelogo = [b objectAtIndex:2];
    vc.userid =userid;
    vc.title = username;
    vc.logo = imagelogo;
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)jubao:(UIButton *)btn{
    
    UILabel *yyid =(UILabel *)btn.superview.subviews[3];
    NSString *mid =yyid.text;
    [[CommonFunctions sharedlnstance] jubaouser_id:[Globle shareInstance].user_id msg_id:mid context:@"" requestBlock:^(NSObject *requestData, BOOL IsError) {
        NSDictionary *rd= (NSDictionary *)requestData;
        if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
        {
            HUD.mode = MBProgressHUDModeText;
            [HUD setLabelText:@"举报成功！"];
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
            
        }
        else
        {
            HUD.mode = MBProgressHUDModeText;
            [HUD setLabelText:@"举报失败！"];
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
            
        }
    }];
}

-(void)Conmments:(UIButton *)btn{
    NSString *idd = btn.titleLabel.text;
    CommentViewController *vc= [[CommentViewController alloc] init];
    vc.idd = idd;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)focusOn:(UIButton *)btn
{
   
    [btn setBackgroundImage:[UIImage imageNamed:@"collect_pressed"] forState:UIControlStateNormal];
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


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    int index =indexPath.row;
    static NSString* CellIdentifier=@"MessageViewCell";
    MessageViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    //cell=[[FunctionCell alloc]init];
    // cell.backgroundColor=[UIColor clearColor];
 
    if (index == 0) {
        cell.logoImage.image =[UIImage imageNamed:@"buddhistLearning"];
    }
    if (index == 1) {
         cell.logoImage.image  = [UIImage imageNamed:@"mageOpen"];
    }
    if (index == 2) {
        cell.logoImage.image  = [UIImage imageNamed:@"scienceRowei"];
    }
    if (index == 3) {
        cell.logoImage.image  = [UIImage imageNamed:@"vegan"];
    }
    if (index == 4) {
         cell.logoImage.image  = [UIImage imageNamed:@"meditation"];
    }
    if (index == 5) {
         cell.logoImage.image  = [UIImage imageNamed:@"lifeApperception"];
    }
    if (index == 6) {
        cell.logoImage.image  = [UIImage imageNamed:@"health"];
    }
    if (index == 7) {
        cell.logoImage.image  = [UIImage imageNamed:@"family"];
    }
    if (index == 8) {
         cell.logoImage.image  = [UIImage imageNamed:@"horizon"];
    }
    if (index == 9) {
         cell.logoImage.image  = [UIImage imageNamed:@"vita"];
    }
    if (index == 10) {
         cell.logoImage.image  = [UIImage imageNamed:@"gukhak"];
    }
    if (index == 11) {
         cell.logoImage.image  = [UIImage imageNamed:@"paintingAndCalligraphy"];
    }
    return cell;
    

}

#pragma mark - UISegmentedControl
-(void)segmentedChangeds:(UISegmentedControl *)sender{
    [mScrollView scrollRectToVisible:CGRectMake(sender.selectedSegmentIndex * winsize.width, 0, winsize.width, winsize.height - 50 - 50 - 50) animated:YES];
    
}



-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    UICollectionViewCell* cell=[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor=[UIColor lightTextColor];//RGBACOLOR(231, 231, 231, 1.0)
}


#pragma mark   --UICollectionViewDelegateFlowLayout


//定义每个Item的大小

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CELL_WIDTH+5, CELL_HEIGHT);
}




//定义每个UICollectionView的margin

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}


#pragma  mark  --UICollectionViewDelegate

//UICollectionViewCell被选中时调用的方法

-(void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    ClassificationController *vc = [[ClassificationController alloc] init];
    
    if(indexPath.row == 0)
    {
        vc.title = @"佛学学习";
        vc.type = @"fxxx";
    }
    if(indexPath.row == 1)
    {
        vc.title = @"法师开示";
          vc.type = @"fsks";
    }
    if(indexPath.row == 2)
    {
        vc.title = @"科学放生";
          vc.type = @"kxfs";
    }
    if(indexPath.row == 3)
    {
        vc.title = @"素食";
          vc.type = @"ss";
    }
    if(indexPath.row == 4)
    {
        vc.title = @"禅修";
          vc.type = @"cx";
    }
    if(indexPath.row == 5)
    {
        vc.title = @"生活感悟";
          vc.type = @"shgw";
    }
    if(indexPath.row == 6)
    {
        vc.title = @"健康";
          vc.type = @"jk";
    }
    if(indexPath.row == 7)
    {
        vc.title = @"家庭";
          vc.type = @"jt";
    }
    if(indexPath.row == 8)
    {
        vc.title = @"事业";
          vc.type = @"sy";
    }
    if(indexPath.row == 9)
    {
        vc.title = @"生命";
          vc.type = @"sm";
    }
    if(indexPath.row == 10)
    {
        vc.title = @"国学";
         vc.type = @"gx";
    }
    if(indexPath.row == 11)
    {
        vc.title = @"书画";
          vc.type = @"sh";
    }
    
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - UIScrollView
-(void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView{
    if(![_scrollView isKindOfClass:[UITableView class]]){
        segment.selectedSegmentIndex = _scrollView.contentOffset.x / winsize.width;

    }
}


@end
