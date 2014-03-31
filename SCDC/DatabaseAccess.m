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



//
//-(BOOL) updateCustomer:(Customer *)customer
//{
//    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
//
//    [db open];
//
//    BOOL success = [db executeUpdate:[NSString stringWithFormat:@"UPDATE customers SET firstname = '%@', lastname = '%@' where id = %d",customer.firstName,customer.lastName,customer.customerId]];
//
//    [db close];
//
//    return success;
//}
//
//-(BOOL) insertCustomer:(Customer *) customer
//{
//    // insert customer into database
//
//    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
//
//    [db open];
//
//    BOOL success =  [db executeUpdate:@"INSERT INTO customers (firstname,lastname) VALUES (?,?);",
//                     customer.firstName,customer.lastName, nil];
//    
//    NSLog(@"Customer has been inserted into the database");
//
//    [db close];
//
//    return success;
//
//    return YES;
//}
//



-(NSMutableArray *) getStudentsInClass: (ClassInfo *) theClass
{
    
    NSMutableArray *students =  [self getStudents];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    //Open Database
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    
    NSNumber *classID = [NSNumber numberWithInt:theClass.classId ];
    NSLog(@"class ID is %@", classID);
    
    NSString *query = [@"select * from registration where class_ID = " stringByAppendingString: [classID stringValue]];
    
    NSLog(@"Query is %@", query);
    
    //Get data
//    FMResultSet *results = [db executeQuery:@"select * from registration where classID = %d",classID];
    FMResultSet *results = [db executeQuery:query];
    
    
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
    
    [db close];
    
    return students;
    
}


-(BOOL) updateAttendance : (NSMutableArray *) students;
{
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    
    [dateformate setDateFormat:@"MM/dd/YYYY"];
    
    NSString *date_String=[dateformate stringFromDate:[NSDate date]];
    
    NSLog(@"Today's date is: %@", date_String);
    
    //Open Database
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    
    for (Student *s in students)
    {
        [db executeUpdate:@"INSERT INTO dates (date,student_ID) VALUES (?,?);", [ NSNumber numberWithInt:s.studentId], date_String];

    }
    
    [db close];

    return YES;
}


-(NSMutableArray *) getAttendance:(ClassInfo *) theClass
{
    //Open Database
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    
    
    NSNumber *classID = [NSNumber numberWithInt:theClass.classId ];
    
    NSString *query = [@"select * from dates where class_id = " stringByAppendingString: [classID stringValue]];
    
    
    FMResultSet *results = [db executeQuery:query];
    
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
        
        
        
        //Add class to the list of classes
        [dates addObject:date];
        
    }
    
    [db close];
    
    return dates;
}
@end
