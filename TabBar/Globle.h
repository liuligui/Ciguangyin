//
//  Globle.h
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Globle : NSObject
@property (nonatomic,assign) float globleWidth;
@property (nonatomic,assign) float globleHeight;
@property (nonatomic,assign) float globleAllHeight;
@property (nonatomic,strong) NSMutableArray *vistor;
@property (nonatomic,strong) NSMutableArray *groups;
@property (nonatomic,copy) NSString *groupNumber;
@property (nonatomic,copy) NSString *overGroupNumber;
@property (nonatomic,strong) NSArray *end;
@property (nonatomic,copy) NSString *pwd;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *user_sign;
@property (nonatomic,copy) NSString *fansNum;
@property (nonatomic,copy) NSString *userid;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *user_static;
@property (nonatomic,copy) NSString *user_name;
@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSString *gzNum;
@property (nonatomic,copy) NSString *login_time;
@property (nonatomic,copy) NSString *image_url; 
@property (nonatomic,copy) NSString *isLogThree;
@property (nonatomic,copy) NSString *plwd;
@property (nonatomic,copy) NSArray *contactsArray;
+ (Globle *)shareInstance;
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
+(NSString *)md5: (NSString *) inPutText ;//MD5   定义
@end


