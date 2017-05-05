//
//  HistoryDetailViewController.m
//  HomeworkHui
//
//  Created by lingnet on 2017/5/5.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "HistoryDetailViewController.h"

#import "HistoryDetailModel.h"

#import "HistoryDetailTableViewCell.h"

#import "SolitaireDetailViewController.h"
@interface HistoryDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,strong)NSMutableArray* dataSourceArr;
@property(nonatomic,strong)UILabel* startL;
@property(nonatomic,strong)UILabel* endL;
@property(nonatomic,copy)NSString* startTime;
@property(nonatomic,copy)NSString* endTime;
@property(nonatomic,copy)NSString* filePath;
@property(nonatomic,assign)BOOL isStratTime;
@property (nonatomic, strong) UIPopoverController *activityPopoverController;

@end

@implementation HistoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"任务";
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSourceArr = [[NSMutableArray alloc] init];
    self.startTime = @"2017-05-01";
    self.endTime = @"2017-05-06";
    
    [self makeRightItem];
    
    [self makeData];
    
    [self makePicUI];
    
    [self createTableView];
    
    [_tableView.mj_header beginRefreshing];
}
- (void)makeData{
    for (int i = 0; i < 10; i++) {
        HistoryDetailModel* model = [[HistoryDetailModel alloc] init];
        model.title = @"英语接龙：完成一篇英语短文阅读";
        model.beizhu = @"备注：请各位家长配合孩子完成该项任务";
        model.pnum = @"22";
        model.time = @"2017-05-04";
        [self.dataSourceArr addObject:model];
    }
}

- (void)makeRightItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithImage:[UIImage imageNamed:@"share"]
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(rihgtBtnAction)];
}

- (void)rihgtBtnAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:[NSString stringWithFormat:@"您当前选中的导出时间段为：%@至%@",self.startTime,self.endTime] preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleCancel handler:^(UIAlertAction*action) {
        NSLog(@"点击了确定按钮");
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"徐仁强工作周报" ofType:@"xlsx"];
        NSURL *URL = [NSURL fileURLWithPath:filePath];
        TTOpenInAppActivity *openInAppActivity = [[TTOpenInAppActivity alloc] initWithView:self.view andRect:CGRectMake(0, 0, [MyController getScreenWidth], [MyController getScreenHeight])];
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[URL] applicationActivities:@[openInAppActivity]];
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            // Store reference to superview (UIActionSheet) to allow dismissal
            openInAppActivity.superViewController = activityViewController;
            // Show UIActivityViewController
            [self presentViewController:activityViewController animated:YES completion:NULL];
        } else {
            // Create pop up
            self.activityPopoverController = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
            // Store reference to superview (UIPopoverController) to allow dismissal
            openInAppActivity.superViewController = self.activityPopoverController;
            // Show UIActivityViewController in popup
            [self.activityPopoverController presentPopoverFromRect:self.view.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleDestructive handler:^(UIAlertAction*action) {
        NSLog(@"点击了取消按钮");
    }]];
}


- (void)makePicUI{
    self.startL = [MyController createLabelWithFrame:CGRectMake(0, [MyController isIOS7], [MyController getScreenWidth]/2, 50) Font:14 Text:[NSString stringWithFormat:@"开始:%@",self.startTime]];
    self.startL.textAlignment = NSTextAlignmentCenter;
    self.startL.textColor = [MyController colorWithHexString:@"009588"];
    [self.view addSubview:self.startL];
    
    UIButton* startBtn = [MyController createButtonWithFrame:self.startL.frame ImageName:nil Target:self Action:@selector(startBtnClick) Title:nil];
    [self.view addSubview:startBtn];
    
    self.endL = [MyController createLabelWithFrame:CGRectMake([MyController getScreenWidth]/2, [MyController isIOS7], [MyController getScreenWidth]/2, 50) Font:14 Text:[NSString stringWithFormat:@"结束:%@",self.endTime]];
    self.endL.textColor = [MyController colorWithHexString:@"009588"];
    self.endL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.endL];
    
    UIButton* endBtn = [MyController createButtonWithFrame:self.endL.frame ImageName:nil Target:self Action:@selector(endBtnClick) Title:nil];
    [self.view addSubview:endBtn];
    
    UIView* line1 = [MyController viewWithFrame:CGRectMake([MyController getScreenWidth]/2, [MyController isIOS7] + 3, 0.5, 44)];
    line1.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.view addSubview:line1];
    
    UIView* line2 = [MyController viewWithFrame:CGRectMake(0, [MyController isIOS7] + 49.5, [MyController getScreenWidth], 0.5)];
    line2.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.view addSubview:line2];
}
- (void)startBtnClick{
    NSLog(@"开始时间");
    self.isStratTime = YES;
    [self selectTime];
}

- (void)endBtnClick{
    NSLog(@"结束时间");
    self.isStratTime = NO;
    [self selectTime];
}

- (void)selectTime{
    UIDatePicker *picker = [[UIDatePicker alloc]init];
    picker.datePickerMode = UIDatePickerModeDate;
    
    picker.frame = CGRectMake(0, 40, 320, 200);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (action.isEnabled) {
            //        [HUD loading];
            NSDate *date = picker.date;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            if (self.isStratTime) {
                NSDateFormatter* dateFormat1 = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
                [dateFormat1 setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
                NSDate *enddate =[dateFormat1 dateFromString:self.endTime];
                if([MyController compareOneDay:date withAnotherDay:enddate] == 1){
                    [HUD warning:@"开始时间要早于结束时间"];
                    return ;
                }
                self.startTime = [dateFormatter stringFromDate:date];
                self.startL.text = [NSString stringWithFormat:@"开始:%@",self.startTime];
            }else{
                NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
                [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,这里可以设置成自己需要的格式
                NSDate *startdate =[dateFormat dateFromString:self.startTime];
                if([MyController compareOneDay:startdate withAnotherDay:date] == 1){
                    [HUD warning:@"结束时间要晚于开始时间"];
                    return ;
                }
                self.endTime = [dateFormatter stringFromDate:date];
                self.endL.text = [NSString stringWithFormat:@"结束:%@",self.endTime];
            }
            //        [self createUserInfoUpdateRequest];
        }
    }];
    [alertController.view addSubview:picker];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7] + 50, self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 50) style:UITableViewStylePlain];
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
}
#pragma mark - 下拉刷新
- (void)headRefresh{
    //    [self createRequest];
    [_tableView.mj_header endRefreshing];
}

#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArr.count;
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SolitaireDetailViewController* vc = [[SolitaireDetailViewController alloc] init];
    vc.isSend = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = [NSString stringWithFormat:@"%ld",indexPath.row];
    HistoryDetailTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[HistoryDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    HistoryDetailModel* model = self.dataSourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryDetailModel *model = nil;
    if (indexPath.row < self.dataSourceArr.count) {
        model = [self.dataSourceArr objectAtIndex:indexPath.row];
    }
    
    NSString *stateKey = nil;
    if (model.isExpand) {
        stateKey = @"expanded";
    } else {
        stateKey = @"unexpanded";
    }
    
    return [HistoryDetailTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        HistoryDetailTableViewCell *cell = (HistoryDetailTableViewCell *)sourceCell;
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
