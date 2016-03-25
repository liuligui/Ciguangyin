//
//  HuodongViewController.m
//  Ciguangyin
//
//  Created by mac on 15/7/9.
//  Copyright (c) 2015年 ddsw. All rights reserved.
//
#import "DaochangTableViewCell.h"
#import "HuodongViewController.h"
#import "HuodongTableViewCell.h"
#import "DetailsViewController.h"
#import "UIImageView+MJWebCache.h"
@interface HuodongViewController ()
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
    BOOL isShow;
    
    UITableView *huodongtable;
    
    NSArray *down;
    NSArray *top;


    
    UIColor* _activeColor;
    
    UIColor* _inactiveColor;
}

@end

@implementation HuodongViewController



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




- (void)viewDidLoad {
    [super viewDidLoad];
    down = [NSMutableArray array];
    top = [NSMutableArray array];
    
    _activeColor = [UIColor yellowColor];
    
    _inactiveColor = [UIColor grayColor];
    
    UIImage *imag = [self imageWithColor:RGBACOLOR(56, 67, 69, 1.0) andSize:CGSizeMake(self.view.frame.size.width, 80)];
    [self.navigationController.navigationBar setBackgroundImage:imag forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
    NewpageIndex = 1;
    HotpageIndex = 1;
    RecommendpageIndex = 1;
    pageType = @"new";
}
//
//-(void)InitAdvert{
//
//                NSArray *array =top;
//                ScrollImageArray = [NSMutableArray array];
//                float x=0;
//                x = winsize.width;
//                
//                for (int i = 0; i < top.count; i++) {
//                    NSDictionary *dic = top[i];
//                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, winsize.width,  winsize.width-100 )];
//                    [imageView setImageURLStr: [IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]] placeholder:[UIImage imageNamed:@"defaultcgy"]];
//                    imageView.userInteractionEnabled = YES;
//                    [imageView didImageViewClick:^(UIImage *Image) {
//                        //
//                        DetailsViewController *details = [[DetailsViewController alloc] init];
//                        details.dicInfo = dic;
//                        [self.navigationController pushViewController:details animated:YES];
//                        
//                    }];
//                    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 120, viewW, 30)];
//                    vi.backgroundColor = rgb_color(130, 135,135, .7);
//                    [imageView addSubview:vi];
//                    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, viewW, 30)];
//                    lb.text = [top[i] objectForKey:@"title"];
//                    lb.textAlignment = NSTextAlignmentCenter;
//                    [lb setTextColor:[UIColor whiteColor]];
//                    [lb setFont:[UIFont systemFontOfSize:12]];
//                    [imageView addSubview:lb];
//                    [rotationScroll addSubview:imageView];
//                    [ScrollImageArray addObject:[top[i] objectForKey:@"image_url"]];
//                    
//                    x += winsize.width;
//                }
//                
//                pageControl.numberOfPages = array.count;
//    pageControl.currentPageIndicatorTintColor = RGBACOLOR(204, 83, 16, 1.0);
//    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
//                rotationScroll.contentSize = CGSizeMake((array.count+1) * winsize.width,  winsize.width / 2);
//                rotationScroll.contentOffset = CGPointMake(0, 0);
//                [rotationScroll scrollRectToVisible:CGRectMake(winsize.width, 0, winsize.width,  winsize.width / 2) animated:NO];
//                
//                [self performSelector:@selector(updateScrollView) withObject:nil afterDelay:0];
//    
//}
//

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
    
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(winsize.width-100, 100, 100, 20)];
    pageControl.currentPage = 0;
  
        
        
    [pageControl addTarget:self action:@selector(pageControlchange:) forControlEvents:UIControlEventValueChanged];
    pageControl.alpha = .6;

    [self.view addSubview:pageControl];
    
    
    huodongtable = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, viewW, viewH- 150-108)];
    huodongtable.delegate = self;
    huodongtable.dataSource = self;
    [self setExtraCellLineHidden:huodongtable];
    [self.view addSubview:huodongtable];
}
-(void)InitLoadData
{
    HUD.mode = MBProgressHUDModeIndeterminate;
    [HUD show:YES];
    
    [[CommonFunctions sharedlnstance] gethdgc:^(NSObject *requestData, BOOL IsError) {
    
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            down = (NSArray *) [dic objectForKey:@"down"][@"record"];
            top = (NSArray *) [dic objectForKey:@"top"][@"record"];
            
            if (top.count>0) {
                  [self InitAdvert];
            }

            [huodongtable reloadData];
        }
        
    }];
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


    [cell.images setImageURLStr: [IMAGEURL stringByAppendingString:[dic objectForKey:@"image_url"]] placeholder:[UIImage imageNamed:@"defaultcgy"]];
    
    cell.images.layer.cornerRadius = 5;
    return cell;
    
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
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
@end
