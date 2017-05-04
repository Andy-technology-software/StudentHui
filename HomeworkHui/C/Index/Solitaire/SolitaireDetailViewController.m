//
//  SolitaireDetailViewController.m
//  HomeworkHui
//
//  Created by 徐仁强 on 2017/5/4.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "SolitaireDetailViewController.h"

@interface SolitaireDetailViewController ()
@property (nonatomic, strong) UIPopoverController *activityPopoverController;

@end

@implementation SolitaireDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    
    [self makeRightItem];
}

- (void)makeRightItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithImage:[UIImage imageNamed:@"share"]
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(rihgtBtnAction)];
}
- (void)rihgtBtnAction{
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
