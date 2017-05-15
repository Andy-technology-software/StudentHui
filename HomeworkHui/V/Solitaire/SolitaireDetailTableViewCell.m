//
//  SolitaireDetailTableViewCell.m
//  HomeworkHui
//
//  Created by lingnet on 2017/5/5.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "SolitaireDetailTableViewCell.h"

#import "SolitaireDetailModel.h"

@interface SolitaireDetailTableViewCell()
@property(nonatomic,strong)UILabel* xuhaoLable;
@property(nonatomic,strong)UILabel* nameLable;
@property(nonatomic,strong)UILabel* timeLable;
@property(nonatomic,strong)UILabel* beizhuLable;

@property(nonatomic,strong)UIView* lineView;

@end
@implementation SolitaireDetailTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.xuhaoLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.xuhaoLable];
    self.xuhaoLable.numberOfLines = 1;
    self.xuhaoLable.textAlignment = NSTextAlignmentCenter;
    self.xuhaoLable.font = [UIFont systemFontOfSize:14];
    
    [self.xuhaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_offset(60);
    }];
    
    self.timeLable = [[UILabel alloc] init];
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLable];
    self.timeLable.numberOfLines = 1;
    self.timeLable.font = [UIFont systemFontOfSize:14];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(10);
        make.width.mas_offset(100);
    }];
    
    self.nameLable = [[UILabel alloc] init];
    self.nameLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLable];
    self.nameLable.numberOfLines = 1;
    self.nameLable.font = [UIFont systemFontOfSize:14];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLable);
        make.right.mas_equalTo(self.timeLable.mas_left);
        make.left.mas_equalTo(self.xuhaoLable.mas_right);
    }];
    
    self.beizhuLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.beizhuLable];
    self.beizhuLable.numberOfLines = 0;
    self.beizhuLable.textColor = [MyController colorWithHexString:@"A3A3A3"];
    self.beizhuLable.font = [UIFont systemFontOfSize:12];
    
    [self.beizhuLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.timeLable);
        make.left.mas_equalTo(self.nameLable);
    }];
    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.beizhuLable.mas_bottom).mas_offset(10);
        make.height.mas_offset(0.5);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
    
    
}
- (void)configCellWithModel:(SolitaireDetailModel *)model {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *udata = [user objectForKey:@"cMCurrent"];
    ChildInfoModel *umodel = [NSKeyedUnarchiver unarchiveObjectWithData:udata];
    
    self.xuhaoLable.text = model.sID;
    self.nameLable.text = model.sName;
    self.timeLable.text = model.recordTime;
    self.beizhuLable.text = model.recordText;
    if ([model.sID isEqualToString:umodel.id]) {
        self.xuhaoLable.textColor = [MyController colorWithHexString:@"00BFFF"];
        self.nameLable.textColor = [MyController colorWithHexString:@"00BFFF"];
        self.timeLable.textColor = [MyController colorWithHexString:@"00BFFF"];
        self.beizhuLable.textColor = [MyController colorWithHexString:@"00BFFF"];
    }else{
        self.xuhaoLable.textColor = [MyController colorWithHexString:@"000000"];
        self.nameLable.textColor = [MyController colorWithHexString:@"000000"];
        self.timeLable.textColor = [MyController colorWithHexString:@"000000"];
        self.beizhuLable.textColor = [MyController colorWithHexString:@"000000"];
    }
}


@end
