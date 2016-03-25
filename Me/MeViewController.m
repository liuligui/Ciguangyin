//
//  MeViewController.m
//  Ciguangyin
//
//  Created by mac on 15/7/9.
//  Copyright (c) 2015年 ddsw. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableViewCell.h"
#import "MoreViewController.h"
#import "YGMyrecordCtr.h"
#import "YGMyOffencontactCtr.h"
#import "WSZLViewController.h"
#import "chatmsgViewController.h"
#import "YGMyReleaseInforCtr.h"
#import "YGBookshelfCtr.h"
#import "YGMycollectionCtr.h"
#import "YGMyGongDeCtr.h"
#import "YGMyContactCtr.h"
#import "YGJieYuanCtr.h"
#import "Globle.h"
#import "ClassificationController.h"
#import "UIImageView+MJWebCache.h"
#import "UIImageView+LBBlurredImage.h"
#import "UIView+Frame.h"
#import "WZLBadgeImport.h"
@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *metableview;
    UIImage *avatarImage;
   
    
}
@property(nonatomic,strong) UIImageView *avatarImageView;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    metableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, viewW, viewH-120-64-50)];
    metableview.dataSource = self;
    metableview.delegate = self;
    [self.view addSubview:metableview];
   
}

-(void)viewWillAppear:(BOOL)animated
{
     [self UIInit];
     [self mun];
}
-(void)InitNavigation{
    [super InitNavigation];
 
    [NavRightBtn  setFrame:CGRectMake(0, 0, 60, 25)];
    [NavRightBtn setTitle:@"信息" forState:UIControlStateNormal];
    [NavRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [NavRightBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        
        chatmsgViewController *vc = [[chatmsgViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}


-(void)mun
{
    [[CommonFunctions sharedlnstance] countNum:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        
        NSDictionary *dic= (NSDictionary *)requestData;
        
        if([dic[@"msg"] intValue] == 1)
        {
            int d = [dic[@"plwd"] intValue];
            NSString *count = [NSString stringWithFormat:@"%d",d];
            [Globle shareInstance].plwd = count;
            NavRightBtn.badgeBgColor = [UIColor redColor];
            NavRightBtn.badgeCenterOffset = CGPointMake(-NavRightBtn.width, 0);
            [NavRightBtn showBadgeWithStyle:WBadgeStyleNumber value:d animationType:WBadgeAnimTypeNone];

        }
        else
        {
            NavRightBtn.badgeBgColor = [UIColor redColor];
            NavRightBtn.badgeCenterOffset = CGPointMake(-NavRightBtn.width, 0);
            [NavRightBtn showBadgeWithStyle:WBadgeStyleNumber value:0 animationType:WBadgeAnimTypeNone];

        }
    }];
}



-(void)UIInit
{
    UIImage *imag = [self imageWithColor:RGBACOLOR(56, 67, 69, 1.0) andSize:CGSizeMake(self.view.frame.size.width, 80)];
    [self.navigationController.navigationBar setBackgroundImage:imag forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    
    UIImageView *topview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewW, 120)];

    
    NSString *Userlogo=@"";
    NSString * d= [Globle shareInstance].image_url;
    if (d!=nil) {
        Userlogo = [IMAGEURL stringByAppendingString:d];
    }
    if(Userlogo.length>1)
    {
        if([[Globle shareInstance].isLogThree  isEqualToString:@"y"])
        {
           
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSURL *portraitUrl = [NSURL URLWithString: d];
                UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
                [topview setImageToBlur:protraitImg
                             blurRadius:kLBBlurredImageDefaultBlurRadius
                        completionBlock:^(){
                            
                        }];
            
            });
          
            

        }
        else
        {
           
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSURL *portraitUrl = [NSURL URLWithString: Userlogo];
                UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
                [topview setImageToBlur:protraitImg
                             blurRadius:kLBBlurredImageDefaultBlurRadius
                        completionBlock:^(){
                            
                        }];
                
            });

            

       
        }
    }
    else
    {
        _avatarImageView.image =  [UIImage imageNamed:@"defaultcgy"];
    }

    
    
    [self.view addSubview:topview];
    
  
    
    avatarImage = [UIImage imageNamed:@"yyh"];
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.5-35,10 , 70, 70)];
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = _avatarImageView.frame.size.width/2;
    _avatarImageView.image =avatarImage;
    // [NLUtils getLogos];
   
    if(Userlogo.length>1)
    {
        if([[Globle shareInstance].isLogThree  isEqualToString:@"y"])
        {
             [_avatarImageView setImageURLStr:d placeholder:[UIImage imageNamed:@"defaultcgy"]];
        }
        else
        {
             [_avatarImageView setImageURLStr:Userlogo placeholder:[UIImage imageNamed:@"defaultcgy"]];
        }

        
    }
    else
    {
        _avatarImageView.image =  [UIImage imageNamed:@"defaultcgy"];
    }

    
    UILabel *lvtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, viewW, 20)];
    lvtitle.text = [Globle shareInstance].user_name;
    lvtitle.textAlignment = NSTextAlignmentCenter;
    lvtitle.textColor = [UIColor whiteColor];
    lvtitle.font = [UIFont systemFontOfSize: 16];
    [topview addSubview:_avatarImageView];
    [topview addSubview:lvtitle];
    
    
    UILabel *lvmessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, viewW*0.33, 20)];
    lvmessage.text =[NSString stringWithFormat:@"消息：%@",[Globle shareInstance].message];
    lvmessage.textAlignment = NSTextAlignmentRight;
    lvmessage.textColor = [UIColor whiteColor];
    lvmessage.font = [UIFont systemFontOfSize: 12];
    [topview addSubview:lvmessage];
    
    UILabel *lvguanzhu = [[UILabel alloc] initWithFrame:CGRectMake(viewW*0.33, 100, viewW*0.33, 20)];
    lvguanzhu.text =[NSString stringWithFormat: @"关注：%@",[Globle shareInstance].gzNum];

    lvguanzhu.textAlignment = NSTextAlignmentCenter;
    lvguanzhu.textColor = [UIColor whiteColor];
    lvguanzhu.font = [UIFont systemFontOfSize: 12];
    [topview addSubview:lvguanzhu];
    
    UILabel *lvfans = [[UILabel alloc] initWithFrame:CGRectMake(viewW*0.66, 100, viewW*0.33, 20)];
    lvfans.text = [NSString stringWithFormat:@"粉丝：%@",[Globle shareInstance].fansNum];
    lvfans.textAlignment = NSTextAlignmentLeft;
    lvfans.textColor = [UIColor whiteColor];
    lvfans.font = [UIFont systemFontOfSize: 12];
    [topview addSubview:lvfans];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 9;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellTableIdentifier = @"MeTableViewCell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"MeTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 CellTableIdentifier];
    
    if (indexPath.row == 0) {
        cell.imageLogo.image=[UIImage imageNamed:@"update_userinfo"];
        cell.name.text = @"完善资料";
    }
    if (indexPath.row == 1) {
        cell.imageLogo.image=[UIImage imageNamed:@"my_collection"];
        cell.name.text = @"我的收藏";
    }
    if (indexPath.row == 2) {
        cell.imageLogo.image=[UIImage imageNamed:@"my_book"];
        cell.name.text = @"我的书架";
    }
    if (indexPath.row == 3) {
        cell.imageLogo.image=[UIImage imageNamed:@"my_release_msg"];
        cell.name.text = @"我发布的信息";
    }
    if (indexPath.row == 4) {
        cell.imageLogo.image=[UIImage imageNamed:@"my_record"];
        cell.name.text = @"我的记录";
    }
    if (indexPath.row == 5) {
        cell.imageLogo.image=[UIImage imageNamed:@"my_linkman"];
        cell.name.text = @"我的常用联系人";
    }
