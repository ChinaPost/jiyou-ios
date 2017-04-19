//
//  AppDelegate.h
//  Philately
//
//  Created by gdpost on 15/5/13.
//  Copyright (c) 2015年 gdpost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import <ServiceInvoker.h>
#import "LoginViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,ServiceInvokerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong,nonatomic) UITabBarController *tabbar;

@property (nonatomic) BOOL isMainpage;
@property (strong,nonatomic) LoginViewController *loginView;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

