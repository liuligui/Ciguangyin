//
//  YGMyAppointmentCtr.m
//  HomeAdorn
//
//  Created by wangxiaoer on 7/21/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import "YGGongDeCtr.h"
#import "YGGongDeCell.h"
#define Identifier @"YGGongDeCell"
#import "Globle.h"

@interface YGGongDeCtr ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *record;
}

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray *dataArr;

@end

@implementation YGGongDeCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    record = [NSMutableArray array];
    
    
}

-(void)InitControl{

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView registerNib:[UINib nibWithNibName:Identifier
                                           bundle:nil] forCellReuseIdentifier:Identifier];
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:_tableView];
}

#pragma mark - tableview
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return record.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YGGongDeCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        
        cell = [[YGGongDeCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
//    [cell setData:_dataArr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
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
    [[CommonFunctions sharedlnstance] qingfazhibingsuoyoujilv:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        [HUD hide:YES];
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            record = (NSArray *) [dic objectForKey:@"record"];
            if (record.count) {
                [_tableView reloadData];
            }
            
        }
        
    }];
    
}


@end
