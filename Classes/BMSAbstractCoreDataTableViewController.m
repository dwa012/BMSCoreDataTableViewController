//
//  UNOItemTableViewController.m
//
//  Created by Daniel Ward on 3/30/14.
//  Copyright (c) 2014 Daniel Ward dwa012@gmail.com . All rights reserved.
//

#import "BMSAbstractCoreDataTableViewController.h"

@interface BMSAbstractCoreDataTableViewController ()

@end

@implementation BMSAbstractCoreDataTableViewController

#pragma mark - abstract methods

/**
 * The cell identifier used by cellForRowAtIndexPath.
 *
 * @return The name of the Cell Reuse Identifier
 */
- (NSString *)cellIdentifier {
  return @"Cell";
}

/**
 * The name of the Core Data Entity that will be displayed in the table view
 *
 * @return The name of the Core Data Entity for this table view
 */
- (NSString *)entityName {
  return @"Entity";
}

/**
 * Will show or hide the add item bar button.
 * If set to YES, you should override openAddObjectView:
 *
 * @see openAddObjectView:
 */
- (BOOL)shouldAllowAddNewObject {
  return NO;
}

/*
 * Override this method to be the concrete class entity name
 */
- (NSString *)cacheName {
  return [NSString stringWithFormat:@"master-%@",[self entityName]];
}

/*
 * Override this method to use any predicates
 */
- (NSPredicate *)fetchedResultsPredicate {
  return nil;
}

/**
 * Override this method fetch certain object properties and aggregate properties
 */
- (NSArray *)fetchedResultsProperties {
  return @[];
}

/**
 * Override this method sort the fetched objects
 */
- (NSArray *)fetchedSortDescriptors {
//  Example:
//  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
//  NSArray *sortDescriptors = @[sortDescriptor];
  return @[];
}

/**
* The selector called by the bar button, to transfer the UI to a view to enter a new object into the data store
*/
- (void) openAddObjectView:(id)sender {
  // left blank
}

/**
 * Override this method to configure the cell for the concrete class
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
//  Example:
//  NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
//  cell.textLabel.text = [[object valueForKey:@"timeStamp"] description];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.navigationItem.leftBarButtonItem = self.editButtonItem;

  if ([self shouldAllowAddNewObject]) {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(openAddObjectView:)];
    self.navigationItem.rightBarButtonItem = addButton;
  }
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - CoreData NSManagaedObject helpers

- (NSManagedObject *)getEmptyObject {
  NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
  NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
  NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];

  return  newManagedObject;
}

- (void)insertNewObject
{
  NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];

  // Save the context.
  NSError *error = nil;
  if (![context save:&error]) {
    // Replace this implementation with code to handle the error appropriately.
    // abort() causes the application to generate a crash log and terminate.
    // You should not use this function in a shipping application, although it may be useful during development.
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
  return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier] forIndexPath:indexPath];
  [self configureCell:cell atIndexPath:indexPath];
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Return NO if you do not want the specified item to be editable.
  return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];

    NSError *error = nil;
    if (![context save:&error]) {
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
  return NO;
}


#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
  if (_fetchedResultsController != nil) {
    return _fetchedResultsController;
  }

  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  // Edit the entity name as appropriate.
  NSEntityDescription *entity = [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:self.managedObjectContext];
  [fetchRequest setEntity:entity];

  // Set the batch size to a suitable number.
  [fetchRequest setFetchBatchSize:20];

  // if any predicates were provided
  if ([self fetchedResultsPredicate])
        [fetchRequest setPredicate:[self fetchedResultsPredicate]];

  // if any properties were provided
  if ([[self fetchedResultsProperties] count] > 0)
    [fetchRequest setPropertiesToFetch:[self fetchedResultsProperties]];

  // if any sort descriptors were provided
  if ([[self fetchedSortDescriptors] count] > 0)
    [fetchRequest setSortDescriptors:[self fetchedSortDescriptors]];


  // Edit the section name key path and cache name if appropriate.
  // nil for section name key path means "no sections".
  NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:[self cacheName]];
  aFetchedResultsController.delegate = self;
  self.fetchedResultsController = aFetchedResultsController;

  NSError *error = nil;
  [self.fetchedResultsController performFetch:&error];

  if ([error userInfo] != nil) {
    // Replace this implementation with code to handle the error appropriately.
    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }

  return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
  [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
  switch(type) {
    case NSFetchedResultsChangeInsert:
      [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;

    case NSFetchedResultsChangeDelete:
      [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
      break;
  }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
  UITableView *tableView = self.tableView;

  switch(type) {
    case NSFetchedResultsChangeInsert:
      [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;

    case NSFetchedResultsChangeDelete:
      [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;

    case NSFetchedResultsChangeUpdate:
      [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
      break;

    case NSFetchedResultsChangeMove:
      [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
  }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
  [self.tableView endUpdates];
}

@end
