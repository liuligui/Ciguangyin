//
//  DaoChangDetailController.m
//  Ciguangyin
//
//  Created by mac on 15/7/13.
//  Copyright (c) 2015年 ddsw. All rights reserved.
//
#import "UIImageView+MJWebCache.h"
#import "DaoChangDetailController.h"
#import "DaochangTableViewCell.h"
#import "PublishViewController.h"
#import "FengcaiShowViewController.h"
#import "ScrollDetailViewController.h"
#import "DetailsViewController.h"
#import "PaiWeiViewController.h"
#import "introduceNViewController.h"
#import "BaomingnustknowController.h"
#import "QingfaViewController.h"
#import "Globle.h"
#import "qfzbViewController.h"
#import "DownloadBookViewController.h"
#import "BaikeArticleDetailViewController.h"
@interface DaoChangDetailController ()
{
    UIPageControl *pageControl;
    UIScrollView *rotationScroll;
    NSMutableDictionary *DataDic;
    UIView *menuView,*belowView;
    UITextField *searchTextField;
    UITableView *searchTableView;
    WaterfallsFlow *HomeTableView;
    UIView *textBg;
    UIButton *searchBtn;
    int NewpageIndex,HotpageIndex,RecommendpageIndex;
    MJRefreshBaseView *header;
    MJRefreshFooterView *footer;
    NSString *pageType;
    UIView *bottomView;
    NSMutableArray *ScrollImageArray;
    UILabel *redPoint;
    UIView *BtnViews;
    UIView *viewm;
    BOOL isShow;
    
    UITableView *huodongtable;
    
    UIColor* _activeColor;
    
    UIColor* _inactiveColor;
    NSArray *down;
    NSArray *end;
    NSArray *top;
    NSDictionary *middle;
    
    UILabel *label1;
    UILabel *label2;
    UIImageView *qzimage;
    UIButton *introduce;
    NSDictionary *middledic;
    NSDictionary *fundic;

}

@end

@implementation DaoChangDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    _activeColor = [UIColor yellowColor];
   
    _inactiveColor = [UIColor grayColor];
    [self UI];
    [self getSmUseMenu];
    
}

-(void) updateDots

{
    
    for (int i = 0; i < [pageControl.subviews count]; i++)
        
    {
        
        UIImageView* dot = [pageControl.subviews objectAtIndex:i];
        
        if (i == pageControl.currentPage) {
            
            dot.backgroundColor = _activeColor;
            
        } else {
            
            dot.backgroundColor = _inactiveColor;
            
        }
        
    }
    
}


