//
//  SolitaireDetailViewController.m
//  HomeworkHui
//
//  Created by 徐仁强 on 2017/5/4.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "SolitaireDetailViewController.h"

#import "SolitaireDetailModel.h"

#import "SolitaireDetailTableViewCell.h"
@interface SolitaireDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView* _tableView;
}
//分享
@property (nonatomic, strong) UIPopoverController *activityPopoverController;
//headview上的控件
@property(nonatomic,strong)UILabel* xuhaoLable;
@property(nonatomic,strong)UILabel* nameLable;
@property(nonatomic,strong)UILabel* timeLable;
@property(nonatomic,strong)UIView* lineView;
//数据源
@property(nonatomic,strong)NSMutableArray* dataSourceArr;
@property(nonatomic,assign)NSInteger pageIndex;
//文件路径
@property(nonatomic,copy)NSString* filePath;
@end

@implementation SolitaireDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    
    [self makeRightItem];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSourceArr = [[NSMutableArray alloc] init];
    
    [self makeData];
    
    [self createTableView];
}

- (void)makeRightItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithImage:[UIImage imageNamed:@"share"]
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(rihgtBtnAction)];
}
- (void)rihgtBtnAction{
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"英语接龙" ofType:@"xlsx"];
    NSURL *URL = [NSURL fileURLWithPath:self.filePath];
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
}

- (void)makeData{
    for (int i = 0; i < 10; i++) {
        SolitaireDetailModel* model = [[SolitaireDetailModel alloc] init];
        model.xuhao = [NSString stringWithFormat:@"%d",i + 1];
        model.name = @"小明";
        model.time = @"2017-05-04";
        model.beizhu = @"这就是备注 这就是备注 这就是备注 这就是备注 这就是备注 这就是备注 这就是备注 这就是备注 这就是备注 这就是备注 这就是备注";
        [self.dataSourceArr addObject:model];
    }
    
    [self createXLSFile];
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

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = [NSString stringWithFormat:@"%ld",indexPath.row];
    SolitaireDetailTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[SolitaireDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    SolitaireDetailModel* model = self.dataSourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SolitaireDetailModel *model = nil;
    if (indexPath.row < self.dataSourceArr.count) {
        model = [self.dataSourceArr objectAtIndex:indexPath.row];
    }
    
    NSString *stateKey = nil;
    if (model.isExpand) {
        stateKey = @"expanded";
    } else {
        stateKey = @"unexpanded";
    }
    
    return [SolitaireDetailTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        SolitaireDetailTableViewCell *cell = (SolitaireDetailTableViewCell *)sourceCell;
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

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headView = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40)];
    headView.backgroundColor = [UIColor whiteColor];
    
    self.xuhaoLable = [[UILabel alloc] init];
    self.xuhaoLable.text = @"序号";
    self.xuhaoLable.textColor = [MyController colorWithHexString:@"7EC0EE"];
    self.xuhaoLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:self.xuhaoLable];
    self.xuhaoLable.font = [UIFont systemFontOfSize:16];
    
    [self.xuhaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_offset(40);
        make.width.mas_offset(60);
    }];
    
    self.timeLable = [[UILabel alloc] init];
    self.timeLable.text = @"时间";
    self.timeLable.textColor = [MyController colorWithHexString:@"7EC0EE"];
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:self.timeLable];
    self.timeLable.font = [UIFont systemFontOfSize:16];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.height.mas_offset(40);
        make.width.mas_offset(100);
    }];
    
    self.nameLable = [[UILabel alloc] init];
    self.nameLable.text = @"姓名";
    self.nameLable.textAlignment = NSTextAlignmentCenter;
    self.nameLable.textColor = [MyController colorWithHexString:@"7EC0EE"];
    [headView addSubview:self.nameLable];
    self.nameLable.font = [UIFont systemFontOfSize:16];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.timeLable.mas_left);
        make.left.mas_equalTo(self.xuhaoLable.mas_right);
        make.height.mas_equalTo(self.timeLable);
    }];
    
    self.lineView = [[UIView alloc] init];
    [headView addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(headView.mas_bottom).mas_offset(-0.5);
        make.height.mas_offset(0.5);
    }];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (void)createXLSFile {
    // 创建存放XLS文件数据的数组
    NSMutableArray  *xlsDataMuArr = [[NSMutableArray alloc] init];
    // 第一行内容
    [xlsDataMuArr addObject:@"序号"];
    [xlsDataMuArr addObject:@"姓名"];
    [xlsDataMuArr addObject:@"时间"];
    [xlsDataMuArr addObject:@"备注"];
    // 100行数据
    for (int i = 0; i < self.dataSourceArr.count; i ++) {
        SolitaireDetailModel* model = self.dataSourceArr[i];
        [xlsDataMuArr addObject:model.xuhao];
        [xlsDataMuArr addObject:model.name];
        [xlsDataMuArr addObject:model.time];
        [xlsDataMuArr addObject:model.beizhu];
    }
    // 把数组拼接成字符串，连接符是 \t（功能同键盘上的tab键）
    NSString *fileContent = [xlsDataMuArr componentsJoinedByString:@"\t"];
    // 字符串转换为可变字符串，方便改变某些字符
    NSMutableString *muStr = [fileContent mutableCopy];
    // 新建一个可变数组，存储每行最后一个\t的下标（以便改为\n）
    NSMutableArray *subMuArr = [NSMutableArray array];
    for (int i = 0; i < muStr.length; i ++) {
        NSRange range = [muStr rangeOfString:@"\t" options:NSBackwardsSearch range:NSMakeRange(i, 1)];
        if (range.length == 1) {
            [subMuArr addObject:@(range.location)];
        }
    }
    // 替换末尾\t
    for (NSUInteger i = 0; i < subMuArr.count; i ++) {
#warning  下面的6是列数，根据需求修改
        if ( i > 0 && (i%4 == 0) ) {
            [muStr replaceCharactersInRange:NSMakeRange([[subMuArr objectAtIndex:i-1] intValue], 1) withString:@"\n"];
        }
    }
    // 文件管理器
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    //使用UTF16才能显示汉字；如果显示为#######是因为格子宽度不够，拉开即可
    NSData *fileData = [muStr dataUsingEncoding:NSUTF16StringEncoding];
    // 文件路径
    NSString *path = NSHomeDirectory();
    self.filePath = [path stringByAppendingPathComponent:@"/Documents/jielong.xls"];
    NSLog(@"文件路径：\n%@",self.filePath);
    // 生成xls文件
    [fileManager createFileAtPath:self.filePath contents:fileData attributes:nil];
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
