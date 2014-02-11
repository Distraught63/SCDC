//
//  aClass.h
//  SCDC
//
//  Created by Leen  on 2/9/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface aClass : NSObject

@property (copy) NSString *name;
@property (copy) NSString *location;
@property (copy) NSString *startDate;//@property (copy) NSDate *startDate;//Later it will be a date object.
@property (copy) NSString *endtDate;//@property (copy) NSDate *endtDate;

@property (copy) NSString *instructor;




@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;



@end
