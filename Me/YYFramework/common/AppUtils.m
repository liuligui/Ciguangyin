//
//  AppUtils.m
//  ProDemo
//
//  Created by ylh on 13-12-25.
//  Copyright (c) 2013年 ylh. All rights reserved.
//

#import "AppUtils.h"
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation AppUtils

//获取本机软件版本号
+(NSString*)getLocalVersion{
    NSDictionary *infoDict = [[NSBundle mainBundle]infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleVersion"];
    return currentVersion;
}

+ (CGRect)CenterRc:(CGRect)srcRc DesRc:(CGSize)desSize
{
    CGRect centerRc = CGRectMake(0, 0, desSize.width, desSize.height);
    CGFloat x = CGRectGetMidX(srcRc);
    CGFloat y = CGRectGetMidY(srcRc);
    centerRc.origin.x = x - desSize.width/2;
    centerRc.origin.y = y - desSize.height/2;
    
    return centerRc;
}

+ (void)showAlert:(NSString*)title Message:(NSString*)msg CancelBt:(NSString*)cancelStr
{
    id delegate = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:cancelStr otherButtonTitles:nil];
    [alert show];
}

//根据路径创建对应的目录
+ (BOOL) createPathWithFilePath:(NSString *) filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath])
    {
        return YES;
    }
    else
    {
        return [fileManager createDirectoryAtPath:filePath
                      withIntermediateDirectories:YES
                                       attributes:nil
                                            error:nil];
    }
}

//创建文件路径
+ (NSString*) creatFilePathAndName:(NSString*)filePath FileName:(NSString*)fileName
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString * path = [documentPath stringByAppendingPathComponent:filePath];
    //存在路径则不处理，不存在则创建路径
    [AppUtils createPathWithFilePath:path];
    
    return [path stringByAppendingPathComponent:fileName];
}

+ (CGSize)sizeWithFont:(UIFont*)font Str:(NSString*)str
{
    CGSize strSize;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                font, NSFontAttributeName,
                                //[NSColor redColor], NSForegroundColorAttributeName,
                                //[NSColor yellowColor], NSBackgroundColorAttributeName,
                                nil];
    if(IOS_VERSION >= 7.0)
    {
        strSize = [str sizeWithAttributes:attributes];
    }
    else
    {
        strSize = [str sizeWithFont:font];
    }
    
    return strSize;
}

//根据字符串的宽度获取size
+ (CGSize)getsize:(NSString *)str wid:(CGFloat)th font:(CGFloat)size
{
    CGSize constraint = CGSizeMake(th, 20000.0f);
    CGSize sizeStr = [str sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    return sizeStr;
}

+ (BOOL)isStrNil:(NSString*)str
{
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//Unicode转UTF-8
+ (NSString *)encodeUrlString: (NSString *)input
{
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    
    NSString *outputStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)input,
                                            NULL,
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            kCFStringEncodingUTF8));
    return outputStr;
}

+ (NSString *)decodeUrlString:(NSString *) input  //解码
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    
    [outputStr replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (BOOL)isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^(1)\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

+(BOOL) isValidateNumber:(NSString *)money
{
    NSString *phoneRegex = @"^\\d{1,}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:money];
}


+(BOOL) isValidateMoney:(NSString *)money
{
    return [self isValidateMoney:money maxDecimalsCount:-1];
}

+(BOOL) isValidate2Money:(NSString *)money
{
    return [self isValidateMoney:money maxDecimalsCount:2];
}

+(BOOL) isValidateMoney:(NSString *)money maxDecimalsCount:(NSInteger)count
{
    NSString *phoneRegex = @"^(\\d+)+$";
    if (count>0) {
         phoneRegex = [NSString stringWithFormat:@"^(\\d+)+(\\.\\d{0,%d})?$",count];
    }else if(count<0){
        phoneRegex = @"^(\\d+)+(\\.\\d{1,})?$";
    }
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^0(\\d+)$"];
    return [phoneTest evaluateWithObject:money] && ![phoneTest1 evaluateWithObject:money];
}



+(BOOL) isValidateBankCard:(NSString *)card{
    NSString *phoneRegex = @"^\\d{13,20}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:card];
}

+(BOOL) isValidatePersonCard:(NSString *)card{
    NSString *phoneRegex = @"^(\\d{6})(\\d{4})(\\d{2})(\\d{2})(\\d{3})([0-9]|X|x)$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:card];
}

+ (void)UserDefaultStrIn:(NSString*)key Value:(NSString*)value
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)UserDefaultBoolIn:(NSString*)key Value:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*)UserDefaultStrOut:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

