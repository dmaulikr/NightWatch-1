//
//  NWAppDelegate.h
//  NightWatch
//
//  Created by Marvin Labrador on 10/22/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (readonly, nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (readonly, nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
