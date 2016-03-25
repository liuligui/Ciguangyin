//
//  NSObject_YYFramework.h
//  advideo
//
//  Created by mokai on 14-7-25.
//  Copyright (c) 2014年 cloudyoo. All rights reserved.
//

#ifndef YYFramework_Define
#define YYFramework_Define

/***
 ==============
 文件导入
 ==============
 ***/
//thirdparty
//#import <OHAttributedLabel/OHAttributedLabel.h>
//#import <OHAttributedLabel/NSAttributedString+Attributes.h>

//#import "AFNetworking.h"
//#import <AFNetworking/AFNetworking.h>
//#import <AFNetworking/UIKit+AFNetworking.h>
//#import <MBProgressHUD/MBProgressHUD.h>
//#import <SIAlertView/SIAlertView.h>
//#import <UIImageView+WebCache.h>
//#import "PullToRefreshView.h"
//#import "PullToLoadMore.h"
//#import "JRSwizzle.h"


//config
#import "APPConfig.h"
#import "KeyConfig.h"
#import "APIConfig.h"
#import "ThemeConfig.h"
#import "EnumConfig.h"

//utils
//#import "SecureUtils.h"
#import "DataUtils.h"
#import "APPUtils.h"
//#import "AlertUtils.h"
//#import "APPManager.h"
//#import "ThemeManager.h"
//#import "HttpManager.h"
//#import "YYImageUtils.h"
//#import "UIUtils.h"
//#import "Location.h"
//#import "MessageRequestManager.h"

//system class extra
//#import "UIImage+YYFramework.h"
//#import "NSDate+YYFramework.h"
////ui extra
//#import "UIColor+YYFramework.h"
//#import "UIView+YYFramework.h"
//#import "UILabel+YYFramework.h"
//#import "UIButton+YYFramework.h"
//#import "IBActionSheet.h"
//#import "CalendarView.h"
//#import "UIViewController+YYFramework.h"
//#import "SelectPicker.h"
//
////Z utils
//#import "F.h"
//#import "M.h"
//#import "EncodeAndDecode.h"
//
////环信
//#import "EaseMob.h"
//#import <UIKit/UIKit.h>
//#import "UIViewController+HUD.h"
//#import "EMSDKFUll.h"
//#import "ChatDemoUIDefine.h"
//#import "EMAlertView.h"
//
////支付宝
//#import <AlipaySDK/AlipaySDK.h>
#import "SIAlertView.h"

/***
 ==============
 系统配置
 ==============
 ***/
#define     IOS_VERSION         [[[UIDevice currentDevice] systemVersion] floatValue]
#define     IPhone5             ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define     SCREEN_W            [UIScreen mainScreen].bounds.size.width//屏幕宽度
#define     SCREEN_H            [UIScreen mainScreen].bounds.size.height//屏幕高度
#define     View_Space          10.f
#define     Top_Status_H        20.f
#define     Top_NavBar_H        44.f
#define     K_VC_Y              64
#define     VIEW_RECT           CGRectMake(0, 0, SCREEN_W, SCREEN_H-Top_NavBar_H)//内容ViewRect
#define     Nav_Item_W          100.f

#define     TabBar_Bt_W         ([UIScreen mainScreen].bounds.size.width/5.0)
#define     TabBar_H            49.0f

/***
 ==============
 宏定义
 ==============
 ***/

//日志
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)
#define debugMethod()
#define NSLog(...){}
#endif

//控件对齐
#define TEXT_ALIGNMENT_CENTER (IOS_VERSION<6.0 ?UITextAlignmentCenter:NSTextAlignmentCenter )
#define TEXT_ALIGNMENT_LEFT (IOS_VERSION<6.0 ?UITextAlignmentLeft:NSTextAlignmentLeft )
#define TEXT_ALIGNMENT_RIGHT (IOS_VERSION<6.0 ?UITextAlignmentRight:NSTextAlignmentRight )

//通用的宏定义
#define     color(R, G, B, A)       [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define     rgb_color(r,g,b,a)      [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]
#define     sa_color(s,a)            [UIColor colorWithRed:(s) / 255.0 green:(s) / 255.0 blue:(s) / 255.0 alpha:a]
//字体
#define     kFont(size)         [UIFont systemFontOfSize:size]
#define     kFontBold(size)     [UIFont boldSystemFontOfSize:size]
//字符
#define     str_isblank(str)    (str==[NSNull null] || str==nil || [str.description isEqual:@""])//是否为nil或空字符
#define     str_isnotblank(str)    (!str_isblank(str))
#define     str_blank(str)   (str_isblank(str)?@"":str_trim(str))//如果为nil则返回空字符
#define     str_default(str,val)   (str_isblank(str)?val:str)//如果为nil则返回val
#define     str_trim(str)    [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]//去掉两边空格
//数组
#define    arr_isblank(arr)     (arr==[NSNull null] || arr==nil || [arr.description isEqual:@""]||(arr.count==0))//是否为空数组
#define    arr_blank(arr)   (arr_isblank(arr)?@[]:arr)//如果为nil则返回空数组


#endif