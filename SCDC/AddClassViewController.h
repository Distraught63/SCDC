//
//  AddClassViewController.h
//  SCDC
//
//  Created by Leen  on 4/25/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddClassViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *ClassName;
@property (weak, nonatomic) IBOutlet UITextField *Teacher;
@property (weak, nonatomic) IBOutlet UITextField *Time;
@property (weak, nonatomic) IBOutlet UITextField *Day;
@property (weak, nonatomic) IBOutlet UITextField *Location;


@end
