//
//  Configer.h
//  advideo
//
//  Created by mokai on 14-7-25.
//  Copyright (c) 2014年 cloudyoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataUtils : NSObject

//永久的，基于本地
+(NSString *)dataForKey:(NSString *)key;
+(void)setData:(NSString *)data forKey:(NSString *)key;
//私有的，加密的，不可逆
+(void)setPrivateData:(NSString *)data forKey:(NSString *)key;
//同步到本地
+(void)synchonize;


//临时的，基于内存
+(id)tempDataForKey:(NSString *)key;
+(void)setTempData:(NSObject *)data forKey:(NSString *)key;
+(void)removeDataForKey:(NSString *)key;
@end
