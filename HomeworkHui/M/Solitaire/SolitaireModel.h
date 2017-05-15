//
//  SolitaireModel.h
//  HomeworkHui
//
//  Created by 徐仁强 on 2017/5/4.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SolitaireModel : NSObject
@property(nonatomic,copy)NSString* title;
@property(nonatomic,copy)NSString* beizhu;
@property(nonatomic,copy)NSString* pnum;
@property(nonatomic,copy)NSString* time;
@property (nonatomic, assign) BOOL isSend;
@property (nonatomic, assign) BOOL isNew;

@property (nonatomic, assign) int uid;
@property (nonatomic, assign) BOOL isExpand;


@property(nonatomic,copy)NSString* taskId;
@property(nonatomic,copy)NSString* isComplete;
@property(nonatomic,copy)NSString* textHint;
@property(nonatomic,copy)NSString* desc;
@property(nonatomic,copy)NSString* count;
@property(nonatomic,copy)NSString* remark;
@property(nonatomic,copy)NSString* textFlag;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* beginTime;
@property(nonatomic,copy)NSString* endTime;
@property(nonatomic,copy)NSString* taskName;

@end
