//
//  ImportHelper.m
//  SCDC
//
//  Created by Leen  on 4/11/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "ImportHelper.h"
#import "DatabaseAccess.h"
#import "Student.h"
#import "ClassInfo.h"
#import "FTPHelper.h"

@implementation ImportHelper


//Code that turns the CSV contents into a 2d array
-(NSMutableArray *) getCSVContents: (NSString *) csvFile
{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    NSArray *lines=[csvFile componentsSeparatedByString:@"\n"];
    
    for (NSString *line in lines) {
        
        NSArray *lineContents=[line componentsSeparatedByString:@","];
        
        [result addObject:lineContents];
    }
    
    return result;
}

-(void) importStudent: (NSMutableArray *) csvData
{
    FTPHelper *ftp = [[FTPHelper alloc]init];
    [ftp downloadStudents:self];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"students.csv"];
    
    NSString *csv = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
    
    NSMutableArray *csvArray = [self getCSVContents:csv];
    NSMutableArray *result = [self createStudentObjects:csvArray];
    [self addStudents:result];
}

-(void) importRegistration: (NSMutableArray *) csvData
{
    FTPHelper *ftp = [[FTPHelper alloc]init];
    [ftp downloadRegistration:self];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"registration.csv"];
    
    NSString *csv = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
    
    NSMutableArray *csvArray = [self getCSVContents:csv];
    
    [self addRegistration:csvArray];
}

-(void) importClasses: (NSMutableArray *) csvData
{
    FTPHelper *ftp = [[FTPHelper alloc]init];
    [ftp downloadClasses:self];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"classes.csv"];
    
    NSString *csv = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
    
    NSMutableArray *csvArray = [self getCSVContents:csv];
    
    NSMutableArray *result = [self createClassObjects:csvArray];
    
    [self addClasses:result];
}


-(NSMutableArray *) createStudentObjects:(NSMutableArray * ) csvData
{
    //Array that will hold student objects
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    //For line
    for (int i=0; i < csvData.count; i++) {
        
        //Get contents of line
        NSArray *studentInfo = csvData[i];
        
        //Init student
        Student *temp = [[Student alloc]init];
        
        temp.studentId = i;
        temp.firstName = studentInfo[0];
        temp.lastName = studentInfo[1];
        temp.email = studentInfo[2];
        temp.phone = studentInfo[3];
        
        
        [result addObject:temp];
        
        
        
    }
    
    return result;
}

-(NSMutableArray *) createClassObjects: (NSMutableArray * ) cvsData
{
    //Array that will class objects
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < cvsData.count; i++) {
        
        NSArray *classInfo = cvsData[i];
        
        //Init class
        ClassInfo *temp = [[ClassInfo alloc]init];
        
        //Add attributes to class
        temp.classId = i;
        temp.name = classInfo[0];
        temp.time = classInfo[1];
        temp.day = classInfo[2];
        temp.location = classInfo[3];
        temp.instructor = classInfo[4];
        temp.startDate = classInfo[5];
        temp.endDate = classInfo[6];
        temp.type = classInfo[7];
        
        //add class to the results array
        [result addObject:temp];
        
        
        
    }
    return result;
}

-(void) addClasses: (NSMutableArray * ) classes
{
    //Open Database
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    [db beginTransaction];
    
    BOOL success =  [db executeUpdate:@"DELETE *  FROM class"];
    [db commit];
    
    if (success){
        //Go through the list of students and record their attendance information to the db
        for (ClassInfo *s in classes)
        {
            
            //Add the attendance to dates
            [db executeUpdate:@"INSERT INTO class (classid, name_of_class, time, day, location, instructor,startDate, endDate, type) VALUES (?,?,?,?,?,?,?,?,?);", s.classId, s.name, s.time, s.day, s.location, s.instructor, s.startDate, s.endDate, s.type];
            
        }
        
        //Make the changes to the database and then close it.
        [db commit];
    }
    [db close];
    
    
}

-(void) addStudents: (NSMutableArray * ) students
{
    //Open Database
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    [db beginTransaction];
    
    BOOL success =  [db executeUpdate:@"DELETE *  FROM student"];
    [db commit];
    
    if (success) {
        
        //Go through the list of students and record their attendance information to the db
        for (Student *s in students)
        {
            //Add the attendance to dates
            [db executeUpdate:@"INSERT INTO student (studentid, firstname, lastname, email, phone) VALUES (?,?,?,?,?);", s.studentId, s.firstName, s.lastName, s.email, s.phone];
            
        }
        
        //Make the changes to the database and then close it.
        [db commit];
    }
    [db close];
    
    
}

-(void) addRegistration: (NSMutableArray * ) regData
{
    //Open Database
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    [db open];
    [db beginTransaction];
    
    BOOL success =  [db executeUpdate:@"DELETE *  FROM registration"];
    [db commit];
    
    if (success) {
        
        //Go through the list of students and record their attendance information to the db
        for (NSArray *s in regData)
        {
            //Add the attendance to dates
            [db executeUpdate:@"INSERT INTO registration (regId,student_id, class_ID) VALUES (?,?,?);", s[0], s[1], s[3]];
            
        }
        
        //Make the changes to the database and then close it.
        [db commit];
        
    }
    [db close];
    
}
@end
