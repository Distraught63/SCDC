//
//  DatabaseAccess.m
//  UItableView Example
//
//  Created by Leen  on 3/7/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "DatabaseAccess.h"

@implementation DatabaseAccess



/*Returns a list containing students registered in the class.
 
 Paramaters:
 theClass : A ClassInfo object that holds the class; Should not be null.
 
 @return: A list of students in that class
 */
-(NSMutableArray *) getStudentsInClass: (ClassInfo *) theClass
{
    if (theClass != NULL) {
        NSMutableArray *students =  [self getStudents];
        NSMutableArray *result = [[NSMutableArray alloc] init];
        
        //Open Database
        FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open];
        
        //Get the classID
        NSNumber *classID = [NSNumber numberWithInt:theClass.classId ];
        
        //Get data
        FMResultSet *results = [db executeQuery:@"select * from registration where class_ID =?", [classID stringValue]];
        
        
        
        //Iterate through each row
        while([results next])
        {
            NSLog(@"Found students in class");
            
            //Iterate through each student
            for (Student *s in students) {
                
                //Get the studentid of s
                int studentId = [results intForColumn:@"student_ID"];
                
                //Add s to the result if it matches the studentid of s
                if (s.studentId == studentId) {
                    
                    [result addObject: s];
                    
                }
            }
            
        }
        
       
//        NSLog(@"Number of students in class is %lu", result.count);
        
        //Close database
        [results close];
        [db close];
        
        return result;
        
    }
    return  NULL;
}


/*Gets the list of classes from the database
 @return: A mutable array that contains classInfo objects*/
-(NSMutableArray *) getClasses
{
    NSMutableArray *classes = [[NSMutableArray alloc] init];
    
    
    //Open Database
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    
    
    
    FMResultSet *results = [db executeQuery:@"select * from class"];
    
    
    //Iterate through rows in table
    while([results next])
    {
        //Create new class
        ClassInfo *class = [[ClassInfo alloc] init];
        
        //Add class information
        
        //Note: could use stringForColumnIndex instead of stringForColumn. Example commented out in instructor
        //Class id
        class.classId = [results intForColumn:@"classid"];
        
        //Class name
        class.name = [results stringForColumn:@"name_of_class"];
        
        //Time
        class.time = [results stringForColumn:@"time"];
        
        //Day
        class.day = [results stringForColumn:@"day"];
        
        //Location
        class.location = [results stringForColumn:@"location"];
        
        //Instructor
        //        class.instructor = [results stringForColumn:@"instructor"];
        class.instructor = [results stringForColumnIndex:5];
        
        //startDate
        class.startDate = [results stringForColumn:@"startDate"];
        
        //endDate
        class.endDate = [results stringForColumn:@"endDate"];
        
        //Class type
        class.type = [results stringForColumn:@"type"];
        
        
        
        //Add class to the list of classes
        [classes addObject:class];
        
    }
    
    //Close database
    [results close];
    [db close];
    
    
    return classes;
    
}

/*Gets a list of all students
 @return: A mutable array of Student objects*/
-(NSMutableArray *) getStudents
{
    NSMutableArray *students = [[NSMutableArray alloc] init];
    
    
    //Open Database
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    
    //Get students from database
    FMResultSet *results = [db executeQuery:@"select * from student"];
    
    
    //Iterate through rows in table
    while([results next])
    {
        //Create new student (object)
        Student *student = [[Student alloc] init];
        
        //Add student information
        
        //Note: could use stringForColumnIndex instead of stringForColumn. Example commented out in instructor
        //Class id
        student.studentId = [results intForColumn:@"studentid"];
        
        //first name
        student.firstName = [results stringForColumn:@"firstname"];
        
        //last name
        student.lastName = [results stringForColumn:@"lastname"];
        
        //Email address
        student.email = [results stringForColumn:@"email"];
        
        //Phone number
        student.phone= [results stringForColumn:@"phone"];
        
        
        //Add class to the list of classes
        [students addObject:student];
        
    }
    
    //Close database
    [results close];
    [db close];
    
    return students;
    
}

