

//
//  MyPublishmessageViewController.m
//  HomeAdorn
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "MyPublishmessageViewController.h"
#import "MessageViewCell.h"
#import "PublishViewController.h"
#import "MyPublishmessageViewController.h"
#define CELL_WIDTH  ([[UIScreen mainScreen]bounds].size.width-20)/4
#define CELL_HEIGHT CELL_WIDTH+20
@interface MyPublishmessageViewController ()
{
    UIScrollView *mScrollView;
    UISegmentedControl *segment;
    UITextView *textView;
    BOOL IsKV;
    
    NSMutableArray *refershHeaderArray,*refershFooterArray,*topArray,*newArray,*myArray;
    int NewpageIndex,HotpageIndex,mypageIndex;
    NSString *reflID;
     NSMutableArray *yesno;
    UICollectionView *collectionview;
}

@end

@implementation MyPublishmessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    yesno = [NSMutableArray array];
    for (int i = 0; i <800; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"NO" forKey:@"checked"];
        [yesno addObject:dic];
    }
    UIImage *imag = [self imageWithColor:RGBACOLOR(56, 67, 69, 1.0) andSize:CGSizeMake(self.view.frame.size.width, 80)];
    [self.navigationController.navigationBar setBackgroundImage:imag forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:18]};
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

-(void)InitNavigation{
    [super InitNavigation];
    [NavRightBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    [NavRightBtn setImage:[UIImage imageNamed:@"addicon"] forState:UIControlStateNormal];
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavRightBtn  setFrame:CGRectMake(0, 0, 50, 25)];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    [NavRightBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        MyPublishmessageViewController  *viewController = [[MyPublishmessageViewController alloc] init];
        viewController.title = @"我的消息";
        [self.navigationController pushViewController:viewController animated:YES];
    }];
    
}

#pragma mark - 加载控件
-(void)InitControl{
    refershHeaderArray = [[NSMutableArray alloc] init];
    refershFooterArray = [[NSMutableArray alloc] init];
    
    segment = [[UISegmentedControl alloc] initWithItems:@[@"动态",@"分类"]];
    // segment.segmentedControlStyle = UISegmentedControlStylePlain;
    segment.frame = CGRectMake(0, 0, viewW, 30);
    segment.selectedSegmentIndex = 1;
    [segment setTintColor:[UIColor colorWithRed:252.0/255.0 green:175.0/255.0 blue:58.0/255.0 alpha:1.0]];
    [segment addTarget:self action:@selector(segmentedChangeds:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
    mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, winsize.width, winsize.height - 44 - 64 - 30)];
    mScrollView.showsHorizontalScrollIndicator = NO;
    mScrollView.showsVerticalScrollIndicator = NO;
    mScrollView.delegate = self;
    mScrollView.pagingEnabled = YES;
    mScrollView.contentSize = CGSizeMake(winsize.width *2, winsize.height - 44 - 64 - 30);
    mScrollView.contentOffset = CGPointMake(0, 0);
    [mScrollView scrollRectToVisible:CGRectMake(winsize.width, 0, winsize.width, winsize.height  - 44 - 64 - 30) animated:NO];
    [self.view addSubview:mScrollView];
    
    UIView *v2= [[UIView alloc] initWithFrame:CGRectMake(viewW, 0, viewW, winsize.height  - 44 - 64 - 30)];
    [v2 setBackgroundColor:[UIColor grayColor]];
    //[mScrollView addSubview:v2];
    
    UICollectionViewFlowLayout* flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing=0.0;
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
  
    
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
    [self changedLoading];
}

-(void)changedLoading{
    
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
        
        [self changedLoading];
    }
}


@end
