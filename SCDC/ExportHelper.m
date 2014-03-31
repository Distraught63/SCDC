//
//  ExportHelper.m
//  SCDC
//
//  Created by Leen  on 3/29/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "ExportHelper.h"


@implementation ExportHelper

-(void) exportAttendance:(ClassInfo *) theClass
{
    
}

-(NSMutableArray *) getSortedDates: (NSMutableArray *) dates
{
    
    // create the date formatter with the correct format
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    // fast enumeration of the array
    for (Dates *d in dates) {
        NSDate *date = [formatter dateFromString:d.date];
        [tempArray addObject:date];
    }
    
    // sort the array of dates
    [tempArray sortUsingComparator:^NSComparisonResult(NSDate *date1, NSDate *date2) {
        // return date2 compare date1 for descending. Or reverse the call for ascending.
        return [date2 compare:date1];
    }];
    
    NSLog(@"%@", tempArray);
    
    
    return tempArray;
    
}

-(NSMutableArray *) getSortedStudentNames: (ClassInfo *) theClass
{
    
     DatabaseAccess *db = [[DatabaseAccess alloc] init];
     NSMutableArray *students = [db getStudentsInClass: theClass];
    
    
    NSMutableArray *studentNames = [[NSMutableArray alloc] init];
    [yourArrayName sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
}





@end
