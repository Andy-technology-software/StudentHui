//
//  IndexViewController.m
//  HomeworkHui
//
//  Created by 徐仁强 on 2017/5/4.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "IndexViewController.h"

#import "SolitaireViewController.h"

#import "HistoryViewController.h"

#import "XLPopMenuViewModel.h"

#import "XLPopMenuViewSingleton.h"

#import "ChildInfoViewController.h"
@interface IndexViewController ()
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic,strong) NSMutableArray *arr;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureNav];
    
    [self configureUI];
}
- (void)configureUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    SolitaireViewController *enterpriseVC = [[SolitaireViewController alloc] init];
    [self addChildViewController:enterpriseVC];
    [self.view addSubview:enterpriseVC.view];
    //    enterpriseVC.view.hidden = YES;
    
    HistoryViewController *liveVC = [[HistoryViewController alloc] init];
    [self addChildViewController:liveVC];
    [self.view addSubview:liveVC.view];
    liveVC.view.hidden = YES;
}
- (void)configureNav
{
    self.segment = ({
        UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"接龙任务",@"历史任务"]];
        segment.frame = CGRectMake(0, 0, 130, 28);
        segment.selectedSegmentIndex = 0;
        segment.tintColor = [MyController colorWithHexString:@"009588"];
        segment.layer.masksToBounds = YES;
        segment.layer.cornerRadius = 13;
        segment.layer.borderWidth = 1;
        segment.layer.borderColor = [MyController colorWithHexString:@"009588"].CGColor;
        NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
        attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
//        attrDict[NSForegroundColorAttributeName] = CGColorGetAlpha(<#CGColorRef  _Nullable color#>);
        [segment setTitleTextAttributes:attrDict forState:UIControlStateNormal];
        [segment setContentOffset:CGSizeMake(1, 0) forSegmentAtIndex:0];
        [segment setContentOffset:CGSizeMake(-1, 0) forSegmentAtIndex:1];
        [segment addTarget:self action:@selector(segmentAction:)
          forControlEvents:UIControlEventValueChanged];
        self.navigationItem.titleView = segment;
        segment;
    });
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithImage:[UIImage imageNamed:@"info"]
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(rihgtBtnAction)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithImage:[UIImage imageNamed:@""]
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(leftBtnAction)];
    self.navigationItem.leftBarButtonItem.title = @"娃:小明";
    
}
- (void)segmentAction:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        self.childViewControllers[0].view.hidden = NO;
        self.childViewControllers[1].view.hidden = YES;
    }else {
        self.childViewControllers[0].view.hidden = YES;
        self.childViewControllers[1].view.hidden = NO;
    }
}
- (void)leftBtnAction{
    
}

- (void)rihgtBtnAction{
    if (!_arr)
    {
        _arr = [[NSMutableArray alloc] init];
        for (int i = 0; i < [self titles].count; i++) {
            XLPopMenuViewModel *model = [[XLPopMenuViewModel alloc] init];
            model.image = [self images][i];
            model.title = [self titles][i];
            [_arr addObject:model];
            
        }
        
    }
    // 弹出框的宽度
    CGFloat menuViewWidth = 150;
    // 弹出框的左上角起点坐标
    CGPoint startPoint = CGPointMake([UIScreen mainScreen].bounds.size.width - menuViewWidth - 10, 64 + 12);
    
    [[XLPopMenuViewSingleton shareManager] creatPopMenuWithFrame:startPoint popMenuWidth:menuViewWidth popMenuItems:_arr action:^(NSInteger index) {
        
        NSLog(@"index= %ld",(long)index);
        if (1 == index) {
            [(AppDelegate *)[UIApplication sharedApplication].delegate setLoginRoot];
        }else if (0 == index){
            ChildInfoViewController* vc = [[ChildInfoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSArray *)titles
{
    return @[@"孩子信息",
             @"退出登录"];
}

- (NSArray *) images {
    return @[@"child",
             @"logout"];
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
