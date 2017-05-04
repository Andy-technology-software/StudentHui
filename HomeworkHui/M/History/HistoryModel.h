//
//  HistoryModel.h
//  HomeworkHui
//
//  Created by 徐仁强 on 2017/5/4.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryModel : NSObject
@property(nonatomic,copy)NSString* title;
@property(nonatomic,copy)NSString* beizhu;
@property(nonatomic,copy)NSString* time;
@property (nonatomic, assign) int uid;
@property (nonatomic, assign) BOOL isExpand;
@end
