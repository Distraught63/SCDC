//
//  AddStudentViewController.h
//  SCDC
//
//  Created by Leen  on 4/25/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddStudentViewController : UIViewController <UITextFieldDelegate>
//@property  UITextField *FirstName;
@property (weak, nonatomic) IBOutlet UITextField *FirstName;
//@property UITextField *LastName;
//@property UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *LastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@end
