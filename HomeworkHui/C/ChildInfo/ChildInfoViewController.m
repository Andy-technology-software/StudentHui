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
    
    ChildInfoModel* model = [[ChildInfoModel alloc] init];
    model.name = @"小明";
    model.classNum = @"双语小学一年级01班";
    model.isCurrnet = YES;
    [self.dataSourceArr addObject:model];
    
    ChildInfoModel* model1 = [[ChildInfoModel alloc] init];
    model1.name = @"小红";
    model1.classNum = @"实验小学一年级02班";
    model1.isCurrnet = NO;
    [self.dataSourceArr addObject:model1];
    
    [self createTableView];
}
#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    //    [_tableView setBackgroundView:tableBg];
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
    ChildInfoModel* model = self.dataSourceArr[indexPath.row];
    if (!model.isCurrnet) {
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
    
    NSString *stateKey = nil;
    if (model.isExpand) {
        stateKey = @"expanded";
    } else {
        stateKey = @"unexpanded";
    }
    
    return [ChildInfoTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        ChildInfoTableViewCell *cell = (ChildInfoTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    } cache:^NSDictionary *{
        return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%d", model.uid],
                 kHYBCacheStateKey : stateKey,
                 // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                 // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                 kHYBRecalculateForStateKey : @(NO) // 标识不用重新更新
                 };
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
