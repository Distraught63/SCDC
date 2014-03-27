//
//  ClassesViewController.h
//  SCDC
//
//  Created by Veena Dali on 2/21/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseAccess.h"
#import "FTPHelper.h"
#import "FMDatabase.h"
#import "Utility.h"

@interface ClassesViewController : UITableViewController
{
}



@property (nonatomic,strong) NSMutableArray *classes;

//Gets the array of classes
-(void) populateClasses;

//Navigate back to this view
- (IBAction)unwindToClassess:(UIStoryboardSegue *)segue;

//Refresh the view when the download is complete
-(void) ftpDidFinishRefreshing;

@end
