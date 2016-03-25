//
//  Globle.h
//  SlideSwitchDemo
//
//  Created by liulian on 13-4-23.
//  Copyright (c) 2013年 liulian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Visitor.h"
#import "User.h"
@interface Globle : NSObject
@property (nonatomic,strong) User *guider;
@property (nonatomic,assign) float globleWidth;
@property (nonatomic,assign) float globleHeight;
@property (nonatomic,assign) float globleAllHeight;
@property (nonatomic,strong) NSMutableArray *vistor;
@property (nonatomic,strong) NSMutableArray *groups;
@property (nonatomic,copy) NSString *groupNumber;
@property (nonatomic,copy) NSString *overGroupNumber;
+ (Globle *)shareInstance;
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
+(NSString *)md5: (NSString *) inPutText ;//MD5   定义
@end
