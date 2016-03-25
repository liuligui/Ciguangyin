
//
//  YGMyContactCtr.m
//  HomeAdorn
//
//  Created by wangxiaoer on 7/24/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import "YGMyContactCtr.h"
#import "YGMyContactCell.h"
#import "Globle.h"
#define Identifier @"YGMyContactCell"
#import "UIImageView+MJWebCache.h"

@interface YGMyContactCtr ()<MJRefreshBaseViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *scrollView;
    UISegmentedControl *segment;
    NSMutableArray  *myConcren;
    NSMutableArray  *ConcrenMe;
    NSMutableArray  *messageRecord1;
    UITableView *_tableView;
    UITableView *_tableView1;
    NSArray *_dataArr;
    int totalpage ;
    int pageCount;
    int pageIndex;
    
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    int count;
}



@end

@implementation YGMyContactCtr

- (void)viewDidLoad {
    [super viewDidLoad];

    myConcren = [NSMutableArray array];
    ConcrenMe = [NSMutableArray array];
     messageRecord1 = [NSMutableArray array];
    segment = [[UISegmentedControl alloc]initWithItems:@[@"我关注的",@"关注我的"]];
    segment.frame = CGRectMake(-5, 0, SCREEN_W+10, 45);
    segment.selectedSegmentIndex = 0;
    [segment setTintColor:rgb_color(252, 175, 58, 1)];
    [segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_W, SCREEN_H - 64 - 45)];
    scrollView.contentSize = CGSizeMake(SCREEN_W*2, SCREEN_H-64-45);
    scrollView.contentOffset = CGPointMake(0, 0);
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [scrollView scrollRectToVisible:CGRectMake(0, 0, SCREEN_W, SCREEN_H) animated:YES];
    [self.view addSubview:scrollView];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H- 64 - 45)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 10000;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [scrollView addSubview:_tableView];
    
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_W, 0, SCREEN_W, SCREEN_H- 64 - 45)];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.tag = 10001;
    [_tableView1 setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [scrollView addSubview:_tableView1];
        [self initMJRefresh];
    [self InitData:@"1"];

    
    
}


#pragma mark 上拉下拉刷新
-(void)initMJRefresh
{
    // 下拉刷新
    if (_header == nil)
    {
        _header = [[MJRefreshHeaderView alloc] init];
        _header.delegate = self;
        _header.scrollView = _tableView;
        
        
    }
    
    // 上拉加载更多
    if (_footer == nil)
    {
        _footer = [[MJRefreshFooterView alloc] init];
        _footer.delegate = self;
        _footer.scrollView = _tableView;
        
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 10000) {
        return  myConcren.count;
    }
    if ( tableView.tag == 10001)
    {
        return  ConcrenMe.count;
    }
    
    return nil;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView.tag == 10000) {
        static NSString *CellTableIdentifier = @"YGMyContactCell";
        BOOL nibsRegistered = NO;
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:@"YGMyContactCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
            nibsRegistered = YES;
        }
        YGMyContactCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 CellTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *dic;
        dic =  myConcren[indexPath.row];
        cell.title1.text = dic[@"user_name"];;
        cell.detail.text =dic[@"user_sign"];
        [cell.userLogo setImageURLStr: [IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]]
                      placeholder:[UIImage imageNamed:@"defaultcgy"]];
        cell.userLogo.layer.masksToBounds = YES;
        [cell.concern addTarget:nil action:@selector(concern:) forControlEvents:UIControlEventTouchDown];
         int row = indexPath.row;
         cell.phone.text  = [NSString stringWithFormat:@"%@|%@|%d",dic[@"bei_gz_user"],@"10001",row];
        cell.userLogo.layer.cornerRadius = 25;
        return cell;
    }
    if (tableView.tag == 10001) {
        static NSString *CellTableIdentifier = @"YGMyContactCell";
        BOOL nibsRegistered = NO;
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:@"YGMyContactCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
            nibsRegistered = YES;
        }
        YGMyContactCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 CellTableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *dic;
        dic =  ConcrenMe[indexPath.row];
        cell.title1.text = dic[@"user_name"];;
        cell.detail.text = dic[@"user_sign"];
        [cell.userLogo setImageURLStr: [IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]] placeholder:[UIImage imageNamed:@"defaultcgy"]];
       // cell.phone.text = dic[@"bei_gz_user"];
        int row = indexPath.row;
        cell.phone.text  = [NSString stringWithFormat:@"%@|%@|%d",dic[@"bei_gz_user"],@"10001",row];
        [cell.concern setHidden:YES];
        cell.userLogo.layer.masksToBounds = YES;
        cell.userLogo.layer.cornerRadius = 25;
        return cell;
        
    }
    
    
    
    
    return nil;
    
}

