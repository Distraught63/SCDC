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

+(NSString *) getDatabasePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"scdc.db"];
    
    return path;
}

+(void) showAlert:(NSString *)title message:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    
    [alert show];
}

//Not needed anymore

//+(NSData *) getRemoteDatabase
//{
//    NSString *stringURL = [Utility getUrl];
//    NSURL  *url = [NSURL URLWithString:stringURL];
////    NSData *urlData = [NSData dataWithContentsOfURL:url];
//    NSData *urlData = [[NSData alloc] initWithContentsOfURL: url];
//    
//    return urlData;
//    
//}

//Not needed anymore

//+(NSString *) getUrl
//{
//    NSString *stringURL = @"https://www.dropbox.com/s/llxy6b6unoemkah/Customers.db?dl=1";
//    return stringURL;
//}


+(void) writeRemote{
    
}


@end
