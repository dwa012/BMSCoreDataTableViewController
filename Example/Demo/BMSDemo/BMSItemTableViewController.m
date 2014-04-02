//
//  BMSItemTableViewController.m
//  CoreDataTest
//
//  Created by Daniel Ward on 3/31/14.
//  Copyright (c) 2014 BMS CSCI. All rights reserved.
//

#import "BMSItemTableViewController.h"
#import "BMSAddItemViewController.h"

@interface BMSItemTableViewController ()

@end

@implementation BMSItemTableViewController

// ----------------------------------------------------------------------------------------------
// abstract methods to implement

/*
 * Override this method to be the concrete classes Cell Identifier
 */
- (NSString *)cellIdentifier {
    return @"ItemCell";
}

/*
 * Override this method to be the concrete class entity name
 */
- (NSString *)entityName {
    return @"Item";
}

/*
 * Override this method to enable the add button in the navigation bar
 * You SHOULD also override insertNewObject:
 */
- (BOOL)shouldAllowAddNewObject {
  return YES;
}

/*
 * Override this method to be the concrete class entity name
 */
- (NSString *)cacheName {
    return @"itemtableview";
}

- (void) openAddObjectView:(id)sender {
  BMSAddItemViewController *vc = [[BMSAddItemViewController alloc] initWithNibName:@"BMSAddItemViewController" bundle:nil];
  vc.delegate = self;
  vc.item = [self getEmptyObject];


  [self presentViewController:vc animated:YES completion:nil];
}

///*
// * Override this method to use any predicates
// */
//- (NSArray *)fetchedResultsPredicates {
//    return @[];
//}
//
///*
// * Override this method fetch certain object properties and aggregate properties
// */
//- (NSArray *)fetchedResultsProperties {
//    return @[];
//}

/*
 * Override this method sort the fetched objects
 */
- (NSArray *)fetchedSortDescriptors {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    return @[sortDescriptor];
}

/*
 * Override this method to configure the cell for the concrete class
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [object valueForKey:@"name"];
}

- (void)didFinishBuildingItem:(id)sender {
  [self insertNewObject];
}


@end
