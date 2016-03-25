//
//  APIConfig.h
//  p2p
//  HTTP API 配置
//  Created by mokai on 14-10-14.
//  Copyright (c) 2014年 cloudyoo. All rights reserved.
//

/**
 nothing
 **/

/***
 ==============
 接口配置
 ==============
 ***/
 

#ifndef p2p_APIConfig_h
#define p2p_APIConfig_h

#define api_getcode                 @"/common/login/ClientRegisterService.hoyip?behavior=getregistercode"       //获取注册或找回密码验证码
#define api_login                   @"/common/unvalidate/UnvalidateService.hoyip?behavior=loging"                               //登录接口
#define api_forgetpwd               @"/common/login/AlterPwdService.hoyip?behavior=retrievepwd"                            //忘记密码
#define api_logout                  @"/common/login/LoginService.hoyip?behavior=logout"                              //退出接口
#define api_customerRegister        @"/common/login/ClientRegisterService.hoyip?behavior=clientreg"                          //客户端注册
#define api_modifypwd               @"/common/login/AlterPwdService.hoyip?behavior=alterpwd"   //修改密码


#define api_updatacity              @"/common/location/LocationInfoService.hoyip?behavior=upcity"  //上传城市
#define api_getcity                 @"/common/location/LocationInfoService.hoyip?behavior=downcity"//获取城市

#define getnearmeminfo              @"/common/userinfo/MemberInfoService.hoyip?behavior=nearmeminfo"         //团友信息

#define api_getcarlist              @"/common/userlist/UserListService.hoyip?behavior=nearbrandlist"  //客户端  获取车品牌
#define api_getproductlist          @"/common/productlist/ProductListService.hoyip?behavior=productlist"  //产品列表-客户端
#define api_getnearsellerlist       @"/common/userlist/UserListService.hoyip?behavior=nearmerchantlist"  //附近销售指定品牌的经销商列表(客户端)
#define api_getnearmatesamebrandlist @"/common/userlist/UserListService.hoyip?behavior=nearfrilist" //附近具有相同需求品牌的好友列表(客户端)
#define api_getnearmatelist         @"/common/userlist/UserListService.hoyip?behavior=getuserreqlist"    //附近具有相同需求的好友（客户端）

#define api_getproductdetail        @"/common/productlist/ProductListService.hoyip?behavior=productdetail"//产品详情
#define api_getproductprice         @"/common/productlist/ProductListService.hoyip?behavior=productprice"  //价格指数
#define api_getproductparams        @"/common/productlist/ProductListService.hoyip?behavior=productparams"//产品参数
#define api_getproductcomment       @"/common/productlist/ProductListService.hoyip?behavior=productcomment"//产品评论列表
#define api_getsellerdetail         @"/common/merchant/Merchant.hoyip?behavior=merchantbaseinfo"//商铺详情头部
#define api_getsellerdetailbody     @"/common/merchant/Merchant.hoyip?behavior=merimgrange"//商铺详情尾部

#define getmerchantlist             @"/common/merchant/Merchant.hoyip?behavior=getmerchantlist"        //商户完善资料-车品牌列表/保养类型列表/车险列表

#define merchantInfoUpload          @"/common/merchant/Merchant.hoyip?behavior=finishmerreg"           //商户端完善资料
#define merchantVerifyMerreg        @"/common/merchant/Merchant.hoyip?behavior=verifymerreg"           //商户资料是否审核通过

#define api_addFriend               @"/common/userlist/ContactService.hoyip?behavior=addfriend"              //添加好友

#define api_deleteFriend            @"/common/userlist/ContactService.hoyip?behavior=delfriend"              //删除好友

#define api_getFriendList           @"/common/userlist/ContactService.hoyip?behavior=getfriendlist"          //好友列表

#define api_publish_textreqpro      @"/common/message/PublicMesService.hoyip?behavior=textreqpro"             //发布促销/需求

#define api_show_messinfo_list      @"/common/message/PublicMesService.hoyip?behavior=showreqpro"             //需求/活动列表


#define uploadMylocation            @"/common/location/LocationInfoService.hoyip?behavior=uplocainfo"            //上传地址

#define api_addShopCart             @"/common/shopping/Shopcar.hoyip?behavior=addtoshopcar"          //加入购物车

#define api_delete_shopCart         @"/common/shopping/Shopcar.hoyip?behavior=delgoodshopcar"        //删除购物车

#define api_shopCartList            @"/common/shopping/Shopcar.hoyip?behavior=turntoshopcar"         //购物车列表

#define api_upload_imgs             @"/common/other/UploadImage.hoyip?behavior=uploadimage"             //上传图片
                                      
#define api_modify_avator           @"/common/other/Setting.hoyip?behavior=modifyavator"           //上传头像

#define api_generate_order          @"/common/shopping/Order.hoyip?behavior=generateorder"            //生成订单

#define api_AlipayRequest           @"/common/alipay/AlipayRequest.hoyip?behavior=alipayrequest"       //获取支付链接

#define api_get_my_order            @"/common/shopping/Order.hoyip?behavior=getorderlist"             //我的订单

#define api_delete_order            @"/common/shopping/Order.hoyip?behavior=delorder"                 //删除未支付订单

#define api_generate_book           @"/common/shopping/Book.hoyip?behavior=generatebook"              //生成预约清单

#define api_confirm_book            @"/common/shopping/Book.hoyip?behavior=confirmbook"               //确认预约

#define api_comment_prodcut         @"/common/shopping/Order.hoyip?behavior=commenting"               //评论接口

#define api_getbooklist             @"/common/shopping/Book.hoyip?behavior=getbooklist"               //获取预约清单

#define api_getbookdetail           @"/common/shopping/Book.hoyip?behavior=getbookdetail"             //预约详情

#define api_cancelbook              @"/common/shopping/Book.hoyip?behavior=cancelbook"                //取消预约

#define api_upfeedback              @"/common/other/FeedbackService.hoyip?behavior=upfeedback"            //意见反馈

#define api_modifyrequirement       @"/common/other/Setting.hoyip?behavior=modifyrequirement"      //修改需求

#define api_ismemeber               @"/common/other/Other.hoyip?behavior=ismember"                 //商户是否会员

#define api_searchbrand             @"/common/other/Other.hoyip?behavior=searchbrandlist"          //搜索品牌

#define api_add_shareTime           @"/common/message/PublicMesService.hoyip?behavior=addsharetime"   //增加分享


#endif