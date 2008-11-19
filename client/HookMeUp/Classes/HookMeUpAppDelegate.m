//
//  HookMeUpAppDelegate.m
//  HookMeUp
//
//  Created by Ted on 11/19/08.
//  Copyright Anachromystic 2008. All rights reserved.
//

#import "HookMeUpAppDelegate.h"
#import "RootViewController.h"


@implementation HookMeUpAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
