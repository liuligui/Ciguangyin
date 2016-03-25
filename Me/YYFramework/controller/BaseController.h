//
//  BaseController.h
//  Notepad
//
//  Created by ylh on 14-3-4.
//  Copyright (c) 2014年 ylh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseController : UIViewController<UITextFieldDelegate>

@property(nonatomic,retain)UIView*          sView;//内容区
@property(nonatomic,retain)UILabel*         titleLb;
@property(nonatomic,retain)UIView*          topStatusView;  //状态栏
@property(nonatomic,retain)UIView*          topNavBarView;  //navBar

@property(nonatomic,retain)UIColor*         themeColor;
@property(nonatomic,retain)UIColor*         themeBtnColor;
@property(nonatomic,retain)UIColor*         themeBorderColor;
@property(nonatomic)       CGFloat          themeBorderWidth;//边框宽度

@property(nonatomic)       UIButton*        navLeftBt;
@property(nonatomic)       UILabel*         navLeftLb;
@property(nonatomic)       UIButton*        navRightBt;
@property(nonatomic)       UILabel*         navRightLb;

- (void)navBarItemInit:(NSString*)title Position:(BOOL)left;
- (void)navBarItemInitLeftWithImage:(NSString*)title strImageName:(NSString*)imageName Position:(BOOL)left;

//@selector
- (void)leftBarBtPressed:(UIButton*)sender;
- (void)rightBarBtPressed:(UIButton*)sender;

-(void)hideNav;
-(void)showNav;
 

//文本框delegate
-(void)textFieldNext:(UITextField *)textField;//当returnKeyType为Next时
-(void)textFieldReturn:(UITextField *)textField;//不为Next则进入此方法

//设置nav文字导航按钮显示隐藏
-(void)setNavTitleBtPosintion:(BOOL)isLeft hidden:(BOOL)hidden;

@end