-(void)concern:(UIButton *)btn
{
    UIView *tg = btn.superview;
    UILabel *lb = tg.subviews[4];
    NSString *beigz =lb.text;
    NSArray *arr = [beigz componentsSeparatedByString:@"|"];
    
    [[CommonFunctions sharedlnstance] cancelGzUser:[Globle shareInstance].user_id BGzUser:arr[0] requestBlock:^(NSObject *requestData, BOOL IsError) {

        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *rd= (NSDictionary *)requestData;
            if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
            {
                HUD.mode = MBProgressHUDModeText;
                [HUD setLabelText:@"取消成功！"];
                [HUD show:YES];
                [HUD hide:YES afterDelay:1];
                [self InitData:@"1"];
              
            
            }
            
            }
            else
            {
                HUD.mode = MBProgressHUDModeText;
                [HUD setLabelText:@"取消失败！"];
                [HUD show:YES];
                [HUD hide:YES afterDelay:1];
                
            }
           
        }
        
    ];

    
}
#pragma mark - UISegmentedControl
-(void)segmentChange:(UISegmentedControl *)sender{
    [scrollView scrollRectToVisible:CGRectMake(sender.selectedSegmentIndex * winsize.width, 0, winsize.width, winsize.height - 50 - 50 - 50) animated:YES];
    if (segment.selectedSegmentIndex == 0) {
        
        pageIndex = 1;
        [self InitData:@"1"];
    }
    if (segment.selectedSegmentIndex == 1) {
        [self InitData2];
    }
}


-(void)InitData :(NSString *)index
{
    [self loadDb:index];
}
-(void)loadDb:(NSString *)index
{

    [[CommonFunctions sharedlnstance] MyConcern:[Globle shareInstance].user_id   pageNum:index  requestBlock:^(NSObject *requestData, BOOL IsError) {
        [_header endRefreshing];
        [_footer endRefreshing];
        
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            int count = [dic[@"count"] intValue];
            //     [myConcren removeAllObjects];
            
//            if ([index isEqualToString:@"1"]) {
//                [myConcren removeAllObjects];
//            }
            
//            if (messageRecord1.count>0) {
//                for (int i=0; i<messageRecord1.count; i++) {
//                    [myConcren addObject:messageRecord1[i]];
//                }
//                
//            }
            [_header endRefreshing];
            [_footer endRefreshing];

            
            
            myConcren = dic[@"record"];
            [_tableView reloadData];
            
        }
        
    }];
}



-(void)InitData2
{
     ConcrenMe = nil;
    
    [[CommonFunctions sharedlnstance] ConcernMe:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        
        
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            int count = [dic[@"count"] intValue];
          
                ConcrenMe = dic[@"record"];
               [_tableView1 reloadData];
            
        }
        
    }];
}
#pragma mark - UIScrollView

-(void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView{
    if(![_scrollView isKindOfClass:[UITableView class]]){
        segment.selectedSegmentIndex = _scrollView.contentOffset.x / winsize.width;
        if (segment.selectedSegmentIndex == 0) {
            
            [self InitData:@"1"];
        }
        if (segment.selectedSegmentIndex == 1) {
            [self InitData2];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 10000) {
        
        
    }
    if (tableView.tag == 10001) {
        
        
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

@end
