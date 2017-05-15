//
//  RequestService.m
//  HomeworkHui
//
//  Created by lingnet on 2017/5/15.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "RequestService.h"

@implementation RequestService
/**
 登录
 
 @param phoneNum 手机号
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postLoginWithUsername:(NSString*)phoneNum AndDevType:(NSString*)devType complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = @"http://139.196.213.209:8180/app/user!login.action";
    NSDictionary* param = @{@"account":phoneNum,@"devType":devType};
    
    [EZHHttpClenit postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}

@end
