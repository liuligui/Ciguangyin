//
//  Configer.m
//  advideo
//
//  Created by mokai on 14-7-25.
//  Copyright (c) 2014年 cloudyoo. All rights reserved.
//

#import "DataUtils.h"


@implementation DataUtils

static NSMutableDictionary *data;
static NSMutableDictionary *localData;//本地数据

//获取APP配置
+(NSString *)dataForKey:(NSString *)key{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

//设置APP配置
+(void)setData:(NSString *)data forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:key];
}

////设置APP配置，且是加密的，不可逆的
//+(void)setPrivateData:(NSString *)data forKey:(NSString *)key{
//    data = [SecureUtils md5:data];
//    [DataUtils setData:data forKey:key];
//}

//+(void)_initlocalData{
//    NSLock *lock = [[NSLock alloc]init];
//    [lock lock];
//    if (localData == nil) {
//        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//        localData = [[NSMutableDictionary alloc]initWithContentsOfFile:[path stringByAppendingPathComponent:APP_CONFIG_PATH]];
//    }
//    [lock unlock];
//}

//调用此方法进行同步到本地
+(void)synchonize{
    [[NSUserDefaults standardUserDefaults]synchronize];
}

//获取内存配置
+(NSObject *)tempDataForKey:(NSString *)key{
    [DataUtils _initData];
    return [data objectForKey:key];
}

//设置内存配置
+(void)setTempData:(NSObject *)dataObject forKey:(NSString *)key{
    [DataUtils _initData];
    [data setObject:dataObject forKey:key];
}

//移除内存变量配置
+(void)removeDataForKey:(NSString *)key
{
    [DataUtils _initData];
    [data removeObjectForKey:key];
}

+(void)_initData{
    NSLock *lock = [[NSLock alloc]init];
    [lock lock];
    if (data==nil) {
        data = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    [lock unlock];
}


@end
