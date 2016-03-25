//
//  YGMyAppointmentCtr.m
//  HomeAdorn
//
//  Created by wangxiaoer on 7/21/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import "YGZhiBingCtr.h"
#import "MyAppointmentCell.h"
#import "YGZhiBingCell.h"
#define Identifier @"YGZhiBingCell"
#import "Globle.h"
#import "SUCTableViewCell.h"
#import "huifangViewController.h"
@interface YGZhiBingCtr ()<UITableViewDataSource,UITableViewDelegate,UITableViewDelegate,MJRefreshBaseViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISegmentedControl *segment;;
    UIScrollView *mScrollView;
    UICollectionView *collectionview;
    NSArray *record;
    NSArray *record1;
}


@property (nonatomic,strong)UITableView *tableView1;
@property (nonatomic,strong)UITableView *tableView2;

@property (nonatomic,strong)NSArray *dataArr;

@end

@implementation YGZhiBingCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self LoadData];
}
-(void)InitControl{
    //    refershHeaderArray = [[NSMutableArray alloc] init];
    //    refershFooterArray = [[NSMutableArray alloc] init];
    
    segment = [[UISegmentedControl alloc] initWithItems:@[@"请法中",@"历史记录"]];
    // segment.segmentedControlStyle = UISegmentedControlStylePlain;
    segment.frame = CGRectMake(0, 0, viewW, 30);
    segment.selectedSegmentIndex = 0;
    [segment setTintColor:[UIColor colorWithRed:252.0/255.0 green:175.0/255.0 blue:58.0/255.0 alpha:1.0]];
    [segment addTarget:self action:@selector(segmentedChangeds:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
    mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, winsize.width, winsize.height - 64 - 30)];
    mScrollView.showsHorizontalScrollIndicator = NO;
    mScrollView.showsVerticalScrollIndicator = NO;
    mScrollView.delegate = self;
    mScrollView.pagingEnabled = YES;
    mScrollView.contentSize = CGSizeMake(winsize.width *2, winsize.height- 64 - 30);
    mScrollView.contentOffset = CGPointMake(0, 0);
    [mScrollView scrollRectToVisible:CGRectMake(0, 0, winsize.width, winsize.height - 64 - 30) animated:NO];
    // mScrollView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:mScrollView];
    
    
    UIView *v1= [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewW, winsize.height - 64 - 30)];
    [v1 setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [mScrollView addSubview:v1];
    
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H- 64 - 30)];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView1.backgroundColor = [UIColor whiteColor];
    [_tableView1 registerNib:[UINib nibWithNibName:Identifier
                                            bundle:nil] forCellReuseIdentifier:Identifier];
    [_tableView1 setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [v1 addSubview:_tableView1];
    
    
    UIView *v2= [[UIView alloc] initWithFrame:CGRectMake(viewW, 0, viewW, winsize.height - 64 - 30)];
    [v2 setBackgroundColor:[UIColor grayColor]];
    [mScrollView addSubview:v2];
    
    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H- 64 - 30)];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView2.backgroundColor = [UIColor whiteColor];
    [_tableView2 registerNib:[UINib nibWithNibName:Identifier
                                            bundle:nil] forCellReuseIdentifier:Identifier];
    [_tableView2 setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
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
    
    return 130;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YGZhiBingCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        
        cell = [[YGZhiBingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }


    if (tableView == _tableView1) {
        NSDictionary *dic = record[indexPath.row];
        cell.no.text = dic[@"id"];
        cell.name.text = dic [@"qf_xm"];
        cell.illname.text = dic [@"sick_name"];
        cell.result.text = dic [@"result"];
        cell.huifan.text = dic [@"huifan"];
        if ([dic[@"qf_sex"] isEqualToString:@"1"]) {
             cell.sex.text = @"男";
        }
        else
        {
              cell.sex.text = @"女";
        }
        cell.huifan.text = @"回访";
        
        [cell.btnhuifang handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
            
            huifangViewController *vc = [[huifangViewController alloc] init];
            vc.mid = dic[@"id"];
            vc.name =  dic [@"qf_xm"];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }

    if (tableView == _tableView2) {
        
       
        
        static NSString *CellTableIdentifier = @"SUCTableViewCell";
        BOOL nibsRegistered = NO;
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:@"SUCTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
            nibsRegistered = YES;
        }
        SUCTableViewCell *ell = [tableView dequeueReusableCellWithIdentifier:
                                 CellTableIdentifier];

        
        NSDictionary *dic = record1[indexPath.row];
        ell.no.text = dic[@"id"];
        ell.naem.text = dic [@"qf_xm"];
        ell.bing.text = dic [@"sick_name"];
        ell.result.text = dic [@"hf_result"];
          ell.datetime.text = dic [@"hf_date"];
        if ([dic[@"qf_sex"] isEqualToString:@"1"]) {
            ell.sex.text = @"男";
        }
        else
        {
            ell.sex.text = @"女";
        }
        ell.last.text = @"请法成功";
//
        ell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return ell;
        
        
    }
    
    
   
    
    
//    huifangViewController
    
    return nil;
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
-(void)LoadData{
    //    NSArray *arrayInfo = (NSArray *)_dicInfo;
    //    NSDictionary *dic = arrayInfo[_index];
    [[CommonFunctions sharedlnstance] qingfazhibingdengjizhong:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        [HUD hide:YES];
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            record = (NSArray *) [dic objectForKey:@"record"];
            //if (record.count) {
                [_tableView1 reloadData];
            //}
            
        }
        
    }];
    
    [[CommonFunctions sharedlnstance] qingfazhibingsuoyoujilv:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        [HUD hide:YES];
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            record1 = (NSArray *) [dic objectForKey:@"record"];
            if (record1.count) {
                [_tableView2 reloadData];
            }
            
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
