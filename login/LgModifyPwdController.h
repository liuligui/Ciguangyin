//
//  LgModifyPwdController.h
//  HomeAdorn
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LgModifyPwdController : BaseViewController<UIScrollViewDelegate,UIWaterflowViewdataSource,UIWaterflowViewdelegate,MJRefreshBaseViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *pwd1;
@property (nonatomic,strong) NSString *phone;
@property (weak, nonatomic) IBOutlet UITextField *pwd2;
@end