+ (BOOL)UserDefaultBoolOut:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (void)selectImageFromCamera:(id)delegate
{
	UIImagePickerController *controller = [[UIImagePickerController alloc] init];
	controller.sourceType = UIImagePickerControllerSourceTypeCamera;
	controller.delegate = delegate;
    [(UIViewController*)delegate presentViewController:controller animated:YES completion:nil];
}

+ (void)selectImageFromPhotoLibrary:(id)delegate
{
	UIImagePickerController *controller = [[UIImagePickerController alloc] init];
	controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	controller.delegate = delegate;
    [(UIViewController*)self presentViewController:controller animated:YES completion:nil];
}

//table的UI调整
+(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    [tableView setTableHeaderView:view];

}

+(NSDate*)getCurrentDate{
    NSDate *date = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    return [date  dateByAddingTimeInterval: interval];
}

+(NSString *)getCurrentDateToStr
{
   return  [AppUtils dateFormatToString:[NSDate date] Format:@"yyyy:MM:dd HH:mm:ss.S"];
}

//转化任意日期到当前时区
+(NSDate *)convertDateToLocalTime: (NSDate *)forDate {
    
    NSTimeZone *nowTimeZone = [NSTimeZone localTimeZone];
    
    int timeOffset = [nowTimeZone secondsFromGMTForDate:forDate];
    
    NSDate *newDate = [forDate dateByAddingTimeInterval:timeOffset];
    
    return newDate;
}

+ (NSString *)dateFormatToString:(NSDate*)date Format:(NSString *)formatString
{
    NSDateFormatter * dateFromatter=[[NSDateFormatter alloc] init];
    [dateFromatter setTimeStyle:NSDateFormatterShortStyle];
    if(formatString!=nil)
    {
        [dateFromatter setDateFormat:formatString];
    }
    NSString * strDate=[dateFromatter stringFromDate:date];
    return strDate;
}

+ (NSDate*)strFormatToDate:(NSString *) formatString DateStr:(NSString*)stringTime

{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : formatString];
    
    NSDate *dateTime = [formatter dateFromString:stringTime];
    
    return dateTime;
}

//+ (NSString*)strFormatToYMD:(NSString*)dateStr
//{
//    NSDate* date = [AppUtils strFormatToDate:@"yyyy-MM-dd HH:mm:ss" DateStr:dateStr];
//    return [F yyyyMMddFromDate:date];
//}

