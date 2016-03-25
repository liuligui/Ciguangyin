//
//  YGBookshelfCtr.h
//  HomeAdorn
//
//  Created by wangxiaoer on 7/20/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
@interface YGBookshelfCtr: BaseViewController<UIScrollViewDelegate,MJRefreshBaseViewDelegate>
{
    
    ASIHTTPRequest *request;
    ASINetworkQueue *networkQueue;
    UIActivityIndicatorView *activityIndicator;
    BOOL failed;
}
@property (nonatomic,strong) NSString *smid;

@end
