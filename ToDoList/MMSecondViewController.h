//
//  MMSecondViewController.h
//  ToDoList
//
//  Created by Kyle Mai on 9/24/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTextDelegate.h"
#import "MMViewController.h"

@interface MMSecondViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) id <MMTextDelegate> delegate;


@property (strong, nonatomic) IBOutlet UILabel *oldNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *newnameTextField;
@property (strong, nonatomic) NSString *oldNameString;
@property NSInteger rowID;

- (IBAction)changeNameAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
@end
