//
//  HistoryTableViewCell.m
//  HomeworkHui
//
//  Created by 徐仁强 on 2017/5/4.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "HistoryTableViewCell.h"

#import "HistoryModel.h"
@interface HistoryTableViewCell()
@property(nonatomic,strong)UILabel* titleLable;
@property(nonatomic,strong)UILabel* beizhuLable;
@property(nonatomic,strong)UILabel* timeLable;
@property(nonatomic,strong)UIView* lineView;

@end
@implementation HistoryTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.titleLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLable];
    self.titleLable.numberOfLines = 0;
    self.titleLable.font = [UIFont systemFontOfSize:16];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-10);
    }];
    
    self.beizhuLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.beizhuLable];
    self.beizhuLable.textColor = [MyController colorWithHexString:@"A3A3A3"];
    self.beizhuLable.numberOfLines = 0;
    self.beizhuLable.font = [UIFont systemFontOfSize:14];
    
    [self.beizhuLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLable);
        make.top.mas_equalTo(self.titleLable.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(self.titleLable);
    }];
    
    self.timeLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLable];
    self.timeLable.textAlignment = NSTextAlignmentRight;
    self.timeLable.numberOfLines = 1;
    self.timeLable.font = [UIFont systemFontOfSize:12];
    self.timeLable.textColor = [MyController colorWithHexString:@"A3A3A3"];

    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.beizhuLable.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.titleLable);
    }];
    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.timeLable.mas_bottom).mas_offset(5);
        make.height.mas_offset(0.5);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
    
    
}
- (void)configCellWithModel:(HistoryModel *)model {
    self.titleLable.text = model.title;
    self.beizhuLable.text = model.beizhu;
    self.timeLable.text = [NSString stringWithFormat:@"总时：%@天",model.time];

}

@end
