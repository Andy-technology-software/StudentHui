//
//  HistoryTableViewCell.h
//  HomeworkHui
//
//  Created by 徐仁强 on 2017/5/4.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HistoryModel;
@interface HistoryTableViewCell : UITableViewCell
- (void)configCellWithModel:(HistoryModel *)model;

@end
