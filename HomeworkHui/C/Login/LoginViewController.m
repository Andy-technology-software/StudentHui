//
//  LoginViewController.m
//  HomeworkHui
//
//  Created by 徐仁强 on 2017/5/4.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "LoginViewController.h"

#import "ChildInfoModel.h"

#import "UserInfoModel.h"
@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}

@property(nonatomic,retain)JVFloatLabeledTextField *nameTF;
@property(nonatomic,strong)UIView* lineView;
@property(nonatomic,retain)UIButton* dengluBtn;

@property(nonatomic,strong)NSMutableArray* childArr;
@property(nonatomic,strong)NSMutableArray* userArr;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    self.childArr = [[NSMutableArray alloc] init];
    self.userArr = [[NSMutableArray alloc] init];
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
    self.nameTF.text = @"18561927376";
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
    [HUD loading];
    //清除所有数据
    NSString *bundle = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:bundle];
    
    if (![RegularExpressions validateMobile:self.nameTF.text]) {
        [HUD warning:@"请正确输入手机号"];
        return;
    }else{
        [RequestService postLoginWithUsername:self.nameTF.text AndDevType:@"1" complate:^(id responseObject) {
            NSDictionary* cDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
            NSArray* cA = cDic[@"childInfo"];
            //存小孩信息
            for (int i = 0; i < cA.count; i++) {
                ChildInfoModel* model = [ChildInfoModel mj_objectWithKeyValues:cA[i]];
                [self.childArr addObject:[NSKeyedArchiver archivedDataWithRootObject:model]];
            }
            NSArray * tarray = [NSArray arrayWithArray:self.childArr];
            NSUserDefaults *child = [NSUserDefaults standardUserDefaults];
            [child setObject:tarray forKey:@"cModel"];
            
            //存储当前小孩子  防止有多个孩子
            NSUserDefaults *cMCurrent = [NSUserDefaults standardUserDefaults];
            [cMCurrent setObject:[self.childArr lastObject] forKey:@"cMCurrent"];
            
            //存大人信息
            UserInfoModel* model1 = [UserInfoModel mj_objectWithKeyValues:cDic[@"userInfo"]];
            NSLog(@"-----%@",model1.address);
            [self.userArr addObject:model1];
            
            NSData *udata = [NSKeyedArchiver archivedDataWithRootObject:model1];
            NSUserDefaults *userM = [NSUserDefaults standardUserDefaults];
            [userM setObject:udata forKey:@"uModel"];
            
            [HUD success:@"登录成功"];
            
            [(AppDelegate *)[UIApplication sharedApplication].delegate setRootVC];
        } failure:^(NSError *error) {
            [HUD warning:@"请检查网络连接"];
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
