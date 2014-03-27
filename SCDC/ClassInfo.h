//
//  ClassInfo.h
//  SCDC
//
//  Created by Leen  on 3/27/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <Foundation/Foundation.h>

//Couldn't name it Class, because it's a reserved key.
@interface ClassInfo : NSObject

//From schema
@property (nonatomic,assign) int classId;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *day;
@property (nonatomic,strong) NSString *location;
@property (nonatomic,strong) NSString *instructor;


@end
