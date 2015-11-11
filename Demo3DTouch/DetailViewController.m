//
//  MasterViewController.m
//  Demo3DTouch
//
//  Created by AlanYen on 2015/11/11.
//  Copyright © 2015年 17Life. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UILabel *infoLabel;
@property (nonatomic, strong) NSArray *previewActions;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"3D Touch: Detail";
    self.infoLabel.text = self.infoText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showMessage:(UIViewController *)viewController message:(NSString *)message {
    
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@""
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:confirmAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

- (NSArray *)previewActionItems {
    return self.previewActions;
}

- (NSArray *)previewActions {
    
    // Then to create a UIPreviewAction, we specify the action title, style and a block to handle the action:
    if (_previewActions == nil) {
        UIPreviewAction *action1 =
        [UIPreviewAction actionWithTitle:@"Action-1"
                                   style:UIPreviewActionStyleDefault
                                 handler:^(UIPreviewAction *action,
                                           UIViewController *previewViewController)
        {
            [self showMessage:self.masterViewController message:@"Action-1"];
        }];
        
        UIPreviewAction *action2 =
        [UIPreviewAction actionWithTitle:@"Action-2"
                                   style:UIPreviewActionStyleDefault
                                 handler:^(UIPreviewAction *action,
                                           UIViewController *previewViewController)
         {
             [self showMessage:self.masterViewController message:@"Action-2"];
         }];
        
        UIPreviewAction *action3 =
        [UIPreviewAction actionWithTitle:@"Action-3"
                                   style:UIPreviewActionStyleDefault
                                 handler:^(UIPreviewAction *action,
                                           UIViewController *previewViewController)
         {
             [self showMessage:self.masterViewController message:@"Action-3"];
         }];

        _previewActions = @[action1, action2, action3];
    }
    return _previewActions;
}

@end
