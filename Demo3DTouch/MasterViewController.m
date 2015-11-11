//
//  MasterViewController.m
//  Demo3DTouch
//
//  Created by AlanYen on 2015/11/11.
//  Copyright © 2015年 17Life. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController () <UIViewControllerPreviewingDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"3D Touch: Master";
    
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

#pragma mark -
#pragma mark - [UITableViewDataSource]

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                            forIndexPath:indexPath];
    
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    
    return cell;
}

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
        return vc;
    }
    return nil;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext
     commitViewController:(UIViewController *)viewControllerToCommit {
    
    [self showDetailViewController:viewControllerToCommit sender:self];
}

@end
