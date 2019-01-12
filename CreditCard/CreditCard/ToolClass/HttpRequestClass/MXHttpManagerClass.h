//
//  PCChatHttpManagerClass.h
//  MXUserSys

#import <AFNetworking/AFNetworking.h>

@interface MXHttpManagerClass : AFHTTPSessionManager

+(instancetype )HttpRequstManager;
typedef void (^publickModelsPostFileFail)(NSError *error);
typedef void(^publickModelsSuccessBlock)(NSInteger code,id result);
typedef void(^SucessBlock)(id result);
typedef void(^publickModelsFailBlock)(NSError *error);

-(void)PostURL:(NSString *)appendURl
        params:(NSDictionary *)params
    isHearderparam:(BOOL )isHearderparam
       success:(publickModelsSuccessBlock)sucess
          fail:(publickModelsPostFileFail)fail;

@end
