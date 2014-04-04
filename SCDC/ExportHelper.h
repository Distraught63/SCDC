//
//  ExportHelper.h
//  SCDC
//
//  Created by Leen  on 3/29/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "Utility.h"
#import "Dates.h"
#import "ClassInfo.h"
#import "DatabaseAccess.h"

@interface ExportHelper : NSObject

-(void) exportAttendance:(ClassInfo *) theClass;

-(NSMutableArray *) getSortedDates: (NSMutableArray *) dates;

@end
