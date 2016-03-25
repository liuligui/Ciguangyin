//
//  YGMyAppointmentCtr.m
//  HomeAdorn
//
//  Created by wangxiaoer on 7/21/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import "YGMyAppointmentCtr.h"
#import "MyAppointmentCell.h"
#import "Globle.h"
#define Identifier @"MyAppointmentCell"

@interface YGMyAppointmentCtr ()<UITableViewDataSource,UITableViewDelegate,UITableViewDelegate,MJRefreshBaseViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISegmentedControl *segment;;
    UIScrollView *mScrollView;
    UICollectionView *collectionview;
    NSMutableArray *record;
    NSMutableArray *record1;

}

@property (nonatomic,strong)UITableView *tableView1;
@property (nonatomic,strong)UITableView *tableView2;

@property (nonatomic,strong)NSArray *dataArr;

@end

@implementation YGMyAppointmentCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    record = [NSMutableArray array];
    record1 = [NSMutableArray array];
    
}

-(void)InitControl{
//    refershHeaderArray = [[NSMutableArray alloc] init];
//    refershFooterArray = [[NSMutableArray alloc] init];
    
    segment = [[UISegmentedControl alloc] initWithItems:@[@"历史记录",@"预约成功"]];
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
    [mScrollView scrollRectToVisible:CGRectMake(0, 0, winsize.width, winsize.height  - 44 - 64 - 30) animated:NO];
    //mScrollView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:mScrollView];
    
    
    UIView *v1= [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH - 64 - 30)];
    [v1 setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [mScrollView addSubview:v1];
    
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, viewH - 64 - 30)];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView1.backgroundColor = [UIColor whiteColor];
    [_tableView1 registerNib:[UINib nibWithNibName:Identifier
                                           bundle:nil] forCellReuseIdentifier:Identifier];
    [_tableView1 setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [v1 addSubview:_tableView1];
    
    
    UIView *v2= [[UIView alloc] initWithFrame:CGRectMake(viewW, 0, viewW, viewH - 64 - 30)];
    [v2 setBackgroundColor:[UIColor grayColor]];
    [mScrollView addSubview:v2];
    
    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, viewH - 64 - 30)];
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
    
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    MyAppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        
        cell = [[MyAppointmentCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
    if (tableView == _tableView1) {
        NSDictionary *dic = record[indexPath.row];
        cell.name.text = dic[@"yy_name"];
        cell.yyid.text = dic[@"id"];
        cell.address.text = dic [@"now_address"];
        cell.phone.text = dic [@"yy_phone"];
        cell.orderAddress.text = dic[@"yy_date"];
        if ([dic[@"yy_sex"] isEqualToString:@"1"]) {
              cell.sex.text =@"性别:男";
        }
        else
        {
             cell.sex.text =@"性别:女";
        }
        [cell.cancelBtn addTarget:self action:@selector(btncancal:) forControlEvents:UIControlEventTouchUpInside];


    }
    if (tableView == _tableView2) {
        NSDictionary *dic = record1[indexPath.row];
        cell.name.text = dic[@"yy_name"];
        cell.yyid.text = dic[@"id"];
        cell.address.text = dic [@"now_address"];
        cell.phone.text = dic [@"yy_phone"];
        cell.orderAddress.text = dic[@"yy_date"];
        if ([dic[@"yy_sex"] isEqualToString:@"1"]) {
            cell.sex.text =@"性别:男";
        }
        else
        {
            cell.sex.text =@"性别:女";
        }
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
-(void)InitLoadData{
//    NSArray *arrayInfo = (NSArray *)_dicInfo;
//    NSDictionary *dic = arrayInfo[_index];
    [[CommonFunctions sharedlnstance] yonghuyuyuesuoyoujilv:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        [HUD hide:YES];
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            NSArray *Array  = (NSArray *) [dic objectForKey:@"record"];
            
            for (int i=0;i<Array.count;i++) {
                NSDictionary *dic = Array[i];
                NSString *ss = dic[@"yy_static"];
                if ([ss isEqualToString:@"1"]) {
                    [record1 addObject: Array[i]];
                }
                else{
                    [record addObject: Array[i]];
                }
                
                
            }
            if (record.count) {
                [_tableView1 reloadData];
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
    
//    [[CommonFunctions sharedlnstance] yonghuyuyuechenggong:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
//        [HUD hide:YES];
//        if (!IsError) {
//            [HUD hide:YES];
//            NSDictionary *dic = (NSDictionary *)requestData;
//            record1 = (NSArray *) [dic objectForKey:@"record"];
//            if (record1.count) {
//                [_tableView2 reloadData];
//            }
//            
//            
//        }
//        
//    }];
}

@end