//    if (indexPath.row == 6) {
//        cell.imageLogo.image=[UIImage imageNamed:@"my_merit"];
//        cell.name.text = @"我的功德箱";
//    }
    if (indexPath.row == 7-1) {
        cell.imageLogo.image=[UIImage imageNamed:@"my_communication_records"];
        cell.name.text = @"我的通信录";
    }
    if (indexPath.row == 8-1) {
        cell.imageLogo.image=[UIImage imageNamed:@"become_attached_to"];
        cell.name.text = @"结缘";
    }
    if (indexPath.row == 9-1) {
        cell.imageLogo.image=[UIImage imageNamed:@"more1"];
        cell.name.text = @"更多";
    }
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        WSZLViewController *vl = [[WSZLViewController alloc] init];
        vl.title = @"完善资料";
        [self.navigationController pushViewController:vl animated:YES];
        //      [self AgentInfo];
    }
    if (indexPath.row==1) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        YGMycollectionCtr *vl = [[YGMycollectionCtr alloc] init];
        vl.title = @"我的收藏";
        [self.navigationController pushViewController:vl animated:YES];

    }
    
    if (indexPath.row==2) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        YGBookshelfCtr *vl = [[YGBookshelfCtr alloc] init];
        vl.title = @"我的书架";
        [self.navigationController pushViewController:vl animated:YES];
        //      [self AgentInfo];
    }
    if (indexPath.row==3) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        YGMyReleaseInforCtr *vl = [[YGMyReleaseInforCtr alloc] init];
        vl.title = @"我发布的信息";
        [self.navigationController pushViewController:vl animated:YES];
        //[self AgentInfo];
    }
    if (indexPath.row==4) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        YGMyrecordCtr *vl = [[YGMyrecordCtr alloc] init];
        vl.title = @"我的记录";
        [self.navigationController pushViewController:vl animated:YES];
        //      [self AgentInfo];
    }
    if (indexPath.row==5) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        YGMyOffencontactCtr *vl = [[YGMyOffencontactCtr alloc] init];
        vl.title = @"我的常用联系人";
        [self.navigationController pushViewController:vl animated:YES];
        //      [self AgentInfo];
    }
//    if (indexPath.row==6) {
//        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
//        self.navigationItem.backBarButtonItem = backButton;
//        YGMyGongDeCtr *vl = [[YGMyGongDeCtr alloc] init];
//        vl.title = @"我的功德箱";
//        [self.navigationController pushViewController:vl animated:YES];
//        //      [self AgentInfo];
//    }
    if (indexPath.row==7-1) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        YGMyContactCtr *vl = [[YGMyContactCtr alloc] init];
        vl.title = @"我的通信录";
        [self.navigationController pushViewController:vl animated:YES];
        //      [self AgentInfo];
    }
    if (indexPath.row==8-1) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        YGJieYuanCtr *vl = [[YGJieYuanCtr alloc] init];
        vl.title = @"结缘";
        [self.navigationController pushViewController:vl animated:YES];
        //      [self AgentInfo];
    }
    if (indexPath.row==9-1) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        MoreViewController *vl = [[MoreViewController alloc] init];
        vl.title = @"更多";
        [self.navigationController pushViewController:vl animated:YES];
        //      [self AgentInfo];
    }
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
