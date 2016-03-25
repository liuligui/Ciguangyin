//
//  ModifyPwdController.h
//  HomeAdorn
//
//  Created by mac on 15/7/26.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyPwdController  : BaseViewController<UIScrollViewDelegate,UIWaterflowViewdataSource,UIWaterflowViewdelegate,MJRefreshBaseViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *pwd1;
@property (nonatomic,strong) NSString *phone;
@property (weak, nonatomic) IBOutlet UITextField *pwd2;
@end
