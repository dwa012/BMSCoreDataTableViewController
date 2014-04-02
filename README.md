# BMSCoreDataTableViewController

[![Version](http://cocoapod-badges.herokuapp.com/v/BMSCoreDataTableViewController/badge.png)](http://cocoadocs.org/docsets/BMSCoreDataTableViewController)
[![Platform](http://cocoapod-badges.herokuapp.com/p/BMSCoreDataTableViewController/badge.png)](http://cocoadocs.org/docsets/BMSCoreDataTableViewController)

## Installation

BMSCoreDataTableViewController is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "BMSCoreDataTableViewController", :git => 'https://github.com/dwa012/BMSCoreDataTableViewController.git'
    
##Example
To run the example project; clone the repo, and run `pod install` from the Example directory first.

## Usage
This library provides a subclass of UITableViewController. The subclass is meant to be treated as an "abstract" class. It encapsulates a NSFetchedRequestController and provides a few methods for subclass of this library to configure the request object.

These are the methods that can be overriden in a subclass
	
	- (NSString *)cellIdentifier;
	- (NSString *)entityName;
	- (BOOL)shouldAllowAddNewObject;
	- (NSString *)cacheName;
	- (NSPredicate *)fetchedResultsPredicate;
	- (NSArray *)fetchedResultsProperties;
	- (NSArray *)fetchedSortDescriptors;
	- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
	
	
######There are two methods to call that handles Entity creation and saving.

To get a new empty object call this method in your subclass

	- (NSManagedObject *)getEmptyObject;

Then to save the entity call this method in your subclass

	- (void)insertNewObject;


## Author

Daniel Ward - dwa012@gmail.com 

## License

BMSCoreDataTableViewController is available under the Apache 2.0 license. See the LICENSE file for more info.

