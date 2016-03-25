




//
//  FengcaiShowViewController.m
//  HomeAdorn
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 IWork. All rights reserved.
//
#import "FengcaishowTableViewCell.h"
#import "FengcaiShowViewController.h"
#import "Globle.h"
@interface FengcaiShowViewController ()
{
    UITableView *huodongtable;
    NSArray *records;
    
}

@end

@implementation FengcaiShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    records =  [NSMutableArray array];
    // Do any additional setup after loading the view.
}

-(void)InitNavigation{
     self.title = @"风采展示";
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

#pragma mark - 初始化加载
-(void)InitControl{


     huodongtable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH-64)];
     huodongtable.delegate = self;
     huodongtable.dataSource = self;
     [huodongtable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
     [self.view addSubview:huodongtable];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( records.count > 0)
    {
        return records.count;
    }
    return 0;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = records[indexPath.row ];
    
    //    NSString *tt = dic[@"title"];
    float h = [self heightContentBackgroundView:dic[@"fczs_jq"]];
  

    return 70+ h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     
    
    static NSString *CellTableIdentifier = @"FengcaishowTableViewCell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"FengcaishowTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    
    FengcaishowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                   CellTableIdentifier];
   
    NSDictionary *dic = records[indexPath.row];
    if (indexPath.row >=1) {
        NSString *tt = dic[@"currdate"];
        cell.lbtime.text =[tt substringToIndex:10];
    }
    else
    {
         cell.lbtime.text =@"";
    }
   
    
    cell.lbtitle.text = dic[@"title"];
    cell.lbdetail.text = dic[@"fczs_jq"];
  
    
    return cell;
    
}

-(void)InitLoadData
{
    HUD.mode = MBProgressHUDModeIndeterminate;
    [HUD show:YES];
    
    [[CommonFunctions sharedlnstance] showuserid:[Globle shareInstance].user_id smid:_smid requestBlock:^(NSObject *requestData, BOOL IsError) {
        [HUD hide:YES];
        if (!IsError) {
            NSDictionary *dic = (NSDictionary *)requestData;
            records = (NSArray *) [dic objectForKey:@"record"];
            [huodongtable reloadData];
        }
        else
        {
            HUD.mode = MBProgressHUDModeText;
            [HUD setLabelText:requestData];
            [HUD hide:YES afterDelay:1];
  
        }
        
    }];
    
    
}


- (CGFloat)heightContentBackgroundView:(NSString *)content
{
    CGFloat height = [self heigtOfLabelForFromString:content fontSizeandLabelWidth:viewW andFontSize:12.0];
    ;
    
    return height;
}

- (CGFloat)heigtOfLabelForFromString:(NSString *)text fontSizeandLabelWidth:(CGFloat)width andFontSize:(CGFloat)fontSize
{
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, 2000)];
    return size.height;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
}

@end

