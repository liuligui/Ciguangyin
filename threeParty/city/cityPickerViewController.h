//
//  cityPickerViewController.h
//  HomeAdorn
//
//  Created by mac on 15/8/2.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol setcityDelegate <NSObject>

-(void)setcity:(NSString *)city;

@end


@interface cityPickerViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *lbprovince;


@property (weak, nonatomic) IBOutlet UITextField *areaText;
@property (nonatomic,strong) NSString *type;

@property (weak, nonatomic) IBOutlet UILabel *lbtype;
@property (nonatomic,unsafe_unretained)id<setcityDelegate> delegate;

@end
