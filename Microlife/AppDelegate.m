//
//  AppDelegate.m
//  Microlife
//
//  Created by Rex on 2016/7/22.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate ()<GIDSignInDelegate>{
    int loginType;  //0 = FB  1 = Google;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [GIDSignIn sharedInstance].delegate = self;
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveFBNotification) name:@"FBLogin" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveGoogleNotification) name:@"GoogleLogin" object:nil];
    
    return YES;
}

-(void)getFacebookStatus{
    
}

- (void)receiveFBNotification{
    loginType = 0;
}

- (void)receiveGoogleNotification{
    loginType = 1;
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
    [FBSDKAppEvents activateApp];  //記錄應用程式啟動
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if (loginType == 0) {
        return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:sourceApplication
                                                           annotation:annotation];
    }
    
    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:sourceApplication
                                      annotation:annotation];
}

-(void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error{
    
}

//當textField已經结束被編輯，會委托代理調用這個方法
- (void)textFieldDidEndEditing:(UITextField *)textField{
}

//當keyBoard上return键被點擊，委托代理調用這個方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
//返回值YES，NO没區别,似乎是系统會獲得這個返回值

//當textField中文字發生改變，調用這個方法

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

@end