+ (NSString*)dateStrFormatToCommonStr:(NSString*)dateStr
{
    NSDate* exchangeDate = [AppUtils strFormatToDate:@"yyyy-MM-dd HH:mm:ss" DateStr:dateStr];
    NSTimeInterval late = [exchangeDate timeIntervalSince1970]*1;
    
    NSString * timeString = nil;
    NSString* date = [[dateStr substringFromIndex:5] substringToIndex:5];
    NSString* time = [dateStr substringWithRange:NSMakeRange([dateStr rangeOfString:@" "].location, 6)];
    
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    NSTimeInterval cha = now - late;
    
    if (cha/86400 < 1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        NSInteger h = [[[[time stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByString:@":"] objectAtIndex:0] integerValue];
        if(h + [timeString integerValue] > 24)
        {
            timeString = [NSString stringWithFormat:@"昨天%@", time];
        }
        else
        {
            timeString = [NSString stringWithFormat:@"今天%@",time];
        }
    }
    
    if (cha/86400 > 1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        int num = [timeString intValue];
        if (num < 2)
        {
            timeString = [NSString stringWithFormat:@"昨天%@",time];
        }
        else if(num == 2)
        {
            timeString = [NSString stringWithFormat:@"前天%@",time];
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%@%@",date,time];
        }
    }
    
    return timeString;
}

+ (NSString*)dateFormatToCommonStr:(NSDate*)dates
{
    NSTimeInterval late = [dates timeIntervalSince1970]*1;
    
    NSString* theDate = [AppUtils dateFormatToString:dates Format:@"yyyy-MM-dd HH:mm:ss"];
    NSString * timeString = nil;
    NSString* date = [[theDate substringFromIndex:5] substringToIndex:5];
    NSString* time = [theDate substringWithRange:NSMakeRange([theDate rangeOfString:@" "].location, 6)];
    
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    NSTimeInterval cha = now - late;
    
    if (cha/86400 < 1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        NSInteger h = [[[[time stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByString:@":"] objectAtIndex:0] integerValue];
        if(h + [timeString integerValue] > 24)
        {
            timeString = [NSString stringWithFormat:@"昨天%@", time];
        }
        else
        {
            timeString = [NSString stringWithFormat:@"今天%@",time];
        }
    }
    
    if (cha/86400 > 1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        int num = [timeString intValue];
        if (num < 2)
        {
            timeString = [NSString stringWithFormat:@"昨天%@",time];
        }
        else if(num == 2)
        {
            timeString = [NSString stringWithFormat:@"前天%@",time];
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%@%@",date,time];
        }
    }
    
    return timeString;
}

+(int)getLeftFromFirstDate:(NSDate*)firstDate andAnoterDate:(NSDate *)anotherDate{
    
    int timeOffset = [firstDate timeIntervalSinceDate:anotherDate];
    int days = timeOffset/3600/24;
    
    return days;
}

+ (CGSize)scaleSize:(CGSize)belongSize ScaleSize:(CGSize)scaleSize
{
    CGSize size;
    CGFloat w_scale,h_scale;
    w_scale = (belongSize.width/scaleSize.width);
    h_scale = (belongSize.height/scaleSize.height);
    if(h_scale <= w_scale)
    {
        size = CGSizeMake(scaleSize.width * h_scale, scaleSize.height* h_scale);
    }
    else
    {
        size = CGSizeMake(scaleSize.width * w_scale, scaleSize.height* w_scale);
    }
    return size;
}

+ (UIImage *) imageWithTintColor:(UIImage*)srcImg Color:(UIColor *)tintColor
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(srcImg.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, srcImg.size.width, srcImg.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [srcImg drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

+ (UIImage *) imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];//字符串处理
    //例子，stringToConvert #ffffff
    if ([cString length] < 6)
        return [UIColor whiteColor];//如果非十六进制，返回白色
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];//去掉头
    if ([cString length] != 6)//去头非十六进制，返回白色
        return [UIColor whiteColor];
    //分别取RGB的值
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    //NSScanner把扫描出的制定的字符串转换成Int类型
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //转换为UIColor
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//图片缩放
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//图片处理
+(void)imageHandleWithOriginalImage:(UIImage*)oriImage bigImage:(NSMutableData*)bigImage{
    CGSize originalImageSize = oriImage.size;
    
    UIImage *bigImg = nil;
    
    
    if (originalImageSize.width > originalImageSize.height) {//横图
        if (originalImageSize.width > originalImageSize.height * 2) {//长横图
            
            //原图
            //缩放处理
            if (originalImageSize.height > BIG_IMAGE_HEIGHT_40) {
                CGSize scaleSize = CGSizeMake(BIG_IMAGE_HEIGHT_40 * originalImageSize.width / originalImageSize.height, BIG_IMAGE_HEIGHT_40);
                bigImg = [self imageWithImage:oriImage scaledToSize:scaleSize];
            }else{
                bigImg = oriImage;
            }
        }else{
            
            //原图
            if ([self isIphone5OrLater]) {//4“屏
                if (originalImageSize.width > BIG_IMAGE_WIDTH_40) {
                    CGSize scaleSize = CGSizeMake(BIG_IMAGE_WIDTH_40, BIG_IMAGE_WIDTH_40 * originalImageSize.height / originalImageSize.width);
                    bigImg = [self imageWithImage:oriImage scaledToSize:scaleSize];
                }else{
                    bigImg = oriImage;
                }
            }else{//3.5”屏
                if (originalImageSize.width > BIG_IMAGE_WIDTH_35) {
                    CGSize scaleSize = CGSizeMake(BIG_IMAGE_WIDTH_35, BIG_IMAGE_WIDTH_35 * originalImageSize.height / originalImageSize.width);
                    bigImg = [self imageWithImage:oriImage scaledToSize:scaleSize];
                }else{
                    bigImg = oriImage;
                }
            }
        }
        
    }else{//方图,竖图
        
        //原图处理
        if (originalImageSize.width < BIG_IMAGE_VERTIACL_WIDTH) {
            bigImg = oriImage;
        }else{
            if (originalImageSize.height > originalImageSize.width * 2) {
                if (originalImageSize.width >= BIG_IMAGE_VERTIACL_WIDTH) {
                    //缩略图处理方式，对原图进行缩放
                    CGSize scaleSize = CGSizeMake(BIG_IMAGE_VERTIACL_WIDTH, BIG_IMAGE_VERTIACL_WIDTH * originalImageSize.height / originalImageSize.width);
                    bigImg = [self imageWithImage:oriImage scaledToSize:scaleSize];
                }else{
                    bigImg = oriImage;
                }
            }else{
                if ([self isIphone5OrLater]) {//4"屏
                    if (originalImageSize.height > BIG_IMAGE_VERTIACL_HEIGHT_40) {
                        //缩略图处理方式，对原图进行缩放
                        CGSize scaleSize = CGSizeMake(BIG_IMAGE_VERTIACL_HEIGHT_40 * originalImageSize.width / originalImageSize.height, BIG_IMAGE_VERTIACL_HEIGHT_40);
                        bigImg = [self imageWithImage:oriImage scaledToSize:scaleSize];
                    }else{
                        bigImg = oriImage;
                    }
                }else{//3.5"屏
                    if (originalImageSize.height > BIG_IMAGE_VERTIACL_HEIGHT_35) {
                        //缩略图处理方式，对原图进行缩放
                        CGSize scaleSize = CGSizeMake(BIG_IMAGE_VERTIACL_HEIGHT_35 * originalImageSize.width / originalImageSize.height, BIG_IMAGE_VERTIACL_HEIGHT_35);
                        bigImg = [self imageWithImage:oriImage scaledToSize:scaleSize];
                    }else{
                        bigImg = oriImage;
                    }
                }
            }
        }
    }
    
    [bigImage setData:UIImageJPEGRepresentation(bigImg, 1)];
    
    long length = [bigImage length];
    float scale = 0;
    if (length > PIC_BYTES * 2 && length <= PIC_BYTES * 6) {
        scale = 2;
    }else if (length > PIC_BYTES * 6 && length <= PIC_BYTES * 10){
        scale = 3;
    }else if (length > PIC_BYTES * 10 && length <= PIC_BYTES * 20){
        scale = 4;
    }else if (length > PIC_BYTES * 20 && length <= PIC_BYTES * 30){
        scale = 8;
    }else if (length > PIC_BYTES * 30 && length <= PIC_BYTES * 40){
        scale = 12;
    }else{
        scale = 2;
    }
    
    if (scale > 0) {
        [bigImage setData:UIImageJPEGRepresentation(bigImg, scale * PIC_BYTES / length)];
    }
    
    length = [bigImage length];
}

+(BOOL)isIphone5OrLater{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    //横屏和竖屏
    if (568 <= screenHeight || 568 <= screenWidth) {
        return YES;
    }
    
    return NO;
}

+(NSNumber*)nsNumberFromString:(NSString*)str
{
    NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber*  myNumber = [f numberFromString:str];
    return myNumber;
}

+(NSString*)nStringFromNsnumber:(NSNumber*)strNum
{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    NSString*  tempStr = [numberFormatter stringFromNumber:strNum];
    return tempStr;
}

#pragma mark -系统控件的初始化
+(UILabel*)initUILabel:(NSString*)strTitle font:(float)font color:(UIColor*)textColor rect:(CGRect) rectText
{
    UILabel* label = [[UILabel alloc] initWithFrame:rectText];
    label.text = strTitle;
    label.textColor = textColor;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:font];
    return label;
}
+(UIImageView*)initUIImageView:(NSString*) imageName rect:(CGRect)rectImage
{
    UIImageView*  imageView = [[UIImageView alloc] initWithFrame:rectImage];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}
+(UIButton*)initButton:(CGRect)rectButton str:(NSString *)strName
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:rectButton];
    [button setBackgroundImage:[UIImage imageNamed:strName] forState:UIControlStateNormal];
    return button;
}

