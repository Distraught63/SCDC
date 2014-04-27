//
//  ExportHelper.m
//  SCDC
//
//  Created by Leen  on 3/29/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "ExportHelper.h"




@implementation ExportHelper



/*Exports an attendance sheet to the ftp server, also writes the file in the app'sdocuments directory*/
-(void) exportAttendance:(ClassInfo *) theClass
{
    
    //Get the csv file
    NSString *csv = [self createCSV:theClass];
    
    //Get path to documents directory to store the csv file
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@AttendanceSheet.csv", theClass.name];
    
    //Final path of the file.
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    //Write the csv file to path.
    [csv writeToFile:path atomically:YES encoding:NSASCIIStringEncoding error:NULL];
    
    
    //Upload the file
    FTPHelper *ftp = [[FTPHelper alloc] init];
    
    [ftp uploadCSV:path fileName:fileName];
    
    
}

- (void) exportAll
{
    DatabaseAccess *db  = [[DatabaseAccess alloc] init];
    
    NSMutableArray *classes = [db getClasses];
    
    for (ClassInfo *c in classes) {
        [self exportAttendance: c];
    }
}


/*Creates a 2d array that contans the attendance information.
 
 Parameters:
 sortedStudents: An array that contains a list of sorted students of type NSString
 dates: An array that contains a list of sorted dates of type NSString
 
 @return: A 2d array that contains attendance information for each student
 */
-(NSMutableArray *) createDataArray:(NSMutableArray *) sortedStudents dates:(NSMutableArray *) sortedDates
{
    DatabaseAccess *db = [[DatabaseAccess alloc] init];
    
    
    //The array that contains the attendance information in a matrix style.
    NSMutableArray *result =[[NSMutableArray alloc] init];
    
    
    //Open Database
    FMDatabase *dbase = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [dbase open];
    
    //For each student get the attendance by checking the student against the list of dates
    for(NSString *s in sortedStudents)
    {
        
        //Break the name into first name and last name. To query the student for the id.
        NSArray *name = [s componentsSeparatedByString:@" "];
        
        NSString *firstName = [name objectAtIndex:0]; //first name
        NSString *lastName = [name objectAtIndex:1]; // last name
        
        //The array that will hold the attendance information for the student.
        NSMutableArray *temp =[[NSMutableArray alloc] init];
        
        //Database query
        FMResultSet *results = [dbase executeQuery:@"select * from student where firstname=? and lastname=?", firstName, lastName];
        
        NSNumber *studid;
        [results next];
        
        //Store the id for the dtuent
        studid = [NSNumber numberWithInt: [results intForColumn:@"studentid"]];
        
        
        //Close database query
        [results close];
        [dbase closeOpenResultSets];
        
        //Get the attendance information for the current student
        temp = [db getAttendanceForStudentWithDates:sortedDates student:studid];
        
        //Add the attendance array to the result array.
        [result addObject:temp];
    }
    
    //Close the database.
    [dbase close];
    
    return result;
    
}

/*Returns a list of sorted dates without duplicates from a list of dates.*/
-(NSMutableArray *) getSortedDates: (NSMutableArray *) dates
{
    
    // create the date formatter with the correct format
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSMutableArray * tempArray = [[NSMutableArray alloc] init];
    
    //Copy over the date part of the Date object.
    for (Dates *d in dates) {
        NSString *date = d.date;
        [tempArray addObject:date];
    }
    
    //Dates without duplicates
    NSArray *tempA = [[NSSet setWithArray:tempArray] allObjects];
    NSMutableArray *dateStrings = [NSMutableArray arrayWithArray:tempA];
    
    
    // sort the array of dates
    [dateStrings sortUsingComparator:^NSComparisonResult(NSString *date1, NSString *date2) {
        // return date2 compare date1 for descending. Or reverse the call for ascending.
        return [[formatter dateFromString:date1] compare: [formatter dateFromString:date2]];
    }];
    
    
    //    NSLog(@"SortedDatesArray is %@", dateStrings);
    
    return dateStrings;
    
}

-(NSMutableArray *) getSortedStudentNames: (ClassInfo *) theClass
{
    
    DatabaseAccess *db = [[DatabaseAccess alloc] init];
    
    //Get the list of students in class
    NSMutableArray *students = [db getStudentsInClass: theClass];
    
    
    NSMutableArray *studentNames = [[NSMutableArray alloc] init];
    
    //Store the students full name "firstname lasrname" seperate firstname and lastname by a space.
    for(Student *s in students)
    {
        [studentNames addObject: [[s.firstName stringByAppendingString:@" "] stringByAppendingString: s.lastName ]];
    }
    
    //Sort the students full name
    [studentNames sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    //    NSLog(@"StudentNamesArray is %@", studentNames);
    
    return studentNames;
    
}




/*Creates the CSV file for the class and returns it.
 
 Paramaters:
 theClass: The class that we want to get the attendance sheet for.
 
 Method:
 gets the 2d data array of the attendance and converts each inner array into a line and appends it to the csv string.
 
 The correctness of the attendance sheet was verified by hand
 
 @return: the csv string ... not yet saved as a file.
 */
-(NSString *) createCSV:(ClassInfo *) theClass
{
    DatabaseAccess *db = [[DatabaseAccess alloc] init];
    
    //The list that contains the attendance dates and students registerd in a class.
    NSMutableArray *dates = [db getAttendance:theClass];
    
    //The sorted studnet names
    NSMutableArray *students = [self getSortedStudentNames:theClass];
    
    //Sorted dates
    NSMutableArray *sortedDates = [self getSortedDates:dates];
    
    //Get the data array
    NSMutableArray * dataArray = [self createDataArray:students dates:sortedDates];
    
    NSString *csv = [[NSString alloc] init];
    
    //Class information
    csv = [NSString stringWithFormat:@"Class:, %@\n", theClass.name];//Insert class name
    csv = [NSString stringWithFormat:@"%@Number of Students Enrolled: , %lu\n\n\n", csv, (unsigned long)students.count];//Number of students
    
    //The column headers
    csv = [NSString stringWithFormat:@"%@Names/Dates, %@\n",csv, [sortedDates componentsJoinedByString:@", "]];
    
    //The attendance information.
    for (int i = 0; i < dataArray.count; i++) {
        csv = [NSString stringWithFormat:@"%@ %@, %@\n",csv, [students objectAtIndex:i], [[dataArray objectAtIndex:i] componentsJoinedByString:@", "]];
    }
    
    NSLog(@"CSV is \n %@", csv);
    
    return csv;
    
}






@end
