//
//  ChildInfoViewController.m
//  HomeworkHui
//
//  Created by lingnet on 2017/5/5.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "ChildInfoViewController.h"

#import "ChildInfoModel.h"

#import "ChildInfoTableViewCell.h"
@interface ChildInfoViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,strong)NSMutableArray* dataSourceArr;
@end
@interface ChildInfoViewController ()

@end

@implementation ChildInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"孩子信息";
    self.dataSourceArr = [[NSMutableArray alloc] init];
    
    //取出本地存储小孩信息
    NSUserDefaults *child = [NSUserDefaults standardUserDefaults];
    NSArray *cArr = [child arrayForKey:@"cModel"];
    
    for (int i = 0; i < cArr.count; i++) {
        ChildInfoModel* cmodel = [NSKeyedUnarchiver unarchiveObjectWithData:cArr[i]];
        [self.dataSourceArr addObject:cmodel];
    }
    
    [self createTableView];
}
#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArr.count;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取出当前小孩
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *udata = [user objectForKey:@"cMCurrent"];
    ChildInfoModel *umodel = [NSKeyedUnarchiver unarchiveObjectWithData:udata];
    NSLog(@"---%@",umodel.name);
    self.navigationItem.leftBarButtonItem.title = [NSString stringWithFormat:@"娃：%@",umodel.name];
    
    ChildInfoModel* model = self.dataSourceArr[indexPath.row];
    if ([umodel.id isEqualToString:model.id]) {
        model.isCurrnet = YES;
        for (int i = 0; i < self.dataSourceArr.count; i++) {
            ChildInfoModel* model1 = self.dataSourceArr[i];
            if (i != indexPath.row) {
                model1.isCurrnet = NO;
            }
        }
        [_tableView reloadData];
    }
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = [NSString stringWithFormat:@"%ld",indexPath.row];
    ChildInfoTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[ChildInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    ChildInfoModel* model = self.dataSourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChildInfoModel *model = nil;
    if (indexPath.row < self.dataSourceArr.count) {
        model = [self.dataSourceArr objectAtIndex:indexPath.row];
    }
    
    return [ChildInfoTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        ChildInfoTableViewCell *cell = (ChildInfoTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
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
