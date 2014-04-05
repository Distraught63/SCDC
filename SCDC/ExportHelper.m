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
    
    NSString *csv = [self createCSV:theClass];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@AttendanceSheet.csv", theClass.name];
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    [csv writeToFile:path atomically:YES encoding:NSASCIIStringEncoding error:NULL];
    
    FTPHelper *ftp = [[FTPHelper alloc] init];
    
    NSLog(@"Path is %@", path);
    [ftp uploadCSV:path fileName:fileName];
    
//    [csv writeToFile:[documentsDirectory stringByAppendingPathComponent:fileName]];
    
    
}


-(NSMutableArray *) createDataArray:(NSMutableArray *) sortedStudents dates:(NSMutableArray *) sortedDates
{
    DatabaseAccess *db = [[DatabaseAccess alloc] init];

    
    //The array that contains the attendance information in a matrix style.
    NSMutableArray *result =[[NSMutableArray alloc] init];
    
    
    //Open Database
    FMDatabase *dbase = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [dbase open];
    
    
    for(NSString *s in sortedStudents)
    {
        
        NSArray *name = [s componentsSeparatedByString:@" "];
        
        NSString *firstName = [name objectAtIndex:0]; //first name
        NSString *lastName = [name objectAtIndex:1]; // last name
        
        NSMutableArray *temp =[[NSMutableArray alloc] init];
        
        //Database query
        FMResultSet *results = [dbase executeQuery:@"select * from student where firstname=? and lastname=?", firstName, lastName];
        
        NSNumber *studid ;
        [results next];
        
        studid = [NSNumber numberWithInt: [results intForColumn:@"studentid"]];
        
        NSLog(@"Student ID is %@", studid);
        
        
        [results close];
        [dbase closeOpenResultSets];
        //Close database query
        
        NSLog(@"result %@ ",results);
        
        temp = [db getAttendanceForStudentWithDates:sortedDates student:studid];

        
        NSLog(@"temp is %@", temp);
        [result addObject:temp];
    }
    
    [dbase close];
    
    
    NSLog(@"%@", result);
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
        NSString *date2 = [formatter stringFromDate:date];
        NSLog(@"Date is %@", date2);
        [tempArray addObject:date2];
    }
    
    // sort the array of dates
    [tempArray sortUsingComparator:^NSComparisonResult(NSDate *date1, NSDate *date2) {
        // return date2 compare date1 for descending. Or reverse the call for ascending.
        return [date2 compare:date1];
    }];
    
    NSLog(@"Temp array is %@", tempArray);
    
    //Remove duplicate dates
    NSMutableArray *datesWithoutDuplicates = [tempArray valueForKeyPath:@"@distinctUnionOfObjects.self"];
    
    NSLog(@"Dates without duplicates is %@", datesWithoutDuplicates);
    return datesWithoutDuplicates;
    
}

-(NSMutableArray *) getSortedStudentNames: (ClassInfo *) theClass
{
    
    DatabaseAccess *db = [[DatabaseAccess alloc] init];
    NSMutableArray *students = [db getStudentsInClass: theClass];
    
    
    NSMutableArray *studentNames = [[NSMutableArray alloc] init];
    
    for(Student *s in students)
    {
        [studentNames addObject: [[s.firstName stringByAppendingString:@" "] stringByAppendingString: s.lastName ]];
    }
    
    [studentNames sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSLog(@"Array is %@", studentNames);
    
    return studentNames;
    
}




-(NSString *) createCSV:(ClassInfo *) theClass
{
    DatabaseAccess *db = [[DatabaseAccess alloc] init];
    
    //The list that contains the attendance dates and students registerd in a class.
    NSMutableArray *dates = [db getAttendance:theClass];
    
    //The sorted studnet names
    NSMutableArray *students = [self getSortedStudentNames:theClass];
    
    //Sorted dates
    NSMutableArray *sortedDates = [self getSortedDates:dates];

    NSMutableArray * dataArray = [self createDataArray:students dates:sortedDates];

    NSString *csv = [[NSString alloc] init];
    
    csv = [NSString stringWithFormat:@"Class:, %@\n", theClass.name];//Insert class name
    csv = [NSString stringWithFormat:@"%@Number of studnets enrolled: , %lu\n\n\n", csv, students.count];//Number of students
    
    csv = [NSString stringWithFormat:@"%@Names/Dates, %@\n",csv, [sortedDates componentsJoinedByString:@", "]];
    
    for (int i = 0; i < dataArray.count; i++) {
        csv = [NSString stringWithFormat:@"%@ %@, %@\n",csv, [students objectAtIndex:i], [[dataArray objectAtIndex:i] componentsJoinedByString:@", "]];
    }
    
    NSLog(@"CSV is \n %@", csv);
    
    return csv;
    
}






@end
