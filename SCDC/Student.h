//
//  Student.h
//  SCDC
//
//  Created by Leen  on 3/27/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject


//From schema
@property (nonatomic,assign) int studentId;

//Name can't be modified, limited to 20 characters
//How to limit the string to follow schema?
@property (readonly,retain) NSString *firstName;
@property (readonly,retain) NSString *lasttName;

@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *location;

@end
