//
//  ClassesViewController.h
//  SCDC
//
//  Created by Veena Dali on 2/21/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassesViewController : UITableViewController
{
     NSArray *name;
}
- (IBAction)unwindClassess:(UIStoryboardSegue *)segue;



@end
