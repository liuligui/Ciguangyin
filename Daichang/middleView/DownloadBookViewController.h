//
//  DownloadBookViewController.h
//  HomeAdorn
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "JSON.h"
@interface DownloadBookViewController : BaseViewController<UIScrollViewDelegate,MJRefreshBaseViewDelegate>
{
    
    ASIHTTPRequest *request;
    ASINetworkQueue *networkQueue;
     UIActivityIndicatorView *activityIndicator;
     BOOL failed;
}
@property (nonatomic,strong) NSString *smid;

@end
