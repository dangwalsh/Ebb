//
//  EbbAppDelegate.m
//  Ebb
//
//  Created by Daniel Walsh on 5/19/12.
//  Copyright (c) 2012 Walsh walsh Studio. All rights reserved.
//

#import "EbbAppDelegate.h"
#import "TableViewController.h"
#import "TableViewControllerResults.h"
#import "Model.h"
#import "ViewController.h"

@implementation EbbAppDelegate

@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    model = [[Model alloc] init];
    
    TableViewController *tableViewController = [[TableViewController alloc]
                                                initWithStyle: UITableViewStyleGrouped
                                                model: model
                                                indexPath: [NSIndexPath indexPathWithIndex: 0]
                                                ];
/**/ 
    ViewController *viewController = [[ViewController alloc] 
                                     initWithNibName:nil 
                                     bundle:nil 
                                     model:model
                                     ];
/**/
/**    
    TableViewControllerResults *results = [[TableViewControllerResults alloc] 
                                           initWithStyle: UITableViewStyleGrouped
                                           model: model
                                           indexPath: [NSIndexPath indexPathWithIndex: 0]
                                           ];
/**/

    UISplitViewController *splitViewController = [[UISplitViewController alloc] initWithNibName: nil bundle: nil];
    
	splitViewController.viewControllers = [NSArray arrayWithObjects:
                                           tableViewController,
                                           viewController,
                                           nil
                                           ];
    
	splitViewController.delegate = self;
    
    self.window.rootViewController = splitViewController;
    
//comment out all of the splitvew initialization above and add back navigation init below to get back to where we were  
/**  
    self.window.rootViewController = [[UINavigationController alloc] 
                                   initWithRootViewController: tableViewController];
/**/
    [self.window makeKeyAndVisible];
    return YES;
}

- (void) getResults {
    UINavigationController *navigationController =
        (UINavigationController *)self.window.rootViewController;
    
    TableViewControllerResults *results = [[TableViewControllerResults alloc] 
                                           initWithStyle: UITableViewStyleGrouped
                                           model: model
                                           indexPath: [NSIndexPath indexPathWithIndex: 0]
                                           ];
    
    [navigationController pushViewController:results animated:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark Protocol UISplitViewControllerDelegate

//This method keeps the MasterView on the screen in portrait orientation.

- (BOOL) splitViewController: (UISplitViewController *) splitViewController
	shouldHideViewController: (UIViewController *) viewController
               inOrientation: (UIInterfaceOrientation) interfaceOrientation
{
	return NO;	//No, don't hide the MasterView.
}
@end
