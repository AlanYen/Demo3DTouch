//
//  MasterViewController.m
//  Demo3DTouch
//
//  Created by AlanYen on 2015/11/11.
//  Copyright © 2015年 17Life. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MyTableView.h"
#import "MyLabel.h"

@interface MasterViewController () <UIViewControllerPreviewingDelegate>

@property (nonatomic, weak) IBOutlet MyTableView *tableView;
@property (nonatomic, weak) IBOutlet MyLabel *tableHeaderLabel;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"3D Touch: Master";
    
    self.tableHeaderLabel.text = @"Force-Touch information";
    [self.tableView addObserver:self forKeyPath:@"touchForce" options:NSKeyValueObservingOptionNew context:nil];
    [self.tableView addObserver:self forKeyPath:@"touchMaximumPossibleForce" options:NSKeyValueObservingOptionNew context:nil];
    
    self.titleArray = @[@"3D Touch : Long-Press the Screen (1)",
                        @"3D Touch : Long-Press the Screen (2)",
                        @"3D Touch : Long-Press the Screen (3)"];
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        // 具備 3D Touch 能力
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
    else {
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@""
                                            message:@"裝置不支援 3D Touch 功能!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self removeObserver:self.tableView forKeyPath:@"touchForce"];
    [self removeObserver:self.tableView forKeyPath:@"touchMaximumPossibleForce"];
}

#pragma mark -
#pragma mark - [UITableViewDataSource]

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    NSString *force = [NSString stringWithFormat:@"Force-Touch information\nTouchForce: %f\nTouchMaximumPossibleForce: %f\n Ratio: %f",
                       self.tableView.touchForce, self.tableView.touchMaximumPossibleForce,
                       (self.tableView.touchForce / self.tableView.touchMaximumPossibleForce)];
    self.tableHeaderLabel.text = force;
}

#pragma mark -
#pragma mark - [UITableViewDataSource]

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark - [UITableViewDelegate]

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消 select 狀態
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.tableHeaderLabel.text = @"Force-Touch information";
}

#pragma mark -
#pragma mark - [UIViewControllerPreviewingDelegate]

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {

    // 參考 http://stackoverflow.com/questions/32772351/3d-touch-peek-and-pop-trouble
    // 要轉換位置到 tableview
    CGPoint convertedLocation = [self.view convertPoint:location toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:convertedLocation];
    if (indexPath) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

        DetailViewController *vc =
        [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        vc.masterViewController = self;
        vc.infoText = cell.textLabel.text;
        
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        vc.preferredContentSize = CGSizeMake(0.0, (screenSize.height * 0.75));
        
        // Wrong!!!
        //previewingContext.sourceRect = [self.tableView rectForRowAtIndexPath:indexPath];
        
        // Wrong!!!
        //previewingContext.sourceRect = cell.frame;
        
        // Correct!!! 要轉換 view
        // 參考 http://stackoverflow.com/questions/33002637/3d-touch-peek-and-pop-from-uitableviewcell-how-to-hand-over-data-to-other-uiview
        previewingContext.sourceRect = [self.view convertRect:cell.frame fromView:self.tableView];

        return vc;
    }
    return nil;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext
     commitViewController:(UIViewController *)viewControllerToCommit {

    // 當我們重按顯示出控制器之後，再加大力度去按，就會執行此方法
    //[self showDetailViewController:viewControllerToCommit sender:self];
    //[self presentViewController:viewControllerToCommit animated:YES completion:nil];
    //[self showViewController:viewControllerToCommit sender:self];
    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
}

@end
