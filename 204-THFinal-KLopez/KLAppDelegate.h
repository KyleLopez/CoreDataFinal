//
//  KLAppDelegate.h
//  204-THFinal-KLopez
//
//  Created by Kyle Lopez on 5/28/13.
//  Copyright (c) 2013 Kyle Lopez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
