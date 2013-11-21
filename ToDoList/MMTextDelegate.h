//
//  MMTextDelegate.h
//  ToDoList
//
//  Created by Kyle Mai on 9/24/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MMTextDelegate <NSObject>

- (void)changeObjectName:(NSString *)string objectAtRow:(NSInteger)row;

@end
