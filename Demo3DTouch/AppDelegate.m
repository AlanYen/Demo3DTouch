//
//  AppDelegate.m
//  Demo3DTouch
//
//  Created by AlanYen on 2015/11/11.
//  Copyright © 2015年 17Life. All rights reserved.
//

#import "AppDelegate.h"

#define BUILD_TYPE(X) [NSString stringWithFormat:@"%@.%@", [NSBundle mainBundle].bundleIdentifier, X]

@interface AppDelegate ()

// Saved shortcut item used as a result of an app launch, used later when app is activated.
@property (nonatomic, strong) UIApplicationShortcutItem *launchedShortcutItem;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    BOOL shouldPerformAdditionalDelegateHandling = YES;
    
    // If a shortcut was launched, display its information and take the appropriate action
    if (launchOptions && [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey]) {
        
        // 說明是由 Quick Action 啟動的App
        // 獲取到 Shortcut Item 的引用
        self.launchedShortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
        
        // 如若返回NO，則系統不會調用 performActionForShortcutItem 方法
        // 因為我們會在 applicationDidBecomeActive 做出處理
        // 因此這裡不希望 performActionForShortcutItem 先處理一下
        
        // This will block "performActionForShortcutItem:completionHandler" from being called.
        shouldPerformAdditionalDelegateHandling = NO;
    }

    // Install initial versions of our two extra dynamic shortcuts.
    // 增加額外的動態捷徑
    if (!application.shortcutItems || application.shortcutItems.count == 0) {
        // Type3
        UIApplicationShortcutItem *item3 = [[UIMutableApplicationShortcutItem alloc] initWithType:BUILD_TYPE(@"Type3")
                                                                                   localizedTitle:@"17Life.3"
                                                                                localizedSubtitle:@"http://www.17life.com"
                                                                                             icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove]
                                                                                         userInfo:nil];
        // Type4
        UIApplicationShortcutItem *item4 = [[UIMutableApplicationShortcutItem alloc] initWithType:BUILD_TYPE(@"Type4")
                                                                                   localizedTitle:@"17Life.4"
                                                                                localizedSubtitle:@"http://www.17life.com"
                                                                                             icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare]
                                                                                         userInfo:nil];
        // Type5
        UIApplicationShortcutItem *item5 = [[UIMutableApplicationShortcutItem alloc] initWithType:BUILD_TYPE(@"Type5")
                                                                                   localizedTitle:@"17Life.5"
                                                                                localizedSubtitle:@"http://www.17life.com"
                                                                                             icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeBookmark]
                                                                                         userInfo:nil];
        application.shortcutItems = @[item3, item4, item5];
    }

    return shouldPerformAdditionalDelegateHandling;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    if (self.launchedShortcutItem) {
        [self handleQuickActions:self.launchedShortcutItem];
        self.launchedShortcutItem = nil;
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    BOOL hasHandled = [self handleQuickActions:shortcutItem];
    // 告訴系統Quick Actions有沒有被妥善處理
    completionHandler(hasHandled);
}

- (BOOL)handleQuickActions:(UIApplicationShortcutItem *)item {
    
    void (^handle)(NSString *) = ^(NSString *type) {
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@"Handle" message:type preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action];
        
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    };
    
    handle(item.type);
    if ([item.type isEqualToString:BUILD_TYPE(@"Type1")] ||
        [item.type isEqualToString:BUILD_TYPE(@"Type2")] ||
        [item.type isEqualToString:BUILD_TYPE(@"Type3")] ||
        [item.type isEqualToString:BUILD_TYPE(@"Type4")] ||
        [item.type isEqualToString:BUILD_TYPE(@"Type5")]) {
        
        handle(item.type);
        return YES;
    }
    return NO;
}

@end
