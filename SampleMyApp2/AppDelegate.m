//
//  AppDelegate.m
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/05/16.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "ViewController.h"
#import "MFSideMenuContainerViewController.h"

@implementation AppDelegate


- (ViewController *)demoController {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [mainStoryBoard instantiateViewControllerWithIdentifier:@"ViewController"];
    
}

- (UINavigationController *)navigationController {
    return [[UINavigationController alloc]
            initWithRootViewController:[self demoController]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    
    MFSideMenuContainerViewController *rootViewController = (MFSideMenuContainerViewController *)self.window.rootViewController;
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //　viewを無の空間から使える場所へ。
    _tmpViewContoroller = [mainStoryBoard instantiateViewControllerWithIdentifier:@"MainView"];
    _leftMenuViewContoroller = [mainStoryBoard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    _detailViewContoroller = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Detail"];
    _initialViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"initView"];
    _agesViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Ages"];
   
   UITabBarController *tabBarContoroller =  [mainStoryBoard instantiateViewControllerWithIdentifier:@"TabBarController"];
    //UINavigationController *navigationController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"Navi"];
    
    [rootViewController setLeftMenuViewController:_leftMenuViewContoroller];
    [rootViewController setCenterViewController:tabBarContoroller];
    
  /*  // タブのフォント指定
    UIFont *tabFont = [UIFont fontWithName:@"HelveticaNeue" size:9.0f];
    
    // タブのタイトル色指定
    NSDictionary *attributesNormal = @{NSFontAttributeName:tabFont, NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UITabBarItem appearance] setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
    */
     return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
  
}

@end
