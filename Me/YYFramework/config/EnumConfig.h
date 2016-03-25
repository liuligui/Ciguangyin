//
//  EnumConfig.h
//  p2p
//
//  Created by mokai on 14-10-14.
//  Copyright (c) 2014年 cloudyoo. All rights reserved.
//


#ifndef p2p_EnumConfig_h
#define p2p_EnumConfig_h


typedef NS_ENUM (NSUInteger, Cell_Type){
    CELL_TYPE_PART = 1,//cell宽度占局部
    CELL_TYPE_ALL = 2,//cell宽度占满
};

//segment 类型
typedef NS_ENUM (NSUInteger, YYSegmentType){
    SEGMENT_TYPE_NORMAL = 1,//首页
    SEGMENT_TYPE_WHITE = 2,//白色
};

typedef NS_ENUM (NSUInteger, ValicodeType){
    VALICODETYPE_REGISTER = 1,//注册
    VALICODETYPE_FORGET = 2,//忘记密码
};

typedef NS_ENUM (NSUInteger, requirementType){
    REQUIREMENTTYPE_BUYCAR = 0,//买车
    REQUIREMENTTYPE_MAINTAIN = 1,//保养
    REQUIREMENTTYPE_INSURANCE = 2,//保险
    REQUIREMENTTYPE_NONE = 3      //商户需求
};

typedef NS_ENUM (NSUInteger, productType){
    PRODUCTTYPE_BUYCAR = 0,//买车
    PRODUCTTYPE_INSURANCE= 1,//保险
    PRODUCTTYPE_MAINTAIN = 2,//保养
};

//资料编辑状态
typedef NS_ENUM (NSInteger, infoEditType){
    INFO_EDIT_SUCESS = 1,//审核通过
    INFO_EDIT_WAITING= -1,//待审核
    INFO_EDIT_FAIL = -2,//审核失败
    INFO_EDIT_NOT_UPLOAD = -3//未提交审核资料
};

//用户类型
typedef NS_ENUM(NSUInteger, userType){
    USER_TYPE_CUSTOMER = 1,//普通用户
    USER_TYPE_SELLER = 2,//商户
    USER_TYPE_CSZ  = 3, //车市长
    USER_TYPE_VIP_SELLER = 4,//会员商户
};

typedef NS_ENUM(NSUInteger, NearMateType){
    NEAR_MATE_TYPE_ALL = 1,
    NEAR_MATE_TYPE_BUYCAR = 2,
    NEAR_MATE_TYPE_INSURANCE = 3,
    NEAR_MATE_TYPE_MAINTAIN = 4,
};

typedef NS_ENUM(NSUInteger, NearListType){
    NEAR_LIST_TYPE_SELLER = 0,//商户
    NEAR_LIST_TYPE_CUSTOMER = 1,//团友
};

typedef NS_ENUM(NSUInteger, PublishType){
    PUBLISHTYPE_REQUIREMENT = 0,//需求
    PUBLISHTYPE_ACTIVITY = 1    //活动
};

//实际订单状态
typedef NS_ENUM(NSUInteger, OrderState){
    ORDER_STATE_WATING_PAY = 0, //待付款     （客户端：待付款按钮，删除按钮，商户端：无）
    ORDER_STATE_PAYED = 1,      //已付款未预约 （客户端：预约按钮，商户端：无）
    ORDER_STATE_SEND_APPOINT = 2, //已发送预约  预约中 （客户端：无，商户端：确认预约按钮可点击）
    ORDER_STATE_CONFIRM_APPOINT = 3, //确认预约 确认预约 （客户端：无，商户端：确认预约按钮灰色不可点击）
    ORDER_STATE_SUCCESS_APPOINT = 4, //约见成功 约见成功   （无）
    ORDER_STATE_SUCCESS_EXPIRED = 5, //约见过期 约见过期   （无）
};

//我的订单状态
typedef NS_ENUM(NSUInteger, MyOrderState){
   MYORDER_STATE_WATING= 0, //待付款 已付款待预约
   MYORDER_STATE_GOING = 1, //进行中
   MYORDER_STATE_FINISH = 2, //完成中
   MYORDER_STATE_OTHER = 3  //不属于订单状态，只是为了控件复用
};

//预约清单状态
typedef NS_ENUM(NSUInteger, MyBookState){
    MYBOOK_STATE_SEND = 0, //约见中
    MYBOOK_STATE_CONFRIM = 1, //已确认
    MYBOOK_STATE_SUCCESS = 2, //约见成功
    MYBOOK_STATE_EXPIRED = 3 //约见过期
};

//购物来源
typedef NS_ENUM(NSInteger, BuyType){
    BUY_TYPE_CART = 0, //购物车入口
    BUY_TYPE_NOCART = 1 //直接购买
};

#endif
