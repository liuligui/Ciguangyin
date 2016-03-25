


//
//  chatmsgViewController.m
//  HomeAdorn
//
//  Created by mac on 15/8/16.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "chatmsgViewController.h"
#import "YGMyAppointmentCtr.h"
#import "chatMsgTableViewCell.h"
#import "UIImageView+MJWebCache.h"
#import "Globle.h"
#import "CommentViewController.h"
#import "ChatViewController.h"
#import "UIView+Frame.h"
#import "WZLBadgeImport.h"
#define Identifier @"chatMsgTableViewCell"


@interface chatmsgViewController ()<UITableViewDataSource,UITableViewDelegate,UITableViewDelegate,MJRefreshBaseViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISegmentedControl *segment;;
    UIScrollView *mScrollView;
    UICollectionView *collectionview;
    NSArray *record;
    NSArray *record1;
    
    int totalpage ;
    int pageCount;
    int pageIndex;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    int count;
    
    int totalpage1 ;
    int pageCount1;
    int pageIndex1;
    MJRefreshHeaderView *_header1;
    MJRefreshFooterView *_footer1;
    int count1;
    
    NSMutableArray *staticBadges ;
    NSMutableArray *dynamicBadges ;

    
    
    
}

@property (nonatomic,strong)UITableView *tableView1;
@property (nonatomic,strong)UITableView *tableView2;

@property (nonatomic,strong)NSArray *dataArr;


@end

@implementation chatmsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的信息";
     WBadgeStyle styles[] = {WBadgeStyleRedDot, WBadgeStyleNew, WBadgeStyleNumber, WBadgeStyleNumber};
    staticBadges = [NSMutableArray array];
    dynamicBadges = [NSMutableArray array];

    record = [NSMutableArray array];
    record1 = [NSMutableArray array];
    [self initMJRefresh];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self InitLoadData:@"1" ];
    [self InitLoadData2:@"1" ];
}

-(void)InitControl{
    segment = [[UISegmentedControl alloc] initWithItems:@[@"私信",@"评论"]];
    // segment.segmentedControlStyle = UISegmentedControlStylePlain;
    segment.frame = CGRectMake(-5, 0, viewW+10, 30);
    segment.selectedSegmentIndex = 0;
    [segment setTintColor:[UIColor colorWithRed:252.0/255.0 green:175.0/255.0 blue:58.0/255.0 alpha:1.0]];
    [segment addTarget:self action:@selector(segmentedChangeds:) forControlEvents:UIControlEventValueChanged];
    
    
    [self.view addSubview:segment];
    
    mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, winsize.width, winsize.height - 64 - 30)];
    mScrollView.showsHorizontalScrollIndicator = NO;
    mScrollView.showsVerticalScrollIndicator = NO;
    mScrollView.delegate = self;
    mScrollView.pagingEnabled = YES;
    mScrollView.contentSize = CGSizeMake(winsize.width *2, winsize.height - 44 - 64 - 30);
    mScrollView.contentOffset = CGPointMake(0, 0);
    [mScrollView scrollRectToVisible:CGRectMake(0, 0, winsize.width, winsize.height  - 64 - 30) animated:NO];
    //mScrollView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:mScrollView];
    
    
    UIView *v1= [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewW, winsize.height - 64 - 30)];
    [v1 setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [mScrollView addSubview:v1];
    
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64 - 30)];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.backgroundColor = [UIColor whiteColor];
    [_tableView1 registerNib:[UINib nibWithNibName:Identifier
                                            bundle:nil] forCellReuseIdentifier:Identifier];
    [_tableView1 setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    _tableView1.tableFooterView = view;
    [v1 addSubview:_tableView1];
    
    
    UIView *v2= [[UIView alloc] initWithFrame:CGRectMake(viewW, 0, viewW, winsize.height   - 64 - 30)];
    [v2 setBackgroundColor:[UIColor grayColor]];
    [mScrollView addSubview:v2];
    
    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64 - 30)];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    _tableView2.backgroundColor = [UIColor whiteColor];
    [_tableView2 registerNib:[UINib nibWithNibName:Identifier
                                            bundle:nil] forCellReuseIdentifier:Identifier];
    [_tableView2 setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
  
    _tableView2.tableFooterView = view;
    
    [v2 addSubview:_tableView2];
    
}