-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavRightBtn  setFrame:CGRectMake(0, 0, 60, 25)];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
    NSArray *arrayInfo = (NSArray *)_dicInfo;
    NSDictionary *dic = arrayInfo[_index];
    
    [NavRightBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        
        NSString *username = [Globle shareInstance].user_id;;
        if ([NavRightBtn.titleLabel.text isEqualToString:@"已关注"]) {
           
            [[CommonFunctions sharedlnstance] bgzsmuserid:username smid:dic[@"id"] requestBlock:^(NSObject *requestData, BOOL IsError) {
                NSDictionary *rd= (NSDictionary *)requestData;
                if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
                {
                    HUD.mode = MBProgressHUDModeText;
                    [HUD setLabelText:@"已取消关注！"];
                    [NavRightBtn setTitle:@"关注" forState:UIControlStateNormal];
                    [HUD show:YES];
                    [HUD hide:YES afterDelay:1];
                    
                    
                }
                else
                {
                    HUD.mode = MBProgressHUDModeText;
                    [HUD setLabelText:@"取消关注失败！"];
                    [HUD show:YES];
                    [HUD hide:YES afterDelay:1];
                }
                
                
            }];
        }
        else
        {
            [[CommonFunctions sharedlnstance] gzsmuserid:username smid:dic[@"id"] requestBlock:^(NSObject *requestData, BOOL IsError) {
                NSDictionary *rd= (NSDictionary *)requestData;
                if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
                {
                    HUD.mode = MBProgressHUDModeText;
                    [HUD setLabelText:@"关注成功！"];
                    [NavRightBtn setTitle:@"已关注" forState:UIControlStateNormal];
                    [HUD show:YES];
                    [HUD hide:YES afterDelay:1];
                    
                    
                }
                else
                {
                    HUD.mode = MBProgressHUDModeText;
                    [HUD setLabelText:@"关注失败！"];
                    [HUD show:YES];
                    [HUD hide:YES afterDelay:1];
                }
                
            }];
        }
    }];
    
    
    
    if (_gz==0) {
        [NavRightBtn setTitle:@"+关注" forState:UIControlStateNormal];
        [NavRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    else
    {
        [NavRightBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [NavRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    
}
-(void)UI
{
 
    UIImage *imag = [self imageWithColor:RGBACOLOR(56, 67, 69, 1.0) andSize:CGSizeMake(self.view.frame.size.width, 80)];
    [self.navigationController.navigationBar setBackgroundImage:imag forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    
    NewpageIndex = 1;
    HotpageIndex = 1;
    RecommendpageIndex = 1;
    pageType = @"new";
}

-(void)InitLoadData{
    NSArray *arrayInfo = (NSArray *)_dicInfo;
    NSDictionary *dic = arrayInfo[_index];
    [[CommonFunctions sharedlnstance] getSmInfo:dic[@"id"] user_id:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        [HUD hide:YES];
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            down = (NSArray *) [dic objectForKey:@"down"][@"record"];
            middle = (NSDictionary *) [dic objectForKey:@"middle"];
            top = (NSArray *) [dic objectForKey:@"top"][@"record"];
            end = (NSArray *) [dic objectForKey:@"end"][@"record"];
            [Globle shareInstance].end =end;
            if (top.count>0) {
                [self InitAdvert];
            }
            
           
            if(middle !=nil)
            {
                label1.text = middle[@"sm_name"];
                label2.text = middle[@"sm_certificate"];
                NSString *imageurl =[IMAGEURL stringByAppendingString:[middle objectForKey:@"image_url"]];
                [qzimage setImageURLStr: imageurl placeholder:[UIImage imageNamed:@"defaultcgy"]];
                
            }
            
            if (down.count>0) {
                [huodongtable reloadData];
            }
            
           
        }

    }];
}



-(void)InitAdvert{
    
    NSArray *array =top;
     if (array!=nil) {
         NSDictionary *dic0 = top[0];
         ScrollImageArray = [NSMutableArray array];
         int x = 0;
         UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,viewW,  150 )];
         NSString *imageurl =[IMAGEURL stringByAppendingString:[dic0 objectForKey:@"image_url"]];
         [imageView setImageURLStr:imageurl placeholder:[UIImage imageNamed:@""]];
         [imageView setClipsToBounds:YES];
         imageView.contentMode = UIViewContentModeScaleAspectFill;
         imageView.userInteractionEnabled = YES;
         [imageView didImageViewClick:^(UIImage *Image) {
             DetailsViewController *details = [[DetailsViewController alloc] init];
             details.dicInfo = dic0;
             [self.navigationController pushViewController:details animated:YES];
         }];
         
         UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 120, viewW, 30)];
         vi.backgroundColor = rgb_color(130, 135,135, .4);
         [imageView addSubview:vi];
         UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, viewW, 30)];
         lb.text = [top[0] objectForKey:@"title"];
         lb.textAlignment = NSTextAlignmentCenter;
         [lb setTextColor:[UIColor whiteColor]];
         [lb setFont:[UIFont systemFontOfSize:12]];
         [imageView addSubview:lb];
         [rotationScroll addSubview:imageView];
         [ScrollImageArray addObject:[top[0] objectForKey:@"image_url"]];
         x +=viewW;
         

         
         x = winsize.width;
        
         for (int i = 0; i < top.count; i++) {
             NSDictionary *dic = top[i];
             UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0,viewW,  150 )];
              NSString *imageurl =[IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]];
             [imageView setImageURLStr:imageurl placeholder:[UIImage imageNamed:@""]];
             [imageView setClipsToBounds:YES];
             imageView.contentMode = UIViewContentModeScaleAspectFill;
             imageView.userInteractionEnabled = YES;
             [imageView didImageViewClick:^(UIImage *Image) {
                 DetailsViewController *details = [[DetailsViewController alloc] init];
                 details.dicInfo = dic;
                 [self.navigationController pushViewController:details animated:YES];
             }];
             
             UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 120, viewW, 30)];
             vi.backgroundColor = rgb_color(130, 135,135, .4);
             [imageView addSubview:vi];
             UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, viewW, 30)];
             lb.text = [top[i] objectForKey:@"title"];
             lb.textAlignment = NSTextAlignmentCenter;
             [lb setTextColor:[UIColor whiteColor]];
             [lb setFont:[UIFont systemFontOfSize:12]];
             [imageView addSubview:lb];
             [rotationScroll addSubview:imageView];
             [ScrollImageArray addObject:[top[i] objectForKey:@"image_url"]];
             x +=viewW;
         }
         
       
         imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, viewW, 150)];
         [imageView setImageURLStr:imageurl placeholder:[UIImage imageNamed:@""]];
         [imageView setClipsToBounds:YES];
         imageView.contentMode = UIViewContentModeScaleAspectFill;
         imageView.userInteractionEnabled = YES;
         [imageView didImageViewClick:^(UIImage *Image) {
             DetailsViewController *details = [[DetailsViewController alloc] init];
             details.dicInfo = dic0;
             [self.navigationController pushViewController:details animated:YES];
         }];

         [rotationScroll addSubview:imageView];
         
         UIView *vi1 = [[UIView alloc] initWithFrame:CGRectMake(0, 120, viewW, 30)];
         vi1.backgroundColor = rgb_color(130, 135,135, .4);
         [imageView addSubview:vi];
         UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, viewW, 30)];
         lb1.text = [top[0] objectForKey:@"title"];
         lb1.textAlignment = NSTextAlignmentCenter;
         [lb1 setTextColor:[UIColor whiteColor]];
         [lb1 setFont:[UIFont systemFontOfSize:12]];
         [imageView addSubview:lb1];
    
         pageControl.numberOfPages = array.count;
         rotationScroll.contentSize = CGSizeMake((array.count + 2) * winsize.width,  winsize.width / 2);
         rotationScroll.contentOffset = CGPointMake(0, 0);
         [rotationScroll scrollRectToVisible:CGRectMake(winsize.width, 0, winsize.width,  winsize.width / 2) animated:NO];
         
         [self performSelector:@selector(updateScrollView) withObject:nil afterDelay:0];
        

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

