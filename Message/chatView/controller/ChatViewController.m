//
//  ChatViewController.m
//  HomeAdorn
//
//  Created by mac on 15/8/16.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "ChatViewController.h"
#import "ChartMessage.h"
#import "ChartCellFrame.h"
#import "ChartCell.h"
#import "KeyBordVIew.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "NSString+DocumentPath.h"
#import "Globle.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,KeyBordVIewDelegate,ChartCellDelegate,AVAudioPlayerDelegate,MJRefreshBaseViewDelegate>
{
    //////////////
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) KeyBordVIew *keyBordView;
@property (nonatomic,strong) NSMutableArray *cellFrames;
@property (nonatomic,assign) BOOL recording;
@property (nonatomic,strong) NSString *fileName;
@property (nonatomic,strong) AVAudioRecorder *recorder;
@property (nonatomic,strong) AVAudioPlayer *player;



@end
static NSString *const cellIdentifier=@"私信";
@implementation ChatViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
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
-(void)initwithData
{
    
    NSString *string = [NSString stringWithFormat:@"%@%@",ServiceAddress,@"cgy/appCgyMeg/getAllMessage.do",[Globle shareInstance].user_id,_getId];
    NSURL *url = [NSURL URLWithString:string];
 
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:_getId forKey:@"user_id"];
    [request setPostValue:[Globle shareInstance].user_id forKey:@"current_user_id"];
   
    request.delegate = self;
    //异步发送请求
    [request startSynchronous];
    
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{ 
    [_header endRefreshing];
    [_footer endRefreshing];

    NSString *re = request.responseString;
    NSDictionary *dic = [re JSONValue];
    
    if (request.tag == 1000) {
        
    }
    else
    {
        
        self.cellFrames=[NSMutableArray array];
        
        NSDictionary  *userInfo = [dic objectForKey:@"userinfo"];
        NSArray *arrUser = (NSArray *)dic[@"userinfo"];
        NSArray  *msg = (NSArray *) dic[@"list"][@"record"];
        NSString *user1 = [Globle shareInstance].user_id;
        
        if (arrUser.count>2) {
            NSString *imageurl =[IMAGEURL stringByAppendingString:[userInfo objectForKey:@"image_url"]];
            
            NSString *imageurl2 =[IMAGEURL stringByAppendingString:[Globle shareInstance].image_url];
            
            
            
            for (int i = 0; i < msg.count; i++) {
                NSDictionary *dict = (NSDictionary *)msg[msg.count - i-1];
                NSString *idd = dict[@"id"];
                NSString *content = dict[@"content"];
                NSString *user_id = dict[@"user_id"];
                NSString *ty = @"0";
                NSString *iurl = @"";
                if ([user_id isEqualToString:user1]) {
                    ty = @"0";
                    iurl = imageurl2;
                }
                else
                {
                    iurl = imageurl;
                    ty = @"1";
                }
                NSString *send_time = dict[@"send_time"];
                NSDictionary *dictionary = @{
                                             
                                             @"content" : content,
                                             @"icon" : iurl,
                                             @"type" : ty,
                                             @"time" : send_time
                                             };
                
                ChartCellFrame *cellFrame=[[ChartCellFrame alloc]init];
                ChartMessage *chartMessage=[[ChartMessage alloc]init];
                chartMessage.dict=dictionary;
                cellFrame.chartMessage=chartMessage;
                [self.cellFrames addObject:cellFrame];
            }
            
            
            [self.tableView reloadData];
            
            
        }
    }
    

 }
-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.view.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"私信";
    self.view.backgroundColor=[UIColor whiteColor];
    
    //add UItableView
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-108) style:UITableViewStylePlain];
    [self.tableView registerClass:[ChartCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_bg_default.jpg"]];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
    
    //add keyBorad
    
    self.keyBordView=[[KeyBordVIew alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-108, self.view.frame.size.width, 44)];
    self.keyBordView.delegate=self;
    [self.view addSubview:self.keyBordView];
    //初始化数据
    [self initwithData];
    
    [self initMJRefresh];
}

#pragma mark 上拉下拉刷新
-(void)initMJRefresh
{
    // 下拉刷新
    if (_header == nil)
    {
        _header = [[MJRefreshHeaderView alloc] init];
        _header.delegate = self;
        _header.scrollView =  self.tableView;
        
    }
    
    // 上拉加载更多
    if (_footer == nil)
    {
        _footer = [[MJRefreshFooterView alloc] init];
        _footer.delegate = self;
        _footer.scrollView =  self.tableView;
        
    }
}


#pragma mark 上拉下拉刷新的代理方法

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH : mm : ss.SSS";
    
   
    
    if (_header == refreshView)
    {
        [self initwithData];
    }
    else
    {
        [self initwithData];
      
    }
    
    
}







