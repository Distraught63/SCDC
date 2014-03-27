//
//  Dates.h
//  SCDC
//
//  Created by Leen  on 3/27/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dates : NSObject

//From schema
@property (nonatomic) int date;//Primary key

//References the studentId from Student, i.e id has to
//exist in student.
@property (nonatomic) int student_id;

@end