-(void)updateScrollView{
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(handleMax) userInfo:nil repeats:YES];
}

-(void)handleMax{
    CGPoint pt = rotationScroll.contentOffset;
    int count = (int)ScrollImageArray.count;
    if (pt.x == winsize.width * count) {
        [rotationScroll setContentOffset:CGPointMake(0, 0)];
        [rotationScroll scrollRectToVisible:CGRectMake(winsize.width, 0, winsize.width,  winsize.width / 2) animated:YES];
    }else{
        [rotationScroll scrollRectToVisible:CGRectMake(pt.x+winsize.width, 0, winsize.width,  winsize.width / 2) animated:YES];
    }
    pageControl.currentPage = rotationScroll.contentOffset.x / winsize.width;
        [self updateDots];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControl.currentPage = rotationScroll.contentOffset.x / winsize.width;
        [self updateDots];
    int currentPage = floor((rotationScroll.contentOffset.x - rotationScroll.frame.size.width / ([ScrollImageArray count]+2)) / rotationScroll.frame.size.width) + 1;
    if (currentPage==0) {
        [rotationScroll scrollRectToVisible:CGRectMake(winsize.width * [ScrollImageArray count],0,winsize.width, winsize.width / 2) animated:NO];
    } else if (currentPage==([ScrollImageArray count]+1)) { //如果是最后+1,也就是要开始循环的第一个
        [rotationScroll scrollRectToVisible:CGRectMake(winsize.width,0,winsize.width,100) animated:NO];
    }
}

