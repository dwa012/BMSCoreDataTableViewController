//
//  UNOItemTableViewController.h
//  CoreDataTest
//
//  Created by Daniel Ward on 3/30/14.
//  Copyright (c) 2014 UNO CSCI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface BMSAbstractCoreDataTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (NSString *)cellIdentifier;

- (NSString *)entityName;

- (BOOL)shouldAllowAddNewObject;

- (NSString *)cacheName;

- (NSPredicate *)fetchedResultsPredicate;

- (NSArray *)fetchedResultsProperties;

- (NSArray *)fetchedSortDescriptors;

- (void)openAddObjectView:(id)sender;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

- (void)insertNewObject;

- (NSManagedObject *)getEmptyObject;
@end
