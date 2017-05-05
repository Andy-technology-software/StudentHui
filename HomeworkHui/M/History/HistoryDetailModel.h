//
//  HistoryDetailModel.h
//  HomeworkHui
//
//  Created by lingnet on 2017/5/5.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryDetailModel : NSObject
@property(nonatomic,copy)NSString* title;
@property(nonatomic,copy)NSString* beizhu;
@property(nonatomic,copy)NSString* pnum;
@property(nonatomic,copy)NSString* time;
//@property (nonatomic, assign) BOOL isSend;
//@property (nonatomic, assign) BOOL isNew;

@property (nonatomic, assign) int uid;
@property (nonatomic, assign) BOOL isExpand;
@end
