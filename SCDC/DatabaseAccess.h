//
//  DatabaseAccess.h
//  UItableView Example
//
//  Created by Leen  on 3/7/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClassesViewController.h"
#import "FMDatabase.h"
#import "DatabaseAccess.h"
#import "ClassInfo.h"
#import "Student.h"
#import "Dates.h"
#import "Utility.h"


@interface DatabaseAccess : NSObject


-(NSMutableArray *) getClasses;

-(NSMutableArray *) getStudentsInClass: (ClassInfo *) theClass;

//Will be implement later
//-(BOOL) insertStudent:(Student *) student;
//-(BOOL) updateStudent:(Student *) student;
-(BOOL) updateAttendance : (NSMutableArray *) students   theClass:(ClassInfo *) theClass;

-(NSMutableArray *) getAttendance:(ClassInfo *) theClass;

-(NSMutableArray *)getAttendanceForStudentWithDates:(NSMutableArray *)dates student: (NSNumber *) studid;

@end
