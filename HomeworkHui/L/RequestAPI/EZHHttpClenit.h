//
//  EZHHttpClenit.h
//  E展汇
//
//  Created by 吴嘉佳 on 2017/2/23.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NSURLErrorFailingURLStringErrorKey @"NSURLErrorFailingURLStringErrorKey" // error userInfo 错误信息key

typedef void (^HttpSuccessBlock)(id responseObject);
typedef void (^HttpFailureBlock)(NSError *error);
@interface EZHHttpClenit : NSObject
/**
 *  发送一个POST请求
 *
 *  @param urlString   请求路径
 *  @param params      请求参数
 *  @param success     请求成功后的回调
 *  @param failure     请求失败后的回调
 */
+(void)postWithURLString:(NSString *)urlString params:(NSDictionary *)params  WithSuccess:(HttpSuccessBlock)success WithFailure:(HttpFailureBlock)failure;

/**
 *  发送一个GET请求
 *
 *  @param urlString   请求路径
 *  @param params      请求参数
 *  @param success     请求成功后的回调
 *  @param failure     请求失败后的回调
 */
+(void)getWithURLString:(NSString *)urlString params:(NSDictionary *)params WithSuccess:(HttpSuccessBlock)success WithFailure:(HttpFailureBlock)failure;

/**
 *  发送一个POST请求
 *
 *  @param urlString   请求路径
 *  @param params      请求参数
 *  @param success     请求成功后的回调
 *  @param failure     请求失败后的回调
 */
+(void)postWithOldURLString:(NSString *)urlString params:(NSDictionary *)params  WithSuccess:(HttpSuccessBlock)success WithFailure:(HttpFailureBlock)failure;


/**
 检测网络状态
 */
+ (void)netWorkStatus;

@end
