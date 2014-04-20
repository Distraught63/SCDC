//
//  AppDelegate.m
//  SCDC
//
//  Created by Leen  on 2/8/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Database Creation
    self.databaseName = @"scdc.db";
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentDir stringByAppendingPathComponent:self.databaseName];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"UpperBarNewColor.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self createAndCheckWithRemote:nil];
    [self createAndCheckDatabase];
    
    return YES;
    
}
-(void) createAndCheckWithRemote:(ClassesViewController *)delegate
{
    
    NSLog(@"Downloading remote database...");
    
    FTPHelper *ftp = [[FTPHelper alloc] init];
    
    [ftp downloadFile:delegate];
    
}

//Creates the database from the database stored in supporting files in case there was no internet connection.
-(void) createAndCheckDatabase
{
    NSLog(@"Copying Database.....");
    BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:self.databasePath];
    
    if(success) return;
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseName];
    
    [fileManager copyItemAtPath:databasePathFromApp toPath: self.databasePath error:nil];
    
    NSLog(@"Database coppied over.");
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
