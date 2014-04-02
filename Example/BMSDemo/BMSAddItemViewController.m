//
//  BMSAddItemViewController.m
//  CoreDataTest
//
//  Created by Daniel Ward on 3/31/14.
//  Copyright (c) 2014 BMS CSCI. All rights reserved.
//

#import "BMSAddItemViewController.h"

@interface BMSAddItemViewController ()

@end

@implementation BMSAddItemViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addPressed:(id)sender {
  [_item setValue:[_nameField text] forKey:@"name"];
  [_item setValue:[NSDate date] forKey:@"createdAt"];

  [_delegate didFinishBuildingItem:self];

  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
