//
//  Interface.h
//  MXUserSys
//
//  Created by 王启颖 on 2018/10/9.
//  Copyright © 2018年 王启颖. All rights reserved.
//

#ifndef Interface_h
#define Interface_h

//公寓@"http://192.168.3.2:8080/"
//腾讯云@"111.230.253.208:8085/"
//https://cb.uvogin.xyz/
//http://127.0.0.1:8085

#define Server_IP @"https://cb.uvogin.xyz/"

#define Formal_URL [NSString stringWithFormat:@"%@",Server_IP]

#define Img_URL @"http://cbimg.uvogin.xyz/"

//授权auth
#define user_login @"auth/user_login" //登录
#define user_signup @"auth/user_signup" //注册
#define user_changePassword @"auth/user_changePassword" //修改密码
#define updateuser_info @"auth/updateuser_info" //更新用户信息
#define user_info @"auth/user_info" //获取用户信息
#define user_complaint @"auth/user_complaint" //投诉

//qiniu
#define getUpToken @"qiniu/getUpToken" //七牛上传图片的上传凭证

//main 主页
#define sendMessage @"main/sendMessage" //发微博
#define getMessages @"main/getMessages" //获取微博
#define messageAgree @"main/messageAgree" //微博点赞
#define getMessageComments @"main/getMessageComments" //获取评论
#define sendMessageComments @"main/sendMessageComments" //发送评论



#endif /* Interface_h */
