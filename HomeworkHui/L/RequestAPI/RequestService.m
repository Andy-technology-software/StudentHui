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

/**
 获取首页接龙任务列表
 
 @param studentId 学生id
 @param classId 班级id
 @param complate 完成请求
 @param failure 请求失败
 */
+(void)postTasklistWithStudentId:(NSString*)studentId AndClassId:(NSString*)classId complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = @"http://139.196.213.209:8180/app/task!getTaskList.action";
    NSDictionary* param = @{@"studentId":studentId,@"classId":classId};
    
    [EZHHttpClenit postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}


/**
 任务详情

 @param taskId 任务id
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postTaskdetailWithTaskId:(NSString*)taskId complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = @"http://139.196.213.209:8180/app/task!getTaskDetail.action";
    NSDictionary* param = @{@"taskId":taskId};
    
    [EZHHttpClenit postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}
@end
