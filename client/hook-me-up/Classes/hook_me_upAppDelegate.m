//
//  hook_me_upAppDelegate.m
//  hook-me-up
//
//  Created by Ted on 11/19/08.
//  Copyright Anachromystic 2008. All rights reserved.
//

#import "hook_me_upAppDelegate.h"
#import "RootViewController.h"


@implementation hook_me_upAppDelegate

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
