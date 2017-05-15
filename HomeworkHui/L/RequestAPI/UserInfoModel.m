//
//  UserInfoModel.m
//  HomeworkHui
//
//  Created by lingnet on 2017/5/15.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.devType forKey:@"devType"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
    [aCoder encodeObject:self.account forKey:@"account"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.telNo forKey:@"telNo"];
    [aCoder encodeObject:self.userType forKey:@"userType"];
    [aCoder encodeObject:self.loginTime forKey:@"loginTime"];
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.createDate forKey:@"createDate"];
    [aCoder encodeObject:self.modifyDate forKey:@"modifyDate"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.devType = [aDecoder decodeObjectForKey:@"devType"];
        self.remark = [aDecoder decodeObjectForKey:@"remark"];
        self.account = [aDecoder decodeObjectForKey:@"account"];
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        self.telNo = [aDecoder decodeObjectForKey:@"telNo"];
        self.userType = [aDecoder decodeObjectForKey:@"userType"];
        self.loginTime = [aDecoder decodeObjectForKey:@"loginTime"];
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.createDate = [aDecoder decodeObjectForKey:@"createDate"];
        self.modifyDate = [aDecoder decodeObjectForKey:@"modifyDate"];
    }
    return self;
}
@end
