//
//  BMSAppDelegate.h
//  BMSDemo
//
//  Created by Daniel Ward on 3/31/14.
//  Copyright (c) 2014 ByteMeSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
