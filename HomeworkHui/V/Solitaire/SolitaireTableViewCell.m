//
//  SolitaireTableViewCell.m
//  HomeworkHui
//
//  Created by 徐仁强 on 2017/5/4.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "SolitaireTableViewCell.h"

#import "SolitaireModel.h"

@interface SolitaireTableViewCell()
@property(nonatomic,strong)UILabel* titleLable;
@property(nonatomic,strong)UILabel* beizhuLable;
@property(nonatomic,strong)UILabel* pNumAndTimeLable;
@property(nonatomic,strong)UILabel* isSendLable;

@property(nonatomic,strong)UIImageView* isSendIV;
@property(nonatomic,strong)UIImageView* isNewIV;
@property(nonatomic,strong)UIView* lineView;

@end
@implementation SolitaireTableViewCell

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
    
    self.isSendLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.isSendLable];
    self.isSendLable.numberOfLines = 1;
    self.isSendLable.font = [UIFont systemFontOfSize:12];
    
    [self.isSendLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.beizhuLable.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.beizhuLable);
    }];
    
    self.isSendIV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.isSendIV];
    
    [self.isSendIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.isSendLable.mas_left).mas_offset(-2);
        make.top.mas_equalTo(self.isSendLable.mas_top).mas_offset(-2);
        make.height.mas_offset(16);
        make.width.mas_offset(16);
    }];
    
    self.pNumAndTimeLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.pNumAndTimeLable];
    self.pNumAndTimeLable.numberOfLines = 1;
    self.pNumAndTimeLable.font = [UIFont systemFontOfSize:12];
    self.pNumAndTimeLable.textColor = [MyController colorWithHexString:@"A3A3A3"];
    [self.pNumAndTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.isSendLable);
        make.right.mas_equalTo(self.isSendIV.mas_left).mas_offset(-5);
    }];
    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.pNumAndTimeLable.mas_bottom).mas_offset(5);
        make.height.mas_offset(0.5);
    }];
    
    self.isNewIV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.isNewIV];
    
    [self.isNewIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-2);
        make.top.mas_equalTo(2);
        make.height.mas_offset(30);
        make.width.mas_offset(30);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
    
    
}
- (void)configCellWithModel:(SolitaireModel *)model {
    self.titleLable.text = model.title;
    self.beizhuLable.text = model.beizhu;
    self.pNumAndTimeLable.text = [NSString stringWithFormat:@"%@人已接龙    %@",model.pnum,model.time];
    if (model.isSend) {
        self.isSendIV.image = [UIImage imageNamed:@""];
        self.isSendLable.text = @"已接龙";
        self.isSendLable.textColor = [MyController colorWithHexString:@"009588"];
    }else{
        self.isSendIV.image = [UIImage imageNamed:@""];
        self.isSendLable.text = @"待接龙";
        self.isSendLable.textColor = [MyController colorWithHexString:@"A3A3A3"];
    }
    
    if (model.isNew) {
        self.isNewIV.image = [UIImage imageNamed:@"new"];
    }else{
        self.isNewIV.image = [UIImage imageNamed:@""];
    }
}

@end
