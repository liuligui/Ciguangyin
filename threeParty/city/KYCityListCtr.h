//
//  CityListViewController.h
//  CityList
//
//  Created by Chen Yaoqiang on 14-3-6.
//
//

#import <UIKit/UIKit.h>
#import "BaseController.h"
typedef void(^citySelectBlock)(NSString *city);

@interface KYCityListCtr : BaseController<UITableViewDataSource,UITableViewDelegate>

- (void)setBlock:(citySelectBlock)block;

@end