#pragma mark - 初始化加载
-(void)InitControl{
    rotationScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, winsize.width,  winsize.width / 2)];
    rotationScroll.showsHorizontalScrollIndicator = NO;
    rotationScroll.showsVerticalScrollIndicator = NO;
    rotationScroll.delegate = self;
    rotationScroll.pagingEnabled = YES;
    [self.view addSubview:rotationScroll];
    
    //[self InitAdvert];
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(viewW-100,  100, 100, 20)];
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.currentPage = 0;
//    UIImageView* dot = [pageControl.subviews objectAtIndex:0];
//    dot.backgroundColor = _activeColor;
    [pageControl addTarget:self action:@selector(pageControlchange:) forControlEvents:UIControlEventValueChanged];
    pageControl.alpha = .6;
    [self.view addSubview:pageControl];
    
    viewm = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewW, 150)];
    viewm.backgroundColor = [UIColor groupTableViewBackgroundColor];
     [self.view addSubview:viewm];
    
    
    
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, self.view.frame.size.width, 20)];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = [UIFont systemFontOfSize:14];
    label3.text =@"风采展示";
    
    [viewm addSubview:label3];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, self.view.frame.size.width, 20)];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = [UIFont systemFontOfSize:14];
    label1.text =@"";
    [viewm addSubview:label1];

    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, self.view.frame.size.width, 20)];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont systemFontOfSize:12];
    label2.text =@"";
    [viewm addSubview:label2];

     qzimage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 40, 40)];
     qzimage.layer.masksToBounds = YES;
     qzimage.layer.cornerRadius = 20;
    [viewm addSubview:qzimage];
    
    UIImageView *v1 = [[UIImageView alloc] initWithFrame:CGRectMake(viewW-25, 5,20,20)];
    [v1 setImage:[UIImage imageNamed:@"more"]];
    [viewm addSubview:v1];
    
    UIButton *t = [[UIButton alloc] initWithFrame:CGRectMake(viewW-90, 5,80,20)];
    [t addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    [t setFont:[UIFont systemFontOfSize:13]];
    [t setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [t setTitle:@"查看更多" forState:UIControlStateNormal];
    [viewm addSubview:t];
    
   
    UIView *vl1 = [[UIView alloc] initWithFrame:CGRectMake(0, 27, viewW, 0.4)];
    vl1.backgroundColor = [UIColor lightGrayColor];
    [viewm addSubview:vl1];
    
    
    UIView *vl2 = [[UIView alloc] initWithFrame:CGRectMake(0, 75, viewW, 0.4)];
    vl2.backgroundColor = [UIColor lightGrayColor];
    [viewm addSubview:vl2];
    
    introduce = [[UIButton alloc] initWithFrame:CGRectMake(0, 25, viewW, 40)];
    [introduce setBackgroundColor:[UIColor clearColor]];
    [introduce addTarget:self action:@selector(introduceView) forControlEvents:UIControlEventTouchUpInside];
    [viewm addSubview:introduce];
    
    huodongtable = [[UITableView alloc] initWithFrame:CGRectMake(0,150, viewW, viewH-140)];
    huodongtable.delegate = self;
    huodongtable.dataSource = self;
    huodongtable.tableHeaderView = viewm;
    
    [self setExtraCellLineHidden:huodongtable];
    [self.view addSubview:huodongtable];
}
- (void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
   
    
}
-(void)introduceView
{
    
   
    introduceNViewController *vc = [[introduceNViewController alloc] init];
     NSString *imageurl =[middle objectForKey:@"image_url"];
    vc.userid = [middle objectForKey:@"id"];
    vc.logo = imageurl ;
    [self.navigationController pushViewController:vc animated:YES];
}
//道场预约",@"登记牌位",@"请法治病",@"资料下载
-(void)btnp:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"道场预约"]) {
        BaomingnustknowController *viewController = [[BaomingnustknowController alloc] init];
        viewController.title = @"道场预约";
        NSArray *arrayInfo = (NSArray *)_dicInfo;
        NSDictionary *dic = arrayInfo[_index];
        viewController.smid = dic[@"id"];
        [self.navigationController pushViewController:viewController animated:YES];

    }
    if ([btn.titleLabel.text isEqualToString:@"健康关怀"]) {
        qfzbViewController *viewController = [[qfzbViewController alloc] init];
        viewController.vctitle = @"健康关怀";
        viewController.end = end;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    if ([btn.titleLabel.text isEqualToString:@"登记牌位"]) {
        PaiWeiViewController *viewController = [[PaiWeiViewController alloc] init];
        viewController.title = @"登记牌位";
        viewController.dicInfo = _dicInfo;
        viewController.index = _index;
        
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    if ([btn.titleLabel.text isEqualToString:@"资料下载"]) {
        DownloadBookViewController *viewController = [[DownloadBookViewController alloc] init];
        viewController.title = @"资料下载";
        NSArray *arrayInfo = (NSArray *)_dicInfo;
        NSDictionary *dic = arrayInfo[_index];
        viewController.smid = dic[@"id"];

        [self.navigationController pushViewController:viewController animated:YES];
        
    }
}
-(void)more
{
    FengcaiShowViewController *more = [[FengcaiShowViewController alloc] init];
    NSArray *arrayInfo = (NSArray *)_dicInfo;
    NSDictionary *dic = arrayInfo[_index];
    more.smid =dic[@"id"];
    [self.navigationController pushViewController:more animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return down.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *CellTableIdentifier = @"DaochangTableViewCell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"DaochangTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    DaochangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                   CellTableIdentifier];
    NSDictionary *dic = down[indexPath.row];
    
    cell.title.text = [dic objectForKey:@"title"];
    cell.detail.text = [dic objectForKey:@"hd_jq"];
    
    NSString *imageurl =[IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]];
    cell.images.contentMode = UIViewContentModeScaleAspectFill;
    [cell.images setImageURLStr: [IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]] placeholder:[UIImage imageNamed:@"defaultcgy"]];
    cell.images.layer.cornerRadius = 10;
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    //
    DetailsViewController *details = [[DetailsViewController alloc] init];
    details.dicInfo = down[indexPath.row];
    
    [self.navigationController pushViewController:details animated:YES];

    
}