-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellFrames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChartCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate=self;
    cell.cellFrame=self.cellFrames[indexPath.row];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellFrames[indexPath.row] cellHeight];
}
-(void)chartCell:(ChartCell *)chartCell tapContent:(NSString *)content
{
    if(self.player.isPlaying){
        
        [self.player stop];
    }
    //播放
    NSString *filePath=[NSString documentPathWith:content];
    NSURL *fileUrl=[NSURL fileURLWithPath:filePath];
    [self initPlayer];
    NSError *error;
    self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:&error];
    [self.player setVolume:1];
    [self.player prepareToPlay];
    [self.player setDelegate:self];
    [self.player play];
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
}
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [[UIDevice currentDevice]setProximityMonitoringEnabled:NO];
    [self.player stop];
    self.player=nil;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
}
-(void)KeyBordView:(KeyBordVIew *)keyBoardView textFiledReturn:(UITextField *)textFiled
{
    //send_user_id(发送人ID)、receive_user_id(接收人ID)、content(发送内容)
    
    NSString *string = [NSString stringWithFormat:@"%@%@",ServiceAddress,@"cgy/appCgyMeg/sendMessage.do"];
    NSURL *url = [NSURL URLWithString:string];
    //send_user_id=%@&receive_user_id=%@&content=%@
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[Globle shareInstance].user_id forKey:@"send_user_id"];
    [request setPostValue:_getId forKey:@"receive_user_id"];
    [request setPostValue:textFiled.text forKey:@"content"];
    request.tag = 1000;
    request.delegate = self;
    
     [_keyBordView resignFirstResponder];
    //异步发送请求
    [request startSynchronous];


    ChartCellFrame *cellFrame=[[ChartCellFrame alloc]init];
    ChartMessage *chartMessage=[[ChartMessage alloc]init];
    
    //        int random=arc4random_uniform(2);
    int random= 0;
    NSLog(@"%d",random);
    NSString *imageurl2 =[IMAGEURL stringByAppendingString:[Globle shareInstance].image_url];
    chartMessage.icon=imageurl2;
    chartMessage.messageType=random;
    chartMessage.content=textFiled.text;
    cellFrame.chartMessage=chartMessage;
    
    [self.cellFrames addObject:cellFrame];
    [self.tableView reloadData];
    
    //滚动到当前行
    [self tableViewScrollCurrentIndexPath];
    textFiled.text=@"";
    
}






-(void)KeyBordView:(KeyBordVIew *)keyBoardView textFiledBegin:(UITextField *)textFiled
{
   
    [self tableViewScrollCurrentIndexPath];
    
}
-(void)beginRecord
{
    if(self.recording)return;
    
    self.recording=YES;
    
    NSDictionary *settings=[NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithFloat:8000],AVSampleRateKey,
                            [NSNumber numberWithInt:kAudioFormatLinearPCM],AVFormatIDKey,
                            [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
                            [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                            nil];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *fileName = [NSString stringWithFormat:@"rec_%@.wav",[dateFormater stringFromDate:now]];
    self.fileName=fileName;
    NSString *filePath=[NSString documentPathWith:fileName];
    NSURL *fileUrl=[NSURL fileURLWithPath:filePath];
    NSError *error;
    self.recorder=[[AVAudioRecorder alloc]initWithURL:fileUrl settings:settings error:&error];
    [self.recorder prepareToRecord];
    [self.recorder setMeteringEnabled:YES];
    [self.recorder peakPowerForChannel:0];
    [self.recorder record];
    
}
-(void)finishRecord
{
    self.recording=NO;
    [self.recorder stop];
    self.recorder=nil;
    ChartCellFrame *cellFrame=[[ChartCellFrame alloc]init];
    ChartMessage *chartMessage=[[ChartMessage alloc]init];
    
    int random=arc4random_uniform(2);
    NSLog(@"%d",random);
    NSString *imageurl2 =[IMAGEURL stringByAppendingString:[Globle shareInstance].image_url];
    chartMessage.icon=imageurl2;
    chartMessage.messageType=random;
    chartMessage.content=self.fileName;
    cellFrame.chartMessage=chartMessage;
    [self.cellFrames addObject:cellFrame];
    [self.tableView reloadData];
    [self tableViewScrollCurrentIndexPath];
    
}
-(void)tableViewScrollCurrentIndexPath
{
    if (self.cellFrames.count>1) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.cellFrames.count-1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    else
    {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.cellFrames.count-1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:0 atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
}
-(void)initPlayer{
    //初始化播放器的时候如下设置
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                            sizeof(sessionCategory),
                            &sessionCategory);
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    audioSession = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
