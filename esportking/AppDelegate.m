//
//  AppDelegate.m
//  esportking
//
//  Created by CKQ on 2018/2/3.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "AppDelegate.h"
#import "CCLanunchConfig.h"

#import "CCRootViewController.h"
#import "CCLoginViewController.h"

#import "CCPayManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    CCLoginViewController *rootViewController = [[CCLoginViewController alloc] init];
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [navController setNavigationBarHidden:YES animated:NO];
    [self.window setRootViewController:navController];
    [self.window makeKeyAndVisible];
    
    [CCLanunchConfig configAll];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    return [[CCPayManager shareInstance] handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)changeToLoginPage
{
    CCLoginViewController *rootViewController = [[CCLoginViewController alloc] init];
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [navController setNavigationBarHidden:YES animated:NO];
    [self.window setRootViewController:navController];
    [self.window makeKeyAndVisible];
}

- (void)changeToContentPage
{
    CCRootViewController *rootViewController = [[CCRootViewController alloc] init];
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [navController setNavigationBarHidden:YES animated:NO];
    [self.window setRootViewController:navController];
    [self.window makeKeyAndVisible];
    
    [CCLanunchConfig configAfterLogin];
}

@end
