//
//  AppUtils.h
//  ProDemo
//
//  Created by ylh on 13-12-25.
//  Copyright (c) 2013年 ylh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppUtils : NSObject

//获取软件本机版本号
+(NSString*)getLocalVersion;

//居中
+ (CGRect)CenterRc:(CGRect)srcRc DesRc:(CGSize)desSize;

+ (void)showAlert:(NSString*)title Message:(NSString*)msg CancelBt:(NSString*)cancelStr;

//根据路径创建对应的目录
+ (BOOL) createPathWithFilePath:(NSString *) filePath;
+ (NSString*)creatFilePathAndName:(NSString*)filePath FileName:(NSString*)fileName;

+ (CGSize)sizeWithFont:(UIFont*)font Str:(NSString*)str;
+ (CGSize)getsize:(NSString *)str wid:(CGFloat)th font:(CGFloat)size;

+ (BOOL)isStrNil:(NSString*)str;

//Unicode转UTF-8 url特殊字符转换
+ (NSString *)encodeUrlString: (NSString *)input;
+ (NSString *)decodeUrlString:(NSString *) input;

//校验数字
+(BOOL) isValidateNumber:(NSString *)money;
//校验Email
+ (BOOL)isValidEmail:(NSString *)checkString;

//校验手机号码
+(BOOL) isValidateMobile:(NSString *)mobile;
//校验货币
+(BOOL) isValidateMoney:(NSString *)money;
//校验货币,并且只能有2位小数
+(BOOL) isValidate2Money:(NSString *)money;
//校验货币，自定义max小数位
+(BOOL) isValidateMoney:(NSString *)money maxDecimalsCount:(NSInteger)count;

//校验银行卡号
+(BOOL) isValidateBankCard:(NSString *)card;
//校验身份号
+(BOOL) isValidatePersonCard:(NSString *)card;

+ (void)UserDefaultStrIn:(NSString*)key Value:(NSString*)value;
+ (void)UserDefaultBoolIn:(NSString*)key Value:(BOOL)value;
+ (NSString*)UserDefaultStrOut:(NSString*)key;
+ (BOOL)UserDefaultBoolOut:(NSString*)key;

//Take photo
+ (void)selectImageFromCamera:(id)delegate;
//select from photoLib
+ (void)selectImageFromPhotoLibrary:(id)delegate;

//table的UI调整
+(void)setExtraCellLineHidden: (UITableView *)tableView;

//获取当前时间
+(NSDate*)getCurrentDate;
//获取当前时间转化的NSString 类型
+(NSString *)getCurrentDateToStr;
//转化任意日期到当前时区
+(NSDate *)convertDateToLocalTime: (NSDate *)forDate;
//时间处理
+ (NSString *)dateFormatToString:(NSDate*)date Format:(NSString *)formatString;
+ (NSString*)dateStrFormatToCommonStr:(NSString*)dateStr;
+ (NSString*)dateFormatToCommonStr:(NSDate*)dates;
+ (NSDate*)strFormatToDate:(NSString *) formatString DateStr:(NSString*)stringTime;
//将系统返回来的string日期格式化年月日
+ (NSString*)strFormatToYMD:(NSString*)dateStr;
//获取相差天数
+(int )getLeftFromFirstDate:(NSDate*)firstDate andAnoterDate:(NSDate *)anotherDate;


+ (CGSize)scaleSize:(CGSize)belongSize ScaleSize:(CGSize)scaleSize;

//修改图片颜色
+ (UIImage *) imageWithTintColor:(UIImage*)srcImg Color:(UIColor *)tintColor;

//颜色转图片
+ (UIImage *) imageFromColor:(UIColor *)color;
//html转换UIColor
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

//图片缩放
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

//图片压缩
+(void)imageHandleWithOriginalImage:(UIImage*)oriImage bigImage:(NSMutableData*)bigImage;

//判断设备屏幕大小
+(BOOL)isIphone5OrLater;

//nsstring转换成nsnumber
+(NSNumber*)nsNumberFromString:(NSString*)str;

//nsnumber转换成nsstring
+(NSString*)nStringFromNsnumber:(NSNumber*)strNum;

//初始化控件
+(UILabel*)initUILabel:(NSString*)strTitle font:(float)font color:(UIColor*)textColor rect:(CGRect) rectText;

+(UIImageView*)initUIImageView:(NSString*) imageName rect:(CGRect)rectImage;

+(UIButton*)initButton:(CGRect)rectButton str:(NSString*)strName;

//获取控制器高度
+(CGFloat)getCtrHeight;

//网络状态
+(BOOL)isNetworkReach;

+(NSArray *)banks;

//生成唯一的随机数
+(NSString *)getRanUniqueID;

//获取当年天数
+(int)getDaysFromCurrentYear;

//图片拉伸
+(UIImage *)stretchImage:(UIImage *)img edgeInsets:(UIEdgeInsets)inset;


//金额格式化
+(NSString *)moenyFormat:(double)number;
+(NSString *)moeny2Format:(double)number;

//数组，字典 转json
+(NSString *)dataTransferToJson:(id)theData;



/**
 UID以及服务器返回key存取
 **/
+ (void)setUid:(NSString *)uid avatar:(NSString *)avatar tokenId:(NSString *)tokenid userType:(NSString *)userType setUserName:(NSString *)userName setNickName:(NSString *)nickName;

+(NSDictionary *)getPersonDic;

+(NSString *)getNickName;
+(NSString *)getUserName;
+(NSString *)getUid;
+(NSString *)getTokenKey;
+(NSString *)getUserType;

/**
 车市长存储
 **/
+ (void)setCarUid:(NSString *)carUid carAvatar:(NSString *)carAvatar setCarUserName:(NSString *)carUserName setCarNickName:(NSString *)carNickName;
+(NSDictionary *)getCarPersonDic;


//根据姓名获取名字拼音和拼音首字母
+(NSString*)getNamePinYingWithName:(NSString*)name;


//记录选择了城市
+(NSString *)getMyCity;

//设置选择城市
+(void)setMyCity:(NSString *)city;

//设置编辑资料状态
+(void)setEditState:(NSString *)state;

//获取编辑资料状态
+(NSString *)getEditState;

//登录状态
+(void)setLoginState:(BOOL)islogin;
+(BOOL)isLogin;

//设置我的需求
+(void)setMyRequirement:(NSString *)requirement;
//记录我的需求
+(NSString *)getMyRequirement;

//获取数组最大的值
+(id)getMaxNum:(NSArray *)arr;

//获取数组最大的值
+(id)getMinNum:(NSArray *)arr;

@end
