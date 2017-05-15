//
//  RequestService.h
//  HomeworkHui
//
//  Created by lingnet on 2017/5/15.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestService : NSObject

/**
 登录

 @param phoneNum 手机号
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postLoginWithUsername:(NSString*)phoneNum AndDevType:(NSString*)devType complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;
@end
