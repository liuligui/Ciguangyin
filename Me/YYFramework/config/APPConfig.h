//
//  APPConfig.h
//  p2p
//
//  Created by mokai on 14-10-14.
//  Copyright (c) 2014年 cloudyoo. All rights reserved.
//

/***
 ==============
 应用配置
 ==============
 ***/

#ifndef p2p_APPConfig_h
#define p2p_APPConfig_h

//APP配置目录
#define APP_CONFIG_PATH @"app_config.plist"

//环信key
#define EASE_APPKEY @"kuaifish511#csz"
#define EASE_APNSCERNAME @"cszdevP12"

//scheme 在AlixPayDemo-Info.plist定义URL types
#define KEY_AppScheme  @"carMayor"


//友盟key
#define UMENG_APPKEY @"5594efaa67e58e8b23001276"
#define APP_KEY_WEIXIN    @"wx1cbc3966c08272b6"
#define APP_KEY_WEINXIN_APPSECRET @"bda7b382125a9fac0837764086c020c5"
#define APP_KEY_TENCENTQQ  @""//qqKEY

//===============主机列表=================
//#define APP_HOST_ADDRESS @"http://diancan.figo.cn"http://120.24.212.127/carmayor-web
#define APP_HOST_ADDRESS @"http://120.24.212.127/carmayor"
//#define APP_HOST_ADDRESS @"http://192.168.0.13:8081/carmayor-web"
//#define APP_HOST_ADDRESS @"http://192.168.0.13:8080/carmayor-web"

#define APP_HOST [NSString stringWithFormat:@"%@",APP_HOST_ADDRESS]      //服务器地址


//图片参数
#define SMALL_IMAGE_WIDTH_CHAT       198
#define SMALL_IMAGE_HEIGHT_CHAT      198
#define BIG_IMAGE_WIDTH              640
#define BIG_IMAGE_HEIGHT_40          1136
#define BIG_IMAGE_HEIGHT_35          960
#define BIG_IMAGE_WIDTH_40           1136
#define BIG_IMAGE_WIDTH_35           960
#define BIG_IMAGE_VERTIACL_WIDTH     640
#define BIG_IMAGE_VERTIACL_HEIGHT_40 1136
#define BIG_IMAGE_VERTIACL_HEIGHT_35 960
#define PIC_BYTES                    102400.0//图片数据系数 100kb

//手机验证码重发时长
#define VCODE_TIME                    60
//图片轮播时间
#define SWITCH_FOCUS_PICTURE_INTERVAL 3.0
//设置手势密码开启时间(秒)
#define GESTUREOPENTIME               300

//http超时时间
#define TIME_OUT_SECOND               10.0
#define IMG_UPLOAD_TIME_OUT_SECOND    60.0
//http状态码
#define     STATUS_CODE_ERROR   100
#define     STATUS_CODE_SUCCESS 1


//密码位数
#define MAX_LEN_OF_PWD                16
#define MIN_LEN_OF_PWD                6
//昵称位数
#define MAX_LEN_OF_NICK               10
#define MIN_LEN_OF_NICK                3
//开始从网络加载内容条数
#define LOAD_NUM_FORM_NETWORK       @"-10"


/***
 ==============
 配置key相关
 ==============
 ***/
//当前主题
#define APPConfigKeyCurrentTheme        @"APPConfigKeyCurrentTheme"
//网络状态
#define APPConfigKeyNetworkStatus        @"APPConfigKeyNetworkStatus"

//返回码
#define NO_NETWORK_STATUS               @"997"
#define ERROR_TIME_OUT_STATUS           @"998"

#define ERROR_STATUS                    @"-991"   //超时或者被别人逼退后的提示码

//错误提示
#define NO_NETWORK                  @"网络异常，请检查网络状况"
#define ERROR_TIME_OUT              @"连接超时，请稍后再试。"

#define ERROR_MSG_SERVICE           @"登录超时，请重新登录"



#endif
