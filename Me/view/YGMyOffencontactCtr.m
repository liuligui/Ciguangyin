//
//  MyofenContactViewController.m
//  Ciguangyin
//
//  Created by mac on 15/7/10.
//  Copyright (c) 2015年 ddsw. All rights reserved.
//

#import "YGMyOffencontactCtr.h"
#import "YGMyOffencontactCell.h"
#import "YGAddContaccCtr.h"
#import "Globle.h"
#define Identifier @"YGMyOffencontactCell"

@interface YGMyOffencontactCtr ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *contacts;
    NSString *cid;
}

@property (nonatomic, strong)UIActionSheet *sheet;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *dataArr;

@end

@implementation YGMyOffencontactCtr

- (void)viewDidLoad {
    contacts = [NSMutableArray array];
    [super viewDidLoad];
    [self TableViewInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self InitData];
}


#pragma mark - tableview
-(void)TableViewInit{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.backgroundColor = [UIColor greenColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:Identifier
                                           bundle:nil] forCellReuseIdentifier:Identifier];
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:_tableView];
    
}
-(void)InitData
{
    [[CommonFunctions sharedlnstance] getContact:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {

        NSDictionary *dic= (NSDictionary *)requestData;
        int count = [[dic objectForKey:@"count"] intValue];
        if(count > 0)
        {
             contacts = dic[@"record"];
            [_tableView reloadData];
        }
        else
        {
            contacts = nil;
            [Globle shareInstance].contactsArray =nil;
            [_tableView reloadData];

        }
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return contacts.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSDictionary *dic = contacts[indexPath.row];
    YGMyOffencontactCell *cell = [_tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        
        cell = [[YGMyOffencontactCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
    cell.username.text = dic[@"lx_name"];
    cell.phone.text = dic[@"phone"];
   
    cell.address.text = dic[@"now_address"];
    cell.iid.text=dic[@"id"];
    if([dic[@"lx_sex"] isEqualToString:@"1"])
    {
         cell.sex.text = @"男";
    }
    else
    {
         cell.sex.text = @"女";
    }
    cell.deletetbn.layer.cornerRadius = 10.0;
    [cell.deletetbn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)delete:(UIButton *)btn
{
  UIView *view  = btn.superview;
    UILabel *lbid = view.subviews[9];
  cid = lbid.text;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"添加要删除此联系人吗？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert showWithCompletionHandler:^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [[CommonFunctions sharedlnstance] deleteContact:cid requestBlock:^(NSObject *requestData, BOOL IsError) {
                
                
                NSDictionary *rd= (NSDictionary *)requestData;
                if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
                {
                    HUD.mode = MBProgressHUDModeText;
                    [HUD setLabelText:@"删除成功！"];
                    
                    [HUD show:YES];
                    [HUD hide:YES afterDelay:1];
                    [self InitData];
                    
                }
                else
                {
                    HUD.mode = MBProgressHUDModeText;
                    [HUD setLabelText:@"删除失败！"];
                    [HUD show:YES];
                    [HUD hide:YES afterDelay:1];
                }
            }];
            
        }else{
            
            
        }
    }];

}




-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
        [NavRightBtn  setFrame:CGRectMake(0, 0, 40, 30)];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
        [NavRightBtn setTitle:@"添加" forState:UIControlStateNormal];
        [NavRightBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        [NavRightBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addBtnClick{
    NSLog(@"addBtnClick");
    [self.navigationController pushViewController:[[YGAddContaccCtr alloc]init] animated:YES];
}

@end
