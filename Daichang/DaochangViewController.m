//
//  DaochangViewController.m
//  Ciguangyin
//
//  Created by mac on 15/7/9.
//  Copyright (c) 2015年 ddsw. All rights reserved.
//

#import "DaochangViewController.h"
#import "DaoChangDetailController.h"
#import "DaochanghomeCell.h"
#import "Globle.h"
#import "UIImageView+MJWebCache.h"
@interface DaochangViewController ()
{
    UITableView *settingTableView;
    NSArray  *nsTemlist;
    NSArray  *gzTemlist;
    NSArray  *otherTemlist;
}


@end

@implementation DaochangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [self InitLoadData];
}
-(void)initview
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    nsTemlist = [NSMutableArray array];
    gzTemlist = [NSMutableArray array];
    otherTemlist = [NSMutableArray array];
    UIImage *imag = [self imageWithColor:RGBACOLOR(56, 67, 69, 1.0) andSize:CGSizeMake(self.view.frame.size.width, 80)];
    [self.navigationController.navigationBar setBackgroundImage:imag forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    
    settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-108-20) style:UITableViewStyleGrouped];
    settingTableView.delegate = self;
    settingTableView.dataSource =self;
    settingTableView.scrollEnabled = YES;
    [self.view addSubview:settingTableView];

    
}

-(void)InitLoadData
{
    HUD.mode = MBProgressHUDModeIndeterminate;
    [HUD show:YES];
    NSString *phone =[Globle shareInstance].user_id;
    [[CommonFunctions sharedlnstance] getSmList:phone requestBlock:^(NSObject *requestData, BOOL IsError) {
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            nsTemlist = (NSArray *) [dic objectForKey:@"allSm"][@"record"];
            gzTemlist = (NSArray *) [dic objectForKey:@"gzSm"][@"record"];
            otherTemlist = (NSArray *) [dic objectForKey:@"allOther"][@"record"];
           [settingTableView reloadData];
        }
        
    }];
    
   
}
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section

{
    
    return 25.0 ;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return gzTemlist.count;
    }
    if (section == 1) {
        return nsTemlist.count;
    }
    if (section == 2) {
        return otherTemlist.count;
    }
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellTableIdentifier = @"DaochanghomeCell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"DaochanghomeCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    
    DaochanghomeCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                   CellTableIdentifier];
    cell.images.layer.masksToBounds = YES;
    cell.images.layer.cornerRadius = cell.images.frame.size.width/2;

    if (indexPath.section == 0){
        NSDictionary *dic = gzTemlist[indexPath.row];
        
        cell.title.text = [dic objectForKey:@"sm_name"];
        cell.detail.text = [dic objectForKey:@"sm_jq"];
        NSString *d =  [IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]];
        NSString *imageurl =[IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]];
        [cell.images setImageURLStr: [IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]] placeholder:[UIImage imageNamed:@"defaultcgy"]];
    }
    if (indexPath.section == 1){
        NSDictionary *dic = nsTemlist[indexPath.row];
         NSString *imageurl =[IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]];
        cell.title.text = [dic objectForKey:@"sm_name"];
        cell.detail.text = [dic objectForKey:@"sm_jq"];
        [cell.images setImageURLStr: [IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]] placeholder:[UIImage imageNamed:@"defaultcgy"]];

    }
    if (indexPath.section == 2){
        NSDictionary *dic = otherTemlist[indexPath.row];
        
        cell.title.text = [dic objectForKey:@"sm_name"];
        cell.detail.text = [dic objectForKey:@"sm_jq"];
        
        [cell.images setImageURLStr: [IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]] placeholder:[UIImage imageNamed:@"defaultcgy"]];

    }
    

    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DaochanghomeCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSString* textLabel = cell.title.text;
    
    NSString* detailTextLabel = cell.detailTextLabel.text;

    [self doCellForSection0:indexPath];
    [settingTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DaoChangDetailController *DaoChangDetail = [DaoChangDetailController alloc];
    if (indexPath.section ==0) {
        DaoChangDetail.dicInfo = gzTemlist;
        DaoChangDetail.gz = 1;
    }
    if (indexPath.section ==1) {
        DaoChangDetail.dicInfo = nsTemlist;
         DaoChangDetail.gz = 0;
    }
    if (indexPath.section ==2) {
         DaoChangDetail.gz = 0;
        DaoChangDetail.dicInfo = otherTemlist;
    }
    DaoChangDetail.index = indexPath.row;
    DaoChangDetail.title = @"活动详情";
    [self.navigationController pushViewController:DaoChangDetail animated:YES];
    

}


/**
 *  第section组显示的头部标题
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"已关注";
    }
    if (section == 1) {
        return @"寺庙";
    }
    if (section == 2) {
        return @"其他";
    }

   return nil;
}

#pragma mark - do clicled cell event
- (void)doCellForSection0:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
            
        case 0:
        {
           
            
        }
            break;
        case 1:
        {
        }
            
            break;
            
        case 2:
        {
        }
            break;
        default:
            break;
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
@end
