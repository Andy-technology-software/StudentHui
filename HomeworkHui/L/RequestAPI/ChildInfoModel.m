//
//  ChildInfoModel.m
//  HomeworkHui
//
//  Created by lingnet on 2017/5/15.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "ChildInfoModel.h"

@implementation ChildInfoModel
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.className forKey:@"className"];
    [aCoder encodeObject:self.classId forKey:@"classId"];
    [aCoder encodeObject:self.gradeId forKey:@"gradeId"];
    [aCoder encodeObject:self.gradeName forKey:@"gradeName"];
    [aCoder encodeObject:self.schoolName forKey:@"schoolName"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.className = [aDecoder decodeObjectForKey:@"className"];
        self.classId = [aDecoder decodeObjectForKey:@"classId"];
        self.gradeId = [aDecoder decodeObjectForKey:@"gradeId"];
        self.gradeName = [aDecoder decodeObjectForKey:@"gradeName"];
        self.schoolName = [aDecoder decodeObjectForKey:@"schoolName"];
    }
    return self;
}
@end
