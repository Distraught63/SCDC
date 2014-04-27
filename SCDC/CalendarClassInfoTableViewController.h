//
//  CalendarClassInfoTableViewController.h
//  SCDC
//
//  Created by Leen  on 4/27/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassesInfoViewControllerDelegate;
@class CalendarViewController;

@interface CalendarClassInfoTableViewController : UITableViewController
{
    id<ClassesInfoViewControllerDelegate> delegate;
}


@property (nonatomic,strong) NSMutableArray *classes;

@property (nonatomic,strong) NSDate *date;

@property (retain) id delegate;

@end


@protocol ClassesInfoViewControllerDelegate <NSObject>

- (void)dismiss:(BOOL)finished;

@end
