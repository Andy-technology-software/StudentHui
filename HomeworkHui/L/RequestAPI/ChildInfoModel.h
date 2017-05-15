//
//  ChildInfoModel.h
//  HomeworkHui
//
//  Created by lingnet on 2017/5/15.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChildInfoModel : NSObject<NSCoding>
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* id;
@property(nonatomic,copy)NSString* className;
@property(nonatomic,copy)NSString* classId;
@property(nonatomic,copy)NSString* gradeId;
@property(nonatomic,copy)NSString* gradeName;
@property(nonatomic,copy)NSString* schoolName;

@end
