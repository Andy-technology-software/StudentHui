//
//  SolitaireDetailModel.h
//  HomeworkHui
//
//  Created by lingnet on 2017/5/5.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SolitaireDetailModel : NSObject
@property(nonatomic,copy)NSString* xuhao;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* time;
@property(nonatomic,copy)NSString* beizhu;

@property (nonatomic, assign) int uid;
@property (nonatomic, assign) BOOL isExpand;
@end
