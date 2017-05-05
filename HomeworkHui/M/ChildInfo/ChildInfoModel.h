//
//  ChildInfoModel.h
//  HomeworkHui
//
//  Created by lingnet on 2017/5/5.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChildInfoModel : NSObject
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* classNum;
@property (nonatomic, assign) BOOL isCurrnet;

@property (nonatomic, assign) int uid;
@property (nonatomic, assign) BOOL isExpand;
@end