//获取控制器高度
+(CGFloat)getCtrHeight
{
    if (IOS_VERSION>=7.0) {
        return SCREEN_H;
    }else{
        return SCREEN_H-Top_Status_H;
    }
}

////网络状态
//+(BOOL)isNetworkReach{
//    BOOL isNetworkReach = [[DataUtils tempDataForKey:APPConfigKeyNetworkStatus] boolValue];
//    return isNetworkReach;
//}

+(NSArray *)banks{
    return @[
      @{@"bankid":@"1",@"code":@"ICBC",@"name":@"中国工商银行"},
      @{@"bankid":@"2",@"code":@"CCB",@"name":@"中国建设银行"},
      @{@"bankid":@"3",@"code":@"CMB",@"name":@"招商银行"},
      @{@"bankid":@"4",@"code":@"BOC",@"name":@"中国银行"},
      @{@"bankid":@"5",@"code":@"EMS",@"name":@"中国邮政银行"},
      @{@"bankid":@"6",@"code":@"BCM",@"name":@"交通银行"},
      @{@"bankid":@"7",@"code":@"CGB",@"name":@"广发银行"},
      @{@"bankid":@"8",@"code":@"SB",@"name":@"浦发银行"},
      @{@"bankid":@"9",@"code":@"CEB",@"name":@"中国光大银行"},
      @{@"bankid":@"10",@"code":@"PAB",@"name":@"平安银行"},
      @{@"bankid":@"11",@"code":@"HB",@"name":@"华夏银行"},
      @{@"bankid":@"12",@"code":@"CNCB",@"name":@"中信银行"},
      @{@"bankid":@"13",@"code":@"ABC",@"name":@"中国农业银行"},
      @{@"bankid":@"14",@"code":@"CMBC",@"name":@"中国民生银行"},
      @{@"bankid":@"15",@"code":@"CIB",@"name":@"兴业银行"},
      @{@"bankid":@"16",@"code":@"BOD",@"name":@"东莞银行"}
      ];
}

