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

- (UIPreviewAction *)createPreviewAction:(NSString *)title {
    UIPreviewAction *action =
    [UIPreviewAction actionWithTitle:title
                               style:UIPreviewActionStyleDefault
                             handler:^(UIPreviewAction *action,
                                       UIViewController *previewViewController)
     {
         [self showMessage:self.masterViewController message:title];
     }];
    return action;
}

- (NSArray *)previewActionItems {
    return self.previewActions;
}

- (NSArray *)previewActions {
    
    // Then to create a UIPreviewAction, we specify the action title, style and a block to handle the action:
    if (_previewActions == nil) {
        
        UIPreviewAction *action1 = [self createPreviewAction:@"Action-1"];
        UIPreviewAction *action2 = [self createPreviewAction:@"Action-2"];
        UIPreviewAction *action3 = [self createPreviewAction:@"Action-3"];
        UIPreviewAction *action4 = [self createPreviewAction:@"Action-4"];
        UIPreviewAction *action5 = [self createPreviewAction:@"Action-5"];
        UIPreviewAction *action6 = [self createPreviewAction:@"Action-6"];
        UIPreviewAction *action7 = [self createPreviewAction:@"Action-7"];
        UIPreviewAction *action8 = [self createPreviewAction:@"Action-8"];
        
        // [可以是一層或二層結構]
        
        #if 0
        
        //
        // 一層
        //
        _previewActions = @[action1, action2, action3, action4, action5, action6, action7, action8];
        
        #else
        
        //
        // 二層
        //

        // 塞到 UIPreviewActionGroup 中
        UIPreviewActionGroup *group1 = [UIPreviewActionGroup actionGroupWithTitle:@"Action Group 1"
                                                                            style:UIPreviewActionStyleDestructive
                                                                          actions:@[action1, action2, action3]];
        
        UIPreviewActionGroup *group2 = [UIPreviewActionGroup actionGroupWithTitle:@"Action Group 2"
                                                                            style:UIPreviewActionStyleDefault
                                                                          actions:@[action4, action5, action6, action7, action8]];
        
        _previewActions = @[group1, group2];
        
        #endif
    }
    return _previewActions;
}

@end