#pragma mark - tableview
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == _tableView1)
    {
        return record.count;
    }
    else
    {
        return record1.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 57;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    chatMsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        
        cell = [[chatMsgTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
    cell.btnnum.layer.cornerRadius = cell.btnnum.width / 2;
    if (tableView == _tableView1) {
        NSDictionary *dic = record[indexPath.row];
        cell.name.text = dic[@"user_name"];
        cell.msg.text =  dic[@"sx_context"];
       int a =[dic[@"contNum"] intValue];
        [cell.btnnum showBadgeWithStyle:WBadgeStyleNumber value:a animationType:WBadgeAnimTypeNone];
        [dynamicBadges addObject:cell.btnnum];
        
        cell.time.text = [ dic[@"send_time"] substringToIndex:16];
        cell.logo.layer.masksToBounds = YES;
        cell.logo.layer.cornerRadius = cell.logo.frame.size.width/2;
        [cell.logo setImageURLStr: [IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]] placeholder:[UIImage imageNamed:@"defaultcgy"]];
        [cell.btnclick handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            ChatViewController *v = [[ChatViewController alloc] init];
            v.getId =  dic[@"sx_user"];
            
            [self.navigationController pushViewController:v animated:YES];

        }];
        
    }
    if (tableView == _tableView2) {
        NSDictionary *dict = record1[indexPath.row];
   
        int a =[dict[@"conutNum"] intValue];
        [cell.btnnum showBadgeWithStyle:WBadgeStyleNumber value:a animationType:WBadgeAnimTypeNone];
        [dynamicBadges addObject:cell.btnnum];

        
        cell.name.text = dict[@"fb_context"];
        cell.msg.text =  dict[@"pl_context"];
        cell.time.text = [ dict[@"pl_time"] substringToIndex:16];
        cell.logo.layer.masksToBounds = YES;
        cell.logo.layer.cornerRadius = cell.logo.frame.size.width/2;
        [cell.logo setImageURLStr: [IMAGEURL stringByAppendingString:[dict objectForKey:@"pl_image"]] placeholder:[UIImage imageNamed:@"defaultcgy"]];
        [cell.btnclick handleControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            NSString *idd =  dict[@"fb_id"];
            CommentViewController *vc= [[CommentViewController alloc] init];
            vc.idd = idd;
            [self.navigationController pushViewController:vc animated:YES];
  
        }];

    }
   
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}



-(void)btncancal:(UIButton *)btn
{
    UILabel *yyid =(UILabel *)btn.superview.subviews[11];
    NSString *yid =yyid.text;
    
    [[CommonFunctions sharedlnstance] quxiaoyuyue:yid requestBlock:^(NSObject *requestData, BOOL IsError) {
        NSDictionary *rd= (NSDictionary *)requestData;
        if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
        {
            HUD.mode = MBProgressHUDModeText;
            [HUD setLabelText:@"取消预约成功！"];
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
            
        }
        else
        {
            HUD.mode = MBProgressHUDModeText;
            [HUD setLabelText:@"取消预约失败！"];
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
            
        }
    }];
    
    
}

#pragma mark - UISegmentedControl
-(void)segmentedChangeds:(UISegmentedControl *)sender{
    [mScrollView scrollRectToVisible:CGRectMake(sender.selectedSegmentIndex * winsize.width, 0, winsize.width, winsize.height - 50 - 50 - 50) animated:YES];
    if (segment.selectedSegmentIndex == 2) {
        if ([[userDefaults objectForKey:@"verification"] length] == 0) {
            segment.selectedSegmentIndex = 1;
            CGRect rect = CGRectMake(winsize.width*sender.selectedSegmentIndex, 0, winsize.width, winsize.height-mScrollView.frame.origin.y-64);
            [mScrollView scrollRectToVisible:rect animated:YES];
            return;
        }
    }
}

