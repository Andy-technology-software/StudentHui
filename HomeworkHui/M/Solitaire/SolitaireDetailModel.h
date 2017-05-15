//
//  SolitaireDetailModel.h
//  HomeworkHui
//
//  Created by lingnet on 2017/5/5.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SolitaireDetailModel : NSObject
@property (nonatomic, assign) BOOL isSelf;

@property (nonatomic, assign) int uid;
@property (nonatomic, assign) BOOL isExpand;

@property(nonatomic,copy)NSString* id;
@property(nonatomic,copy)NSString* sName;
@property(nonatomic,copy)NSString* sID;
@property(nonatomic,copy)NSString* pName;
@property(nonatomic,copy)NSString* pID;
@property(nonatomic,copy)NSString* recordText;
@property(nonatomic,copy)NSString* recordTime;
@end
