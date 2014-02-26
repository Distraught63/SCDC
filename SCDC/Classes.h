//
//  Classes.h
//  SCDC
//
//  Created by Leen  on 2/9/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Classes : NSObject

@property (strong,nonatomic)  NSMutableArray *listOfclassesWithInfo;//A 2D array that contains a list that contains all the info of the classes.
@property (strong, nonatomic) NSMutableArray *listOfClasses; //A list that contain aClass objects


- (void) addListOfClassesObject:(NSString *)classInfo;
@end
//test 