//
//  DatabaseAccess.m
//  UItableView Example
//
//  Created by Leen  on 3/7/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "DatabaseAccess.h"
#import "Utility.h"

@implementation DatabaseAccess



-(NSMutableArray *) getStudentsInClass: (ClassInfo *) theClass
{
    
    NSMutableArray *students =  [self getStudents];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    //Open Database
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    
    NSNumber *classID = [NSNumber numberWithInt:theClass.classId ];
    NSLog(@"class ID is %@", classID);
    
    //    NSString *query = [@"select * from registration where class_ID = " stringByAppendingString: [classID stringValue]];
    //
    //    NSLog(@"Query is %@", query);
    
    //Get data
    FMResultSet *results = [db executeQuery:@"select * from registration where class_ID =?", [classID stringValue]];
    
    
    while([results next])
    {
        
        for (Student *s in students) {
            
            int studentId = [results intForColumn:@"student_ID"];
            //            NSNumber *studentId = [NSNumber numberWithInt:temp];
            
            //            Student *tempStudent =[students objectAtIndex:temp ];
            if (s.studentId == studentId) {
                
                [result addObject: s];
                
            }
        }
        
    }
    
    NSLog(@"Number of students in class is %lu", result.count);
    
    [results close];
    [db close];
    
    return result;
}


-(NSMutableArray *) getClasses
{
    NSMutableArray *classes = [[NSMutableArray alloc] init];
    
    
    //Open Database
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    
    
    
    //        [db executeUpdate:@"INSERT INTO customers (firstname,lastname) VALUES (?,?);", @"Leen", @"Alshenibr", nil];
    
    
    FMResultSet *results = [db executeQuery:@"select * from class"];
    
    //Number of columns
    NSLog(@"Number of columns in classes is : %d",results.columnCount);
    
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
        
        
        
        //Add class to the list of classes
        [classes addObject:class];
        
    }
    
    [results close];
    [db close];
    
    
    return classes;
    
}

-(NSMutableArray *) getStudents
{
    NSMutableArray *students = [[NSMutableArray alloc] init];
    
    
    //Open Database
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    
    //Get students from database
    FMResultSet *results = [db executeQuery:@"select * from student"];
    
    //Number of columns
    NSLog(@"Number of columns in classes is : %d",results.columnCount);
    
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
    
    [results close];
    [db close];
    
    return students;
    
}


-(BOOL) updateAttendance : (NSMutableArray *) students   theClass:(ClassInfo *) theClass
{
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    
    [dateformate setDateFormat:@"MM/dd/YYYY"];
    
    NSNumber *classID = [NSNumber numberWithInt:theClass.classId ];
    
    NSString *date_String=[dateformate stringFromDate:[NSDate date]];
    
    NSLog(@"Today's date is: %@ and class id is %@", date_String, classID);
    
    
    
    //Open Database
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    [db beginTransaction];
    
    for (Student *s in students)
    {
        
        if (s.attendedClass) {
            [db executeUpdate:@"INSERT INTO dates (class_id,student_ID, date) VALUES (?,?,?);", classID,[ NSNumber numberWithInt:s.studentId], date_String];
            
            
            NSLog(@"Attendance updated for student %d", s.studentId);
        }
    }
    
    [db commit];
    [db close];
    
    return YES;
}


-(NSMutableArray *) getAttendance:(ClassInfo *) theClass
{
    //Open Database
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    
    
    NSNumber *classID = [NSNumber numberWithInt:theClass.classId ];
    
    NSLog(@"Class id is %@", classID);
    
    FMResultSet *results = [db executeQuery:@"select * from dates where class_id =?", [classID stringValue]];
    //    FMResultSet *results = [db executeQuery:@"select * from dates"];
    
    NSMutableArray *dates = [[NSMutableArray alloc] init];
    
    //Iterate through rows in table
    while([results next])
    {
        NSLog(@"Found date with class id %d", [results intForColumn:@"class_id"]);
        //Create new Date
        Dates *date = [[Dates alloc] init];
        
        
        //Class name
        date.date = [results stringForColumn:@"date"];
        
        //student_ID
        date.student_id = [results intForColumn:@"student_ID"];
        
        
        NSLog(@"Added date to dates: student_id is %d", date.student_id);
        
        //Add class to the list of classes
        [dates addObject:date];
        
    }
    
    [results close];
    [db close];
    
    NSLog(@"Get attendance returns %@", dates);
    
    return dates;
}

-(NSMutableArray *)getAttendanceForStudentWithDates:(NSMutableArray *)dates student: (NSNumber *) studid
{
    
    //Open Database
    FMDatabase *dbase = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [dbase open];
    [dbase closeOpenResultSets];
    //Numbers that symbloize whether student attended class in a certian date.
    NSNumber *one = [NSNumber numberWithInt: 1];//indicates that the student attended class that date
    NSNumber *zero = [NSNumber numberWithInt: 0 ];//indicates that the students didn't attned
    
    NSMutableArray *temp =[[NSMutableArray alloc] init];
    
    for (NSString *date in dates)
    {
        
        NSLog(@"Enterd date for loop");
        
        NSLog(@"Studid is %@", studid);
        NSLog(@"Date is %@", date);
        
        
        //We assume the result of the set is going to be either 1 or empty
        FMResultSet *results = [dbase executeQuery:@"select * from dates where student_ID=? AND date=?", [studid stringValue], date];
        
        
        if ([results next]) {
            [temp addObject:one];
        }
        
        else
        {
            [temp addObject:zero];
        }
        
//        while ([results next]) {
//            
//            NSLog(@"Entered results2");
//            NSLog(@"Date is %@", [results stringForColumn:@"date"]);
//            
//            if ( [[results stringForColumn:@"date"] isEqualToString:date]) {
//                [temp addObject:one];
//            } else {
//                [temp addObject:zero];
//            }
//            
//        }
    }
    
    
    [dbase closeOpenResultSets];
    [dbase close];
    
    return temp;
}

@end
