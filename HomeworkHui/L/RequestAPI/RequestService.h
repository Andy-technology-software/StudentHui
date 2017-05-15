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


/**
 获取首页接龙任务列表

 @param studentId 学生id
 @param classId 班级id
 @param complate 完成请求
 @param failure 请求失败
 */
+(void)postTasklistWithStudentId:(NSString*)studentId AndClassId:(NSString*)classId complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;


/**
 任务详情
 
 @param taskId 任务id
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postTaskdetailWithTaskId:(NSString*)taskId complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure;
@end
