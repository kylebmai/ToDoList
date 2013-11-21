//
//  MMViewController.m
//  ToDoList
//
//  Created by Kyle Mai on 9/24/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import "MMViewController.h"


@interface MMViewController ()
{

}

@property (retain, nonatomic) MMSecondViewController *secondVC;

@end

@implementation MMViewController
@synthesize secondVC;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _toDoListArray = [[NSMutableArray alloc] init];
    _checkedOffArray = [[NSMutableArray alloc] init];
    _textField.delegate = self;
    
    [_textField becomeFirstResponder];
    
    //secondVC = [[MMSecondViewController alloc] initWithNibName:nil bundle:nil];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editTable)];
    
    [self.navigationItem setRightBarButtonItem:editButton];
}

- (void)editTable
{
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditTable)];
    
    [self.navigationItem setRightBarButtonItem:doneButton];
    
    [self.tableView setEditing:YES];
}

- (void)doneEditTable
{
    [self.tableView setEditing:NO];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editTable)];
    
    [self.navigationItem setRightBarButtonItem:editButton];
}

- (void)changeObjectName:(NSString *)string objectAtRow:(NSInteger)row
{
    [self.toDoListArray replaceObjectAtIndex:row withObject:string];
    [self.tableView reloadData];
    
    NSLog(@"changeObjectName ViewController Called %@", _toDoListArray);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    headerLabel.backgroundColor = [UIColor lightGrayColor];
    headerLabel.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size:15.0];
    headerLabel.textColor = [UIColor whiteColor];
    
    if (section == 0) {
        headerLabel.text = @"   Todo List";
    }
    else
        headerLabel.text = @"   Don't Worry About List";
    
    return headerLabel;
}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0)
//    {
//        return @"Todo List";
//    }
//    else
//        return @"Done";
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [_toDoListArray count];
    }
    else
        return [_checkedOffArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (indexPath.section == 0)
    {
        [cell setAccessoryType:UITableViewCellAccessoryDetailButton];
        cell.textLabel.text = _toDoListArray[indexPath.row];
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    else
    {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        cell.textLabel.text = _checkedOffArray[indexPath.row];
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
        
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    secondVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondVC"];
    secondVC.delegate = self;
    secondVC.rowID = indexPath.row;
    secondVC.oldNameString = _toDoListArray[indexPath.row];
    
    [self.navigationController pushViewController:secondVC animated:YES];
    //[self presentViewController:secondVC animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        [_tableView beginUpdates];
        
        [_checkedOffArray addObject:[_toDoListArray objectAtIndex:indexPath.row]];
        [_toDoListArray removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationRight];
        
        [_tableView endUpdates];
        [self performSelector:@selector(updateTable) withObject:nil afterDelay:0.3];
        //[_tableView reloadData];
    }
    else
    {
        [_tableView beginUpdates];
        
        [_toDoListArray addObject:[_checkedOffArray objectAtIndex:indexPath.row]];
        [_checkedOffArray removeObjectAtIndex:indexPath.row];
        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
        [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationLeft];
        [_tableView endUpdates];
        [self performSelector:@selector(updateTable) withObject:nil afterDelay:0.3];
        //[_tableView reloadData];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{

    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //add code here for when you hit delete
        if (indexPath.section == 0)
        {
            [_tableView beginUpdates];
            
            [_toDoListArray removeObjectAtIndex:indexPath.row];
            [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
            
            [_tableView endUpdates];
            
            [self performSelector:@selector(updateTable) withObject:nil afterDelay:0.3];
            //[_tableView reloadData];
        }
        else
        {
            [_tableView beginUpdates];
            
            [_checkedOffArray removeObjectAtIndex:indexPath.row];
            [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationLeft];
            
            [_tableView endUpdates];
            
            [self performSelector:@selector(updateTable) withObject:nil afterDelay:0.3];
            //[_tableView reloadData];
        }
    }
}

- (void)updateTable
{
    [_tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addToListAction:nil];
    
    return  YES;
}

- (IBAction)addToListAction:(id)sender
{
    if (![_textField.text  isEqual: @""])
    {
        [_toDoListArray addObject:_textField.text];
        _textField.text = @"";
        [_textField endEditing:YES];
        [_tableView reloadData];
    }
}
@end