//生成唯一的随机数
+(NSString *)getRanUniqueID
{
    NSString *udid;
    if (IOS_VERSION >= 7.0) {
        udid = [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    else if (IOS_VERSION >= 2.0) {
        udid = [self getMacAddress];
    }
    
    return [NSString stringWithFormat:@"%@%@",udid,[AppUtils getCurrentDateToStr]];
}

//获取mac地址，ios7或以上无效
+ (NSString *)getMacAddress
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = nil;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        NSLog(@"Error: %@", errorFlag);
        if (msgBuffer) {
            free(msgBuffer);
        }
        
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    NSLog(@"Mac Address: %@", macAddressString);
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}


//获取当年天数
+(int)getDaysFromCurrentYear
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    
    
    NSDateComponents *comps =[calender components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit | NSWeekCalendarUnit)
                              
                                         fromDate:[NSDate date]];
    
    int count = 0;
    
    for (int i=1; i<=12; i++) {
        
        [comps setMonth:i];
        
        NSRange range = [calender rangeOfUnit:NSDayCalendarUnit
                         
                                       inUnit: NSMonthCalendarUnit
                         
                                      forDate: [calender dateFromComponents:comps]];
        
        count += range.length;
        
    }
    
    return  count;
}

//图片拉伸
+(UIImage *)stretchImage:(UIImage *)img edgeInsets:(UIEdgeInsets)inset
{
    if ([img respondsToSelector:@selector(resizableImageWithCapInsets:resizingMode:)]) {
        img = [img resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    }else if ([img respondsToSelector:@selector(resizableImageWithCapInsets:)]){
        img = [img resizableImageWithCapInsets:inset];
    }
    
    return img;
}


/**
 金额格式化，保留三位小数，且不四舍五入
// **/
//+(NSString *)moenyFormat:(double)number{
//    NSString *numberStr = [NSString stringWithFormat:@"%lf",number];
//    NSArray *numberArr = [numberStr componentsSeparatedByString:@"."];
//    NSString *retStr = [NSString stringWithFormat:@"%@.%@",numberArr[0],[numberArr[1] substringToIndex:3]];
//    return [F numberFormat:retStr];
//}

/**
 金额格式化，保留二位小数，且不四舍五入
 **/
//+(NSString *)moeny2Format:(double)number{
//    NSString *numberStr = [NSString stringWithFormat:@"%lf",number];
//    NSArray *numberArr = [numberStr componentsSeparatedByString:@"."];
//    NSString *retStr = [NSString stringWithFormat:@"%@.%@",numberArr[0],[numberArr[1] substringToIndex:2]];
//    return [F numberFormat:retStr];
//}

//数组，字典 转json
+(NSString *)dataTransferToJson:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}

