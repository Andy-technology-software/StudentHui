//
//  ChildInfoTableViewCell.m
//  HomeworkHui
//
//  Created by lingnet on 2017/5/5.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "ChildInfoTableViewCell.h"

#import "ChildInfoModel.h"

@interface ChildInfoTableViewCell()
@property(nonatomic,strong)UILabel* nameLable;
@property(nonatomic,strong)UILabel* classNumLable;

@property(nonatomic,strong)UIImageView* currnetIV;
@property(nonatomic,strong)UIView* lineView;

@end
@implementation ChildInfoTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.nameLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLable];
    self.nameLable.textAlignment = NSTextAlignmentCenter;
    self.nameLable.numberOfLines = 1;
    self.nameLable.font = [UIFont systemFontOfSize:16];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-40);
    }];
    
    self.classNumLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.classNumLable];
    self.classNumLable.textAlignment = NSTextAlignmentCenter;
    self.classNumLable.textColor = [MyController colorWithHexString:@"A3A3A3"];
    self.classNumLable.numberOfLines = 0;
    self.classNumLable.font = [UIFont systemFontOfSize:14];
    
    [self.classNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable);
        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.nameLable);
    }];
    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.classNumLable.mas_bottom).mas_offset(10);
        make.height.mas_offset(0.5);
    }];
    
    self.currnetIV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.currnetIV];
    
    [self.currnetIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_offset(30);
        make.width.mas_offset(30);
    }];
    
    // 必须加上这句
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;

}

- (void)configCellWithModel:(ChildInfoModel *)model {
    //取出当前小孩
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *udata = [user objectForKey:@"cMCurrent"];
    ChildInfoModel *umodel = [NSKeyedUnarchiver unarchiveObjectWithData:udata];
    
    self.nameLable.text = model.name;
    self.classNumLable.text = model.className;
    if ([model.id isEqualToString:umodel.id]) {
        self.currnetIV.image = [UIImage imageNamed:@"ok_select"];
    }else{
        self.currnetIV.image = [UIImage imageNamed:@""];
    }
}

@end
