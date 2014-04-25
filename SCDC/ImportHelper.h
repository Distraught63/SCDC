//
//  ImportHelper.h
//  SCDC
//
//  Created by Leen  on 4/11/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface ImportHelper : NSObject


-(void) importAll;

@property (nonatomic, strong) FMDatabase *db;

@end