/**
 UID以及服务器返回key存取
 **/
+ (void)setUid:(NSString *)uid avatar:(NSString *)avatar tokenId:(NSString *)tokenid userType:(NSString *)userType setUserName:(NSString *)userName setNickName:(NSString *)nickName
{
    [[NSUserDefaults standardUserDefaults]setObject:uid forKey:KEY_USERID];
    [[NSUserDefaults standardUserDefaults]setObject:avatar forKey:KEY_AVATAR];
    [[NSUserDefaults standardUserDefaults]setObject:tokenid forKey:KEY_TOKENID];
    [[NSUserDefaults standardUserDefaults]setObject:userType forKey:KEY_USERTYPE];
    [[NSUserDefaults standardUserDefaults]setObject:userName forKey:KEY_USERNAME];
    [[NSUserDefaults standardUserDefaults]setObject:nickName forKey:KEY_NICKNAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSDictionary *)getPersonDic
{
    return @{KEY_USERNAME:[self getUserName],KEY_USERID:[self getUid],KEY_AVATAR:@"http://pic26.nipic.com/20121213/10558908_210944907000_2.jpg",KEY_TOKENID:[self getTokenKey],KEY_USERTYPE:[self getUserType],KEY_NICKNAME:[[NSUserDefaults standardUserDefaults]objectForKey:KEY_NICKNAME]};
}

+(NSString *)getNickName
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:KEY_NICKNAME];
}

+(NSString *)getUserName
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:KEY_USERNAME];
}

+(NSString *)getUid
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:KEY_USERID];
}

+(NSString *)getTokenKey
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:KEY_TOKENID];
}

+(NSString *)getUserType
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:KEY_USERTYPE];
}

