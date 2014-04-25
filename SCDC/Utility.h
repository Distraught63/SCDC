//
//  Utility.h
//
//  Created by Leen  on 3/10/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface Utility : NSObject


+(NSString *) getDatabasePath;

+(NSString *) getClassesPath;

+(NSString *) getStudentsPath;

+(NSString *) getRegistrationPath;

+(void) showAlert:(NSString *) title message:(NSString *) msg;

//+(NSData *) getRemoteDatabase;

//+(NSString *) getUrl;//Not needed anymore.

//+(void) writeRemote;


@end
