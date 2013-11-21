//
//  MMSecondViewController.m
//  ToDoList
//
//  Created by Kyle Mai on 9/24/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import "MMSecondViewController.h"

@interface MMSecondViewController ()

@end

@implementation MMSecondViewController
@synthesize delegate;
@synthesize newnameTextField;
@synthesize rowID;
@synthesize oldNameLabel;
@synthesize oldNameString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    newnameTextField.delegate = self;
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editItem)];
    
    [self.navigationItem setRightBarButtonItem:editButton];
    
    
}

- (void)editItem
{
    newnameTextField.textAlignment = NSTextAlignmentLeft;
    [newnameTextField setEnabled:YES];
    [newnameTextField becomeFirstResponder];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditItem)];
    
    [self.navigationItem setRightBarButtonItem:doneButton];
}

- (void)doneEditItem
{
    [self changeNameAction:nil];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editItem)];
    
    [self.navigationItem setRightBarButtonItem:editButton];
    
    newnameTextField.textAlignment = NSTextAlignmentCenter;
    [newnameTextField setEnabled:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self doneEditItem];
    
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    oldNameLabel.text = @"";
    newnameTextField.text = oldNameString;
    newnameTextField.textAlignment = NSTextAlignmentCenter;
    [newnameTextField setEnabled:NO];
}

- (IBAction)changeNameAction:(id)sender
{
    [delegate changeObjectName:newnameTextField.text objectAtRow:rowID];
}

- (IBAction)cancelAction:(id)sender
{
}
@end
