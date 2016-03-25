//
//  huifangViewController.h
//  HomeAdorn
//
//  Created by liuligui on 15/11/7.
//  Copyright © 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface huifangViewController : BaseViewController<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) NSString *name;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UISwitch *kaiguan;
@property (weak, nonatomic) IBOutlet UILabel *zhuanhtia;
@property (weak, nonatomic) IBOutlet UILabel *datetimes;
@property (weak, nonatomic) IBOutlet UIPickerView *selectPicker;
@property (weak, nonatomic) IBOutlet UIToolbar *doneToolbar;
@property (weak, nonatomic) IBOutlet UITextField *textf;

@property (nonatomic,strong) NSString *mid;
@end