#pragma mark - UIScrollView
-(void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView{
    if(![_scrollView isKindOfClass:[UITableView class]]){
        segment.selectedSegmentIndex = _scrollView.contentOffset.x / winsize.width;
        if (segment.selectedSegmentIndex == 2) {
            if ([[userDefaults objectForKey:@"verification"] length] == 0) {
                segment.selectedSegmentIndex = 1;
                CGRect rect = CGRectMake(winsize.width*segment.selectedSegmentIndex, 0, winsize.width, winsize.height-mScrollView.frame.origin.y-64);
                [mScrollView scrollRectToVisible:rect animated:YES];
                //                [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
                return;
            }
        }
    }
}

-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 上拉下拉刷新
-(void)initMJRefresh
{
    // 下拉刷新
    if (_header == nil)
    {
        _header = [[MJRefreshHeaderView alloc] init];
        _header.delegate = self;
        _header.scrollView = _tableView1;
        
        _header1 = [[MJRefreshHeaderView alloc] init];
        _header1.delegate = self;
        _header1.scrollView = _tableView2;
        
        
    }
    
    // 上拉加载更多
    if (_footer == nil)
    {
        _footer = [[MJRefreshFooterView alloc] init];
        _footer.delegate = self;
        _footer.scrollView = _tableView1;
        
        _footer1 = [[MJRefreshFooterView alloc] init];
        _footer1.delegate = self;
        _footer1.scrollView = _tableView2;
        
    }
}



#pragma mark 上拉下拉刷新的代理方法

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
   int s =  segment.selectedSegmentIndex;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH : mm : ss.SSS";
    if (_header == refreshView)
    {
        if (s == 0) {
            pageIndex = 1;
            [self InitLoadData:@"1"];
        }
        else
        {
            pageIndex1 = 1;
            [self InitLoadData2:@"1"];

        }
        
        
    }
    else
    {
        if (s == 0) {
            if (pageIndex<pageCount) {
                pageIndex++;
                
                NSString *index = [NSString stringWithFormat:@"%d",pageIndex];
                [self InitLoadData:index];
            }
            else
            {
                [_header endRefreshing];
                [_footer endRefreshing];
                [_header1 endRefreshing];
                [_footer1 endRefreshing];
                
                
            }        }
        else
        {
            if (pageIndex1<pageCount1) {
                pageIndex1++;
                
                NSString *index = [NSString stringWithFormat:@"%d",pageIndex1];
                [self InitLoadData2:index];
            }
            else
            {
                [_header endRefreshing];
                [_footer endRefreshing];
                [_header1 endRefreshing];
                [_footer1 endRefreshing];
                
                
            }
        }
        
        
        
       
    }
    
    
}



-(void)InitLoadData:(NSString *)page{
 
    [[CommonFunctions sharedlnstance]  getMyMessage:[Globle shareInstance].user_id pageNum:page requestBlock:^(NSObject *requestData, BOOL IsError) {
        [HUD hide:YES];
        [_header endRefreshing];
        [_footer endRefreshing];
        [_header1 endRefreshing];
        [_footer1 endRefreshing];
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            record = (NSArray *) [dic objectForKey:@"record"];
            if (record.count) {
                totalpage = [dic[@"totalpage"] intValue];
                pageCount = totalpage;
                [_tableView1 reloadData];
            }
            else
            {
                HUD.mode = MBProgressHUDModeText;
                [HUD setLabelText:@"没有记录！"];
                [HUD show:YES];
                [HUD hide:YES afterDelay:1];
                
            }
            
        }
        
    }];
  

}




-(void)InitLoadData2:(NSString *)page{
    
    [[CommonFunctions sharedlnstance]  getPLMessage:[Globle shareInstance].user_id pageNum:page requestBlock:^(NSObject *requestData, BOOL IsError) {
        [HUD hide:YES];
        [_header endRefreshing];
        [_footer endRefreshing];
        [_header1 endRefreshing];
        [_footer1 endRefreshing];
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            record1 = (NSArray *) [dic objectForKey:@"record"];
            totalpage1 = [dic[@"totalpage"] intValue];
            pageCount1 = totalpage1;
            if (record1.count) {
            [_tableView2 reloadData];
            }
            else
            {
                HUD.mode = MBProgressHUDModeText;
                [HUD setLabelText:@"没有记录！"];
                [HUD show:YES];
                [HUD hide:YES afterDelay:1];
                
            }
            
        }
        
    }];
}

@end

