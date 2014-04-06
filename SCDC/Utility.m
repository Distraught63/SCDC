//
//  Utility.m
//
//  Created by Leen  on 3/10/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#import "Utility.h"

@implementation Utility : NSObject


/*
 Returns the local database path (local)
 */
+(NSString *) getDatabasePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"scdc.db"];
    
    return path;
}

//Not needed anymore
//
+(void) showAlert:(NSString *)title message:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    
    [alert show];
}




@end