/**
 车市长存储
 **/
//+ (void)setCarUid:(NSString *)carUid carAvatar:(NSString *)carAvatar setCarUserName:(NSString *)carUserName setCarNickName:(NSString *)carNickName
//{
//    [[NSUserDefaults standardUserDefaults]setObject:carUid forKey:KEY_CAR_UID];
//    [[NSUserDefaults standardUserDefaults]setObject:carAvatar forKey:KEY_CAR_AVATOR];
//    [[NSUserDefaults standardUserDefaults]setObject:carUserName forKey:KEY_CAR_USERNAME];
//    [[NSUserDefaults standardUserDefaults]setObject:carNickName forKey:KEY_CAR_NICKNAME];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//+(NSDictionary *)getCarPersonDic
//{
//    return @{KEY_CAR_USERNAME:[[NSUserDefaults standardUserDefaults]objectForKey:KEY_CAR_USERNAME],KEY_CAR_UID:[[NSUserDefaults standardUserDefaults]objectForKey:KEY_CAR_UID],KEY_CAR_AVATOR:@"http://pic26.nipic.com/20121213/10558908_210944907000_2.jpg",KEY_CAR_NICKNAME:[[NSUserDefaults standardUserDefaults]objectForKey:KEY_CAR_NICKNAME]};
//}
//
//+(NSString*)getNamePinYingWithName:(NSString *)name{
//    if (0 == [name length]) {
//        return nil;
//    }
//    
//    HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
//    [outputFormat setToneType:ToneTypeWithoutTone];
//    [outputFormat setVCharType:VCharTypeWithV];
//    [outputFormat setCaseType:CaseTypeLowercase];
//    
//    NSString *strPinYin = [PinyinHelper toHanyuPinyinStringWithNSString:name withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
//    
//    return strPinYin;
//}


//记录选择了城市
+(NSString *)getMyCity
{
    return  [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"mycity%@",[AppUtils getUid]]];
}

//设置选择城市
+(void)setMyCity:(NSString *)city
{
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:[NSString stringWithFormat:@"mycity%@",[AppUtils getUid]]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//设置资料完善状态
+(void)setEditState:(NSString *)state
{
    [[NSUserDefaults standardUserDefaults] setObject:state forKey:[NSString stringWithFormat:@"editState%@",[AppUtils getUid]]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

//获取资料完善状态
+(NSString *)getEditState
{
    NSString *editState = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"editState%@",[AppUtils getUid]]];
    
    return editState;
}

//登录状态
+(void)setLoginState:(BOOL)islogin
{
    if (islogin) {
        [[NSUserDefaults standardUserDefaults]setObject:@YES forKey:KEY_ISLOGIN];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:@NO forKey:KEY_ISLOGIN];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)isLogin
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:KEY_ISLOGIN]) {
        return YES;
    }
    
    return NO;
}

//设置我的需求
+(void)setMyRequirement:(NSString *)requirement
{
    [[NSUserDefaults standardUserDefaults] setObject:requirement forKey:[NSString stringWithFormat:@"requirement%@",[AppUtils getUid]]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//记录我的需求
+(NSString *)getMyRequirement
{
    NSString *requirement = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"requirement%@",[AppUtils getUid]]];
    return requirement;
}

//获取数组最大的值
+(id)getMaxNum:(NSArray *)arr
{
    if (arr.count==0) {
        return @"";
    }
    
    id num = arr[0];
    
    for (int i=1; i<arr.count; i++) {
        if ([num floatValue]<[arr[i] floatValue]) {
            num = arr[i];
        }
    }
    
    return num;
}

//获取数组最小的值
+(id)getMinNum:(NSArray *)arr
{
    if (arr.count==0) {
        return @"";
    }
    
    id num = arr[0];
    
    for (int i=1; i<arr.count; i++) {
        if ([num floatValue]>[arr[i] floatValue]) {
            num = arr[i];
        }
    }
    
    return num;
}

@end
