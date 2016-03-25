//
//  DataUtils.h
//  advideo
//
//  Created by LiuHe@MacMini on 14-7-15.
//  Copyright (c) 2014年 cloudyoo. All rights reserved.
//

/***
 ==============
 接口字段配置
 ==============
 ***/

#ifndef p2p_DataUtils_h
#define p2p_DataUtils_h

//返回信息
#define KEY_STATUS_CODE @"status"
#define KEY_MSG         @"msg"
#define KEY_DATA        @"data"      //返回数据
#define KEY_USERID      @"userid"
#define KEY_ROLE_ID      @"roleid"



/**** 接口相关字段  ****/

#define KEY_PHONE      @"phone"    //手机号码
#define KEY_CODE        @"verifycode"      //验证码
#define KEY_TOKENID       @"tokenid"       //服务器返回KEY
#define KEY_AVATAR      @"avatar"

#define KEY_USERNAME    @"username"  //用户名
#define KEY_NICKNAME    @"nickname"  //昵称

#define KEY_USERTYPE    @"usertype"  //用户类型
#define KEY_REQUIREMENTTYPE   @"requirementtype"//用户需求类型
#define KEY_PASSWORD    @"password"  //密码
#define KEY_NICKNAME    @"nickname"  //昵称
#define KEY_CITY        @"city"      //城市

#define KEY_CAR_USERNAME @"carusername" //车市长用户名
#define KEY_CAR_NICKNAME @"carnickname" //车市长昵称
#define KEY_CAR_AVATOR   @"caravator" //车市长头像
#define KEY_CAR_UID      @"caruserid" //车市长编号


#define KEY_CITYPINY    @"citypiny" //城市拼音首字母(小写)

#define KEY_PRODUCTTYPE @"producttype"

#define KEY_TYPE         @"type"     //类型
#define KEY_STARTID      @"startid"
#define KEY_OFFSET       @"offset"
#define KEY_PRODUCT_ID    @"productid" //产品id
#define KEY_BRAND_ID      @"brandid" //车品牌id


#define KEY_DISTRNAME           @"distributorname"
#define KEY_DISTRID             @"distributorid"

//位置信息
#define KEY_LONGTITUDE          @"longtitude"
#define KEY_LATITUDE            @"latitude"
#define KEY_ADDRESS             @"address"

//
#define KEY_MEMBERID            @"memberid"
#define KEY_REQUIREMENT        @"requirement"  //客户需求

//产品
#define KEY_PRODUCTID           @"productid"
#define KEY_SELLER_ID           @"distributorid"//经销商编号
#define KEY_INTENTION           @"intention"    //意向金
#define KEY_PRODUCT_NAME        @"productname"  //产品名称




//车品牌
#define KEY_BATCHID      @"batchid"
#define KEY_BATCHNAME    @"batchname"
#define KEY_BATCHIMG     @"iurl"

//车保险
#define KEY_INSURANCEID         @"insurancetypeid"
#define KEY_INSURANCETYPENAME   @"insurancetypename"
#define KEY_INSURANCETYPEIMG    @"insurancetypeiurl"

//车保养
#define KEY_MANTANCEID          @"mantancetypeid"
#define KEY_MANTANCETYPENAME    @"mantancetypename"
#define KEY_MANTANCETYPEIMG     @"mantancetypeiurl"

//位置信息
#define KEY_LONGTITUDE          @"longtitude"
#define KEY_LATITUDE            @"latitude"
#define KEY_ADDRESS             @"address"


//发布
#define KEY_TITLE               @"title"
#define KEY_CONTENT             @"content"
#define KEY_IURL                @"iurl"



#define KEY_ORDER_NUM           @"ordernum"
#define KEY_ORDERID             @"orderid"


//消费记录


/**** web ****/
#define KEY_WEB_URL                                 @"weburl"       //网页地址
#define KEY_WEB_TITLE                               @"webtitle"     //网页标题
#define KEY_WEB_POST_INFO                           @"webPostInfo"  //post内容
#define KEY_WEBFLAG                                 @"isWeb"        //web标示

/** 本地参数**/
#define KEY_ISLOGIN    @"islogin"



#define KEY_INTO_CART @"intocart"


#endif
