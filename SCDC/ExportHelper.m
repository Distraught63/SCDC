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


-(NSMutableArray *) createDataArray:(ClassInfo *) theClass
{
    DatabaseAccess *db = [[DatabaseAccess alloc] init];
    
    NSMutableArray *dates = [db getAttendance:theClass];
    NSMutableArray *students = [db getStudentsInClass: theClass];
    
    NSMutableArray *sortedDates = [self getSortedDates:dates];
    
    NSMutableArray *result =[[NSMutableArray alloc] init];
    
    NSNumber *one = [NSNumber numberWithInt: 1];
    NSNumber *zero = [NSNumber numberWithInt: 0 ];
    
//    for(Student *s in students)
//    {
//        
//        NSMutableArray *temp =[[NSMutableArray alloc] init];
//        
//        for (int i = 0; i < dates.count; i++) {
//            
//            Dates * date =[dates objectAtIndex:i];
//            if ( date.student_id == s.studentId) {
//                [temp addObject:one];
//            } else {
//                [temp addObject:zero];
//            }
//        }
//        
//        [result addObject:temp];
//        
//    }
    
    
    for(Student *s in students)
    {
        
        NSMutableArray *temp =[[NSMutableArray alloc] init];
        
        for (NSString *date in sortedDates)
        {
            if ( date.student_id == s.studentId) {
                [temp addObject:one];
            } else {
                [temp addObject:zero];
            }
        }
        
        [result addObject:temp];
        
    }
    
    
    
    return result;
    
}

-(NSMutableArray *) getSortedDates: (NSMutableArray *) dates
{
    
    // create the date formatter with the correct format
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];;
    
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
    
    for(Student *s in students)
    {
        [studentNames addObject: [s.firstName stringByAppendingString: s.lastName ]];
    }
    
    [studentNames sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSLog(@"Array is %@", studentNames);
    
    return studentNames;
    
}





@end
