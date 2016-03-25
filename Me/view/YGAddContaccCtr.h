//
//  YGAddContaccCtr.h
//  HomeAdorn
//
//  Created by wangxiaoer on 7/22/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import "BaseController.h"

@interface YGAddContaccCtr : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *idcard;
@property (weak, nonatomic) IBOutlet UITextField *idcardaddress;
@property (weak, nonatomic) IBOutlet UITextField *nowaddress;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *honephone;
@property (weak, nonatomic) IBOutlet UITextField *homeaddress;
@property (weak, nonatomic) IBOutlet UILabel *address1;
@property (weak, nonatomic) IBOutlet UILabel *address2;
@property (weak, nonatomic) IBOutlet UILabel *address3;
@property (weak, nonatomic) IBOutlet UILabel *lbsex;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (nonatomic,strong) NSString *contactName;
@end