-(void)getSmUseMenu
{
    HUD.mode = MBProgressHUDModeIndeterminate;  //_userid
    [HUD show:YES];
    NSArray *arrayInfo = (NSArray *)_dicInfo;
    NSDictionary *dic = arrayInfo[_index];

    [[CommonFunctions sharedlnstance] getSmUseMenu: dic[@"id"] requestBlock:^(NSObject *requestData, BOOL IsError) {
         NSDictionary *dic = (NSDictionary *)requestData;
        fundic = dic;
        NSArray  *record = (NSArray *) [dic objectForKey:@"record"];
        int w=(viewW-200)/5;
        int x = 0;
        NSArray *title =@[@"道场预约",@"登记牌位",@"健康关怀",@"资料下载"];
        NSArray *btnImage =@[@"sever_registration",@"sever_appoitment",@"sever_cure",@"sever_down"];
        for (int i=0; i<record.count; i++) {
            x = w *(i+1) + 50*i;
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, 80, 50, 50)];
            NSDictionary *dic = record[i];
            int idd = [dic[@"id"] intValue];
            
            [btn setImage:[UIImage imageNamed:btnImage[idd-1]] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(btnp:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.titleLabel.text = title[idd-1];
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(x, 133, 50, 15)];
            lb.font = [UIFont systemFontOfSize:12];
            lb.text =dic[@"serv_name"];
            lb.textAlignment = NSTextAlignmentCenter;
            [viewm addSubview:lb];
            [viewm addSubview:btn];
        }
        
        if (record.count == 0) {
         
            [viewm setFrame:CGRectMake(0, 0, viewW, 80)];
             huodongtable.tableHeaderView = viewm;
        }

        
        
        
    }];
    
}




@end


