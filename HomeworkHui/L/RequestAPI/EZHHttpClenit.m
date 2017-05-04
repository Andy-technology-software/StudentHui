//
//  EZHHttpClenit.m
//  E展汇
//
//  Created by 吴嘉佳 on 2017/2/23.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "EZHHttpClenit.h"

@implementation EZHHttpClenit
/**
 *  发送一个POST请求
 *
 *  @param urlString   请求路径
 *  @param params      请求参数
 *  @param errorDomain 错误 api
 *  @param errorString 错误请求的说明
 *  @param success     请求成功后的回调
 *  @param failure     请求失败后的回调
 */
+(void)postWithURLString:(NSString *)urlString params:(NSDictionary *)params  WithSuccess:(HttpSuccessBlock)success WithFailure:(HttpFailureBlock)failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    // 设置请求超时
    manager.requestSerializer.timeoutInterval = 30;
    
    
    [manager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if ([responseObject[@"statusCode"] isEqualToString:@"200"]) {
                !success?:success(responseObject);
            }else{
                NSString *errorDomainValue = @"RequestError";
                NSError *error = [NSError errorWithDomain:errorDomainValue code:[responseObject[@"statusCode"]intValue] userInfo:@{NSURLErrorFailingURLStringErrorKey:[MyController returnStr:responseObject[@"msg"]]}];
                !failure?:failure(error);
            }
            
        }
        else{
            NSString *errorDomainValue = @"RequestError";
            NSError *error = [NSError errorWithDomain:errorDomainValue code:-999 userInfo:@{NSURLErrorFailingURLStringErrorKey:@"返回的数据不是json"}];
            !failure?:failure(error);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        !failure?:failure(error);
    }];
}

/**
 *  发送一个POST请求
 *
 *  @param urlString   请求路径
 *  @param params      请求参数
 *  @param success     请求成功后的回调
 *  @param failure     请求失败后的回调
 */
+(void)postWithOldURLString:(NSString *)urlString params:(NSDictionary *)params  WithSuccess:(HttpSuccessBlock)success WithFailure:(HttpFailureBlock)failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    // 设置请求超时
    manager.requestSerializer.timeoutInterval = 30;
    
    [manager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"result"] intValue]) {
            !success?:success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        !failure?:failure(error);
    }];
}

/**
 *  发送一个GET请求
 *
 *  @param params      请求参数
 *  @param success     请求成功后的回调
 *  @param failure     请求失败后的回调
 */
+(void)getWithURLString:(NSString *)urlString params:(NSDictionary *)params WithSuccess:(HttpSuccessBlock)success WithFailure:(HttpFailureBlock)failure{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    // 1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    manager.requestSerializer.timeoutInterval = 30;
    
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                 if ([responseObject[@"statusCode"] isEqualToString:@"200"]) {
                     !success?:success(responseObject);
                 }else{
                     NSString *errorDomainValue = @"RequestError";
                     NSError *error = [NSError errorWithDomain:errorDomainValue code:[responseObject[@"statusCode"]intValue] userInfo:@{NSURLErrorFailingURLStringErrorKey:[MyController returnStr:responseObject[@"msg"]]}];
                     !failure?:failure(error);
                 }
                 
             }
             else{
                 NSString *errorDomainValue = @"RequestError";
                 NSError *error = [NSError errorWithDomain:errorDomainValue code:-999 userInfo:@{NSURLErrorFailingURLStringErrorKey:@"返回的数据不是json"}];
                 !failure?:failure(error);
             }
             
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
             !failure?:failure(error);
             
         }];
    
}


/**
 检测网络状态
 */
+ (void)netWorkStatus{
    /**
     *  AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     *  AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     *  AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     *  AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络Wifi
     */
    // 如果要检测网络状态的变化, 必须要用检测管理器的单例startMoitoring
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status == AFNetworkReachabilityStatusNotReachable){
            //            [UIView showAlertMsg:@"网络连接已断开，请检查您的网络！"];
            
            return ;
        }
    }];
    
}

@end
