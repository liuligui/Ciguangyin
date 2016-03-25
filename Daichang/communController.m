//
//  communController.m
//  HomeAdorn
//
//  Created by mac on 15/7/19.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "communController.h"
#import "SendComViewController.h"
#import "HdcViewController.h"
#import "Globle.h"
#import "UIImageView+MJWebCache.h"
#import "HdplTableViewCell.h"
@interface communController ()
{
    
    UITableView *cgyTableView;
    NSArray  *Actionlist;
    UILabel *lb;
}

@end

@implementation communController

-(void)InitNavigation{
    self.title = @"评论内容";
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavRightBtn  setFrame:CGRectMake(0, 0, 80, 25)];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    [NavRightBtn setTitle:@"发表评论" forState:UIControlStateNormal];
    [NavRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [NavRightBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
   
        HdcViewController *viewController = [[HdcViewController alloc] init];
        viewController.dicInfo = _dicInfo;
        viewController.title = @"评论内容";
        [self.navigationController pushViewController:viewController animated:YES];
    }];
    
}


-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}

-(void)InitLoadData{
    
    [[CommonFunctions sharedlnstance] getActionCoList:_dicInfo[@"id"] requestBlock:^(NSObject *requestData, BOOL IsError) {
        [HUD hide:YES];
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            Actionlist = (NSArray *) [dic objectForKey:@"record"];
            [cgyTableView reloadData];
        }
        
        if (Actionlist.count > 0) {
            [lb setHidden:YES];
        }
        else
        {
             [lb setHidden:NO];
        }
    }];
}

- (void)viewDidLoad {
    Actionlist = [NSMutableArray array];
    [super viewDidLoad];
    [self initview];
    
    
    lb= [[UILabel alloc] initWithFrame:CGRectMake(0, viewH*0.5, viewW, 15)];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.text = @"暂无内容！";
    lb.font = [UIFont systemFontOfSize:13];
    [lb setHidden:YES];
    [self.view addSubview:lb];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self InitLoadData];
}
-(void)initview
{

    UIImage *imag = [self imageWithColor:RGBACOLOR(56, 67, 69, 1.0) andSize:CGSizeMake(self.view.frame.size.width, 80)];
    [self.navigationController.navigationBar setBackgroundImage:imag forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    
    cgyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) ];
    cgyTableView.delegate = self;
    cgyTableView.dataSource =self;
//    cgyTableView.scrollEnabled = YES;
    [self setExtraCellLineHidden:cgyTableView];
    [self.view addSubview:cgyTableView];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return Actionlist.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellTableIdentifier = @"HdplTableViewCell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"HdplTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    NSDictionary *dic = Actionlist[indexPath.row];
    HdplTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                              CellTableIdentifier];
    cell.username.text = dic[@"user_name"];
    cell.detail.text = dic[@"context"];
    NSString *t = dic[@"pl_time"];
    cell.datetime.text = [t  substringToIndex:t.length-2];
    NSString *d = dic[@"image_url"];
    NSString *Userlogo = [IMAGEURL stringByAppendingString:d];
   // [cell.logoimage setImageWithURL: [IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]] placeholderImage:[UIImage imageNamed:@"defaultcgy"]];
    [cell.logoimage setImageURLStr: [IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]] placeholder:[UIImage imageNamed:@"defaultcgy"]];


    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [cgyTableView deselectRowAtIndexPath:indexPath animated:YES];
    
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

