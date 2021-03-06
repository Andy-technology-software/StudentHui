//
//  SolitaireViewController.m
//  HomeworkHui
//
//  Created by 徐仁强 on 2017/5/4.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "SolitaireViewController.h"

#import "SolitaireModel.h"

#import "SolitaireTableViewCell.h"

#import "SolitaireDetailViewController.h"
@interface SolitaireViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,strong)NSMutableArray* dataSourceArr;
@property(nonatomic,assign)NSInteger pageIndex;
@end

@implementation SolitaireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSourceArr = [[NSMutableArray alloc] init];
    
    [self makeData];
    
    [self createTableView];
    
    [_tableView.mj_header beginRefreshing];
}
- (void)makeData{
    for (int i = 0; i < 10; i++) {
        SolitaireModel* model = [[SolitaireModel alloc] init];
        model.title = @"英语接龙：完成一篇英语短文阅读";
        model.beizhu = @"备注：请各位家长配合孩子完成该项任务";
        model.pnum = @"22";
        model.time = @"2017-05-04";
        if (i % 2) {
            model.isSend = YES;
            model.isNew = YES;
        }
        [self.dataSourceArr addObject:model];
    }
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
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self headRefresh];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{//精度
        // 进入刷新状态后会自动调用这个block
        [self footRefresh];
    }];
}
#pragma mark - 下拉刷新
- (void)headRefresh{
    self.pageIndex = 1;
    
    [self createRequest];
}
#pragma mark - 上拉加载
- (void)footRefresh{
    self.pageIndex++;
    
    //    [self createRequest];
    [_tableView.mj_footer endRefreshing];
}


#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArr.count;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SolitaireModel* model = self.dataSourceArr[indexPath.row];
    SolitaireDetailViewController* vc = [[SolitaireDetailViewController alloc] init];
    vc.isSend = model.isSend;
    vc.taskId = model.taskId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = [NSString stringWithFormat:@"%ld",indexPath.row];
    SolitaireTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[SolitaireTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    SolitaireModel* model = self.dataSourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SolitaireModel *model = nil;
    if (indexPath.row < self.dataSourceArr.count) {
        model = [self.dataSourceArr objectAtIndex:indexPath.row];
    }
    
    NSString *stateKey = nil;
    if (model.isExpand) {
        stateKey = @"expanded";
    } else {
        stateKey = @"unexpanded";
    }
    
    return [SolitaireTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        SolitaireTableViewCell *cell = (SolitaireTableViewCell *)sourceCell;
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

- (void)createRequest{
    [RequestService postTasklistWithStudentId:@"1" AndClassId:@"1" complate:^(id responseObject) {
        NSLog(@"任务列表----%@",responseObject[@"data"]);
        NSArray* dataArr = [MyController arraryWithJsonString:responseObject[@"data"]];
        self.dataSourceArr = [SolitaireModel mj_objectArrayWithKeyValuesArray:dataArr];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [HUD warning:@"请检查网络连接"];
    }];
    [_tableView.mj_header endRefreshing];
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
