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
#import "Utility.h"

@implementation ImportHelper

@synthesize db;


-(void) importAll
{
    db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    
    NSLog(@"ImportAll was called");
    
    //Import Class List
    [self importClasses];
    
    //Import Students List
    [self importStudent];
    
    
    //Import Registration List
    [self importRegistration];
    
    FTPHelper *ftp = [[FTPHelper alloc]init];
    
    [ftp uploadFile];
    
    
}

-(void) importClasses
{
    FTPHelper *ftp = [[FTPHelper alloc]init];
    [ftp downloadClasses:self];
    
    //Path of downloaded file
    NSString *path = [Utility getClassesPath];
    
    NSString *csv = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
    
    NSMutableArray *csvArray = [self getCSVContents:csv];
    
    NSMutableArray *result = [self createClassObjects:csvArray];
    
    [self addClasses:result];
}



-(void) importStudent
{
    FTPHelper *ftp = [[FTPHelper alloc]init];
    [ftp downloadStudents:self];
    
    //Path of downloaded file
    NSString *path = [Utility getStudentsPath];
    
    NSString *csv = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
    
    NSMutableArray *csvArray = [self getCSVContents:csv];
    NSMutableArray *result = [self createStudentObjects:csvArray];
    [self addStudents:result];
}

-(void) importRegistration
{
    FTPHelper *ftp = [[FTPHelper alloc]init];
    [ftp downloadRegistration:self];
    
    //Path of downloaded file
    NSString *path = [Utility getRegistrationPath];
    
    NSString *csv = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
    
    NSMutableArray *csvArray = [self getCSVContents:csv];
    
    [self addRegistration:csvArray];
}

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


-(NSMutableArray *) createStudentObjects:(NSMutableArray * ) csvData
{
    //Array that will hold student objects
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    //For line
    for (int i=1; i < csvData.count; i++) {
        
        //Get contents of line
        NSArray *studentInfo = csvData[i];
        
        //Init student
        Student *temp = [[Student alloc]init];
        
        temp.studentId = [studentInfo[0] intValue];
        temp.firstName = studentInfo[1];
        temp.lastName = studentInfo[2];
        temp.email = studentInfo[3];
        temp.phone = studentInfo[4];
        
        
        
        [result addObject:temp];
        
        
        
    }
    
    return result;
}

-(NSMutableArray *) createClassObjects: (NSMutableArray * ) cvsData
{
    //Array that will class objects
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    for (int i = 1; i < cvsData.count; i++) {
        
        NSArray *classInfo = cvsData[i];
        
        //Init class
        ClassInfo *temp = [[ClassInfo alloc]init];
        
        //Add attributes to class
        temp.classId = [classInfo[0] intValue];
        
        temp.name = classInfo[1];
        temp.time = classInfo[2];
        temp.day = classInfo[3];
        temp.location = classInfo[4];
        temp.instructor = classInfo[5];
        temp.startDate = classInfo[6];
        temp.endDate = classInfo[7];
        temp.type = classInfo[8];
        
        //add class to the results array
        [result addObject:temp];
        
        
        
    }
    return result;
}

-(void) addClasses: (NSMutableArray * ) classes
{
    
    NSLog(@"Imported Classes array is of size %lu", (unsigned long)[classes count]);
    //Open Database
    //    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    
    
    if ([classes count] > 0) {
        
        
        [db open];
        [db beginTransaction];
        
        BOOL success =  [db executeUpdate:@"DELETE FROM class"];
        
        [db commit];
        
        if (success){
            //Go through the list of students and record their attendance information to the db
            for (ClassInfo *s in classes)
            {
                
                NSLog(@"Class ID is %d", s.classId);
                
                //Add the attendance to dates
                [db executeUpdate:@"INSERT INTO class (classid, name_of_class, time, day, location, instructor,startDate, endDate, type) VALUES (?,?,?,?,?,?,?,?,?);", [NSNumber numberWithInt: s.classId], s.name, s.time, s.day, s.location, s.instructor, s.startDate, s.endDate, s.type];
                
            }
            
            //Make the changes to the database and then close it.
            [db commit];
        }
        [db close];
        
    }
    
    NSLog(@"Import classes unsuccesful/or no data to import");
    
    
}

-(void) addStudents: (NSMutableArray * ) students
{
    //Open Database
    //    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    
    if ([students count] > 0) {
        
        
        [db open];
        [db beginTransaction];
        
        BOOL success =  [db executeUpdate:@"DELETE  FROM student"];
        [db commit];
        
        if (success) {
            
            //Go through the list of students and record their attendance information to the db
            for (Student *s in students)
            {
                //Add the attendance to dates
                [db executeUpdate:@"INSERT INTO student (studentid, firstname, lastname, email, phone) VALUES (?,?,?,?,?);", [NSNumber numberWithInt:s.studentId], s.firstName, s.lastName, s.email, s.phone];
                
            }
            
            //Make the changes to the database and then close it.
            [db commit];
        }
        [db close];
    }
    
    NSLog(@"Import students unsuccesful/or no data to import");
    
    
}

-(void) addRegistration: (NSMutableArray * ) regData
{
    
    if ([regData count] > 0) {
        
        //Open Database
        //    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
        
        [db open];
        [db beginTransaction];
        
        BOOL success =  [db executeUpdate:@"DELETE  FROM registration"];
        
        NSLog(@"Size of reg is %lu", (unsigned long)[regData count]);
        
        [db commit];
        
        //Remove the first line
        //   [regData removeObjectAtIndex:0];
        
        if (success) {
            
            //Go through the list of students and record their attendance information to the db
            for (NSArray *s in regData)
            {
                
                if (s != nil) {
                    
                    NSLog(@"Size of reg is %lu", (unsigned long)[regData count]);
                    
                    NSLog(@"Student id is %@", s[0]);
                    //Add the attendance to dates
                    [db executeUpdate:@"INSERT INTO registration (regId,student_id, class_ID) VALUES (?,?,?);", s[0], s[1], s[2]];
                }
                
            }
            
            //Make the changes to the database and then close it.
            [db commit];
            
        }
        [db close];
    }
    
    NSLog(@"Import registration unsuccesful/or no data to import");
    
}
@end
