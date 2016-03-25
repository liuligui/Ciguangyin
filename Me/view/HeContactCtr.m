//
//  HeContactCtr.m
//  HomeAdorn
//
//  Created by liuligui on 15/8/23.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "HeContactCtr.h"
#import "YGMyContactCtr.h"
#import "YGMyContactCell.h"
#import "Globle.h"
#define Identifier @"YGMyContactCell"
#import "UIImageView+MJWebCache.h"

@interface HeContactCtr ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *scrollView;
    UISegmentedControl *segment;
    NSArray  *myConcren;
    NSArray  *ConcrenMe;
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITableView *tableView1;
@property (nonatomic,strong)NSArray *dataArr;

@end

@implementation HeContactCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"他的通信录";
    myConcren = [NSMutableArray array];
    ConcrenMe = [NSMutableArray array];
    segment = [[UISegmentedControl alloc]initWithItems:@[@"他关注的",@"他的粉丝"]];
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
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64-45)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 10000;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [scrollView addSubview:_tableView];
    
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_W, 0, SCREEN_W, SCREEN_H-64-45)];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.tag = 10001;
    [_tableView1 setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [scrollView addSubview:_tableView1];
    [self InitData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 10000) {
        return  myConcren.count;
    }
    if ( tableView.tag == 10001)
    {
        return  ConcrenMe.count;
    }
    
    return 0;
    
    
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
        
        cell.userLogo.layer.masksToBounds = YES;
        cell.userLogo.layer.cornerRadius = 25;
        return cell;
        [cell.concern addTarget:nil action:@selector(concern:) forControlEvents:UIControlEventTouchDown];
    }
    
    
    
    
    return nil;
    
}

-(void)concern:(UIButton *)btn
{
    int tg = btn.superview.tag;
    
    
}
#pragma mark - UISegmentedControl
-(void)segmentChange:(UISegmentedControl *)sender{
    [scrollView scrollRectToVisible:CGRectMake(sender.selectedSegmentIndex * winsize.width, 0, winsize.width, winsize.height - 50 - 50 - 50) animated:YES];
    if (segment.selectedSegmentIndex == 0) {
        
        [self InitData];
    }
    if (segment.selectedSegmentIndex == 1) {
        [self InitData2];
    }
}


-(void)InitData
{
    
    [[CommonFunctions sharedlnstance] heConcern:_user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        
        
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
//            int count = [dic[@"count"] intValue];
//            if (count>0) {
//                myConcren = dic[@"record"];
//                [_tableView reloadData];
//            }
            myConcren = dic[@"record"];
            [_tableView reloadData];
        }
        
    }];
    
}

-(void)InitData2
{
    
    
    [[CommonFunctions sharedlnstance] Concernhe:_user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        
        
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
//            int count = [dic[@"count"] intValue];
//            if (count>0) {
//                ConcrenMe = dic[@"record"];
//                [_tableView1 reloadData];
//            }
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
            
            [self InitData];
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

