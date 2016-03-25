


//
//  PaiweizhinanViewController.m
//  HomeAdorn
//
//  Created by mac on 15/7/19.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "PaiweizhinanViewController.h"

@interface PaiweizhinanViewController ()
{
    UITextView *ContentTextView;
    NSString *textstring;
    UILabel *label;
}

@end

@implementation PaiweizhinanViewController

- (void)viewDidLoad {
    self.title = @"排位指南";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
}

-(void)InitControl
{
    
    
    textstring = @"";
    
    CGRect rect = [textstring boundingRectWithSize:CGSizeMake(self.view.frame.size.width-20, self.view.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
    
    
    CGFloat w = rect.size.height;
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, self.view.frame.size.height - 64)];
    scroll.showsVerticalScrollIndicator = NO;
    scroll.contentSize = CGSizeMake(0, w);
    [self.view addSubview:scroll];
    

    
    
   label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, w)];
    [label setNumberOfLines:0];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.font = [UIFont systemFontOfSize:14];
    label.text =textstring;
    
    [scroll addSubview:label];

}

-(void)InitLoadData
{
    HUD.mode = MBProgressHUDModeIndeterminate;
    [HUD show:YES];
    
    [[CommonFunctions sharedlnstance] getPwzn:@"1" requestBlock:^(NSObject *requestData, BOOL IsError) {
 
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            label.text = [dic objectForKey:@"context"];
          
        }
        
    }];
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
