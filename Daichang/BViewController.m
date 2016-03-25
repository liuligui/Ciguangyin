

//
//  BViewController.m
//  HomeAdorn
//
//  Created by liuligui on 15/10/25.
//  Copyright © 2015年 IWork. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()

@end

@implementation BViewController

-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
    
}

- (void)viewDidLoad {
    self.title = _titless;
    
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self loadHtml:@""];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadHtml:(NSString *)context
{
    UIWebView *_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    
    _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    _webView.delegate = self;
    
    NSString *resourcePath = [ [NSBundle mainBundle] resourcePath];
   
    NSString * htmlString=@"";
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
  
    
    htmlString = _context;
    [_webView loadHTMLString:htmlString  baseURL:[NSURL fileURLWithPath:[ [NSBundle mainBundle] bundlePath]]];
    [self.view addSubview:_webView];
    
    
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
