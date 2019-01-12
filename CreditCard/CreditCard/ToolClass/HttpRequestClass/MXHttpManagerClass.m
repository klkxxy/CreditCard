//
//  PCChatHttpManagerClass.m
//  MXUserSys
//
//  Created by MXUserSys on 2018/6/18.
//  Copyright © 2018年 MXUserSys. All rights reserved.
#import "MXHttpManagerClass.h"
#import "AppDelegate.h"
@implementation MXHttpManagerClass

-(instancetype)init{
    return [MXHttpManagerClass manager];
}
+(instancetype)HttpRequstManager{
    MXHttpManagerClass *manager = [MXHttpManagerClass manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",nil];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:app_Version forHTTPHeaderField:@"X-HTTP-APPVERSION"];
    [manager.requestSerializer setValue:CHANNEL forHTTPHeaderField:@"X-HTTP-APPCHANNEL"];
    
    [[MXAccount sharedMXAccount] LoadTokenFromSandbox];
    NSString *token = [MXAccount sharedMXAccount].token;
    
    if([token length] > 0){
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    }
    
    manager.requestSerializer.timeoutInterval = 10.0f;
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    
    return manager;
}


-(void)PostURL:(NSString *)appendURl
                        params:(NSDictionary *)params
                isHearderparam:(BOOL )isHearderparam
                       success:(publickModelsSuccessBlock)sucess
                          fail:(publickModelsPostFileFail)fail{
    
//    if (isHearderparam) {
//        [[PCChatAccount sharedPCChatAccount] LoadUserTokenFromSandbox];
//        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//        [dict addEntriesFromDictionary:params];
//        dict[@"token"] = [PCChatAccount sharedPCChatAccount].token;
//        params = dict;
//    }
//    [[PCChatAccount sharedPCChatAccount] LoadUserTypeFromSandbox];
//    [[PCChatAccount sharedPCChatAccount] LoadLastUserNumberFromSandbox];
//
    NSString *url = nil;
    url = [NSString stringWithFormat:@"%@%@",Formal_URL,appendURl];
    
 
    [self POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",url);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSError *jsonError;
//        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//        id result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&jsonError];
        NSInteger statusNum = [responseObject[@"result"] integerValue];
        if (statusNum == 401 || statusNum == 402) {
//            [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error)
//             {
//                 [PCChatUserMessageTool clearMessgae];
//                 extern NSString *NTESNotificationLogout;
//                 [[NSNotificationCenter defaultCenter] postNotificationName:NTESNotificationLogout object:nil];
//             }];
            
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            return;
        }
        if (sucess) {
            sucess(statusNum, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络错误，请检查网络"];
        NSLog(@"网络错误地址=%@",appendURl);
        if (fail) {
            fail(error);
        }
    }];
}



@end
