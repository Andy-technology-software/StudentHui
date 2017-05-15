//
//  LoginViewController.m
//  HomeworkHui
//
//  Created by 徐仁强 on 2017/5/4.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "LoginViewController.h"

#import "LoginModel.h"

#import "ChildInfoModel.h"

#import "UserInfoModel.h"
@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}

@property(nonatomic,retain)JVFloatLabeledTextField *nameTF;
@property(nonatomic,strong)UIView* lineView;
@property(nonatomic,retain)UIButton* dengluBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
    [self createTableView];
}
#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], [MyController getScreenHeight]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.image = [UIImage imageNamed:@"背景"];
    [_tableView setBackgroundView:tableBg];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = [UIColor colorWithRed:190 green:30 blue:96 alpha:1];
    [self.view addSubview:_tableView];
}
#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self makecellUI:cell];
    return cell;
}
- (void)makecellUI:(UITableViewCell*)cell{
    self.nameTF = [[JVFloatLabeledTextField alloc] init];
    self.nameTF.font = [UIFont systemFontOfSize:16];
    self.nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"手机号", @"")
                                                                        attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.nameTF.floatingLabelFont = [UIFont boldSystemFontOfSize:14];
    self.nameTF.floatingLabelTextColor = [UIColor brownColor];
    self.nameTF.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameTF.keyboardType = UIKeyboardTypeNumberPad;
    [cell addSubview:self.nameTF];
    
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(110);
        make.right.mas_equalTo(-40);
        make.height.mas_offset(60);
    }];
    
    self.lineView = [[UIView alloc] init];
    [cell addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameTF);
        make.right.mas_equalTo(self.nameTF);
        make.top.mas_equalTo(self.nameTF.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    self.dengluBtn = [MyController createButtonWithFrame:cell.frame ImageName:nil Target:self Action:@selector(dengluBtnClick) Title:@"登录"];
    [self.dengluBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.dengluBtn setBackgroundColor:[MyController colorWithHexString:@"009588"]];
    self.dengluBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cell addSubview:self.dengluBtn];
    
    [self.dengluBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameTF);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(40);
        make.right.mas_equalTo(self.nameTF);
        make.height.mas_offset(40);
    }];
}
#pragma mark - 登录响应
- (void)dengluBtnClick{
    NSLog(@"登录2");
    if (![RegularExpressions validateMobile:self.nameTF.text]) {
        [HUD warning:@"请正确输入手机号"];
        return;
    }else{
//        [HUD loading];
        [RequestService postLoginWithUsername:self.nameTF.text AndDevType:@"1" complate:^(id responseObject) {
//            ChildInfoModel* model = [ChildInfoModel mj_objectWithKeyValues:responseObject[@"data"][@"childInfo"]];
//            [(AppDelegate *)[UIApplication sharedApplication].delegate setRootVC];
            NSLog(@"登录请求成功---%@",responseObject[@"data"]);
        } failure:^(NSError *error) {
            
        }];
    }
    
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _tableView.frame.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
