//
//  AppDelegate.h
//  SCDC
//
//  Created by Leen  on 2/8/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FTPHelper.h"
#import "FMDatabase.h"
#import "Utility.h"

@class  CustomersViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) NSString *databaseName;
@property (nonatomic,strong) NSString *databasePath;


-(void) createAndCheckDatabase;

-(void) createAndCheckWithRemote: (CustomersViewController *)delegate;


@end
