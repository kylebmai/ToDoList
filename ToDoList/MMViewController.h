//
//  MMViewController.h
//  ToDoList
//
//  Created by Kyle Mai on 9/24/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTextDelegate.h"
#import "MMSecondViewController.h"
@interface MMViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MMTextDelegate, UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *toDoListArray;
@property (strong, nonatomic) NSMutableArray *checkedOffArray;



- (IBAction)addToListAction:(id)sender;

@end
