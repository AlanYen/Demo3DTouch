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

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Master";
    
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

// 轻按进入浮动预览页面
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    
    // 注意这里我因为测试，没做具体的位置处理，如果需要定位到具体的图片Cell位置的话，可以用location通过tableView的convertPoint来取到指定Cell
    DetailViewController *vc =
    [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    vc.masterViewController = self;
    return vc;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext
     commitViewController:(UIViewController *)viewControllerToCommit {
    
    [self showDetailViewController:viewControllerToCommit sender:self];
}

@end