/*Updates the attendace of the class passed
  Paramaters: 
        students: An array of students that contains their attendance information(attendedClass)
 
        theClass: The class we are taking attendance for
                */
-(BOOL) updateAttendance : (NSMutableArray *) students   theClass:(ClassInfo *) theClass
{
    
    //Set the date format
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    
    [dateformate setDateFormat:@"MM/dd/YYYY"];
    
    //Get the class id
    NSNumber *classID = [NSNumber numberWithInt:theClass.classId ];
    
    //Get the current date with the format specified above
    NSString *date_String=[dateformate stringFromDate:[NSDate date]];
    
    
    NSLog(@"Today's date is: %@ and class id is %@", date_String, classID);
    
    
    
    //Open Database
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    [db beginTransaction];
    
    //Go through the list of students and record their attendance information to the db
    for (Student *s in students)
    {
        //If the student attended class, add the students and date to dates
        if (s.attendedClass) {
            //Add the attendance to dates
            [db executeUpdate:@"INSERT INTO dates (class_id,student_ID, date) VALUES (?,?,?);", classID,[ NSNumber numberWithInt:s.studentId], date_String];
            
        }
    }
    
    //Make the changes to the database and then close it.
    [db commit];
    [db close];
    
    return YES;
}


/*Get the attendance information for the class (attendace information is stored in dates)
 
 Paramaters:
    theClass: The class we are taking attendance for
 
 @return: A mutable array containing Date objects (the attendance info)
 */
-(NSMutableArray *) getAttendance:(ClassInfo *) theClass
{
    //Open Database
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    
    
    NSNumber *classID = [NSNumber numberWithInt:theClass.classId ];
    
    NSLog(@"Class id is %@", classID);
    
    FMResultSet *results = [db executeQuery:@"select * from dates where class_id =?", [classID stringValue]];
    //    FMResultSet *results = [db executeQuery:@"select * from dates"];
    
    //Where the attendance information will be stored.
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    
    //Iterate through rows in table
    while([results next])
    {
        //Create new Date
        Dates *date = [[Dates alloc] init];
        
        
        //Class name
        date.date = [results stringForColumn:@"date"];
        
        //student_ID
        date.student_id = [results intForColumn:@"student_ID"];
        
        
        //Add date to the list of dates
        [dates addObject:date];
        
    }
    
    //Close database
    [results close];
    [db close];
    
    return dates;
}

/*Returns the  student attendance information for the list of dates provided
 
 Parameters:
    studid: The id of the student
    dates: The list of dates
 
 @return: An array that contains 0's(didn't attend class) or 1's(attended class) depending on whether the student attended class.
 
 Method description:
 
 For each date in dates the method searches the table dates for a
    match for the studentid/date combination, if it finds a match, it adds a 1 to the list,
 zero otherwise. The order of the list generated corresponds to the order of dates, as to insure the correctness of the method.
 */
-(NSMutableArray *)getAttendanceForStudentWithDates:(NSMutableArray *)dates student: (NSNumber *) studid
{
    
    //Open Database
    FMDatabase *dbase = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [dbase open];
    
    //Close all queries just in case
    [dbase closeOpenResultSets];
    
    //Numbers that symbloize whether student attended class in a certian date.
    NSNumber *one = [NSNumber numberWithInt: 1];//indicates that the student attended class that date
    NSNumber *zero = [NSNumber numberWithInt: 0 ];//indicates that the students didn't attned
    
    NSMutableArray *temp =[[NSMutableArray alloc] init];
    
    // create the date formatter with the correct format
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    for (NSDate *date in dates)
    {
        
        //We assume the result of the set is going to be either 1 or empty
        FMResultSet *results = [dbase executeQuery:@"select * from dates where student_ID=? AND date=?", [studid stringValue], date];
        
        if ([results next]) {
            [temp addObject:one];//Found a match, add one to the list
        }
        
        else
        {
            [temp addObject:zero];//No reslults, add zero to the list.
        }
        
        
    }
    
    
    //Close database
    [dbase closeOpenResultSets];
    [dbase close];
    
    return temp;
}

@end
