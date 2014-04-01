//
//  BMSAddItemViewController.h
//  CoreDataTest
//
//  Created by Daniel Ward on 3/31/14.
//  Copyright (c) 2014 BMS CSCI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMSAddItemProtocol.h"

@interface BMSAddItemViewController : UIViewController

@property (weak) id <BMSAddItemProtocol> delegate;
@property (weak) NSManagedObject *item;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

- (IBAction)addPressed:(id)sender;

@end
