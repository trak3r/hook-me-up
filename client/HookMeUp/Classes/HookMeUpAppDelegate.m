//
//  HookMeUpAppDelegate.m
//  HookMeUp
//
//  Created by Ted on 11/19/08.
//  Copyright Anachromystic 2008. All rights reserved.
//

#import "HookMeUpAppDelegate.h"
#import "RootViewController.h"
#import "XMLReader.h"
#import "Hooker.h"
#import <SystemConfiguration/SystemConfiguration.h>

static NSString *feedURLString = @"http://localhost:8080/hereiam";

@implementation HookMeUpAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize list;


- (BOOL)isDataSourceAvailable
{
    static BOOL checkNetwork = YES;
    if (checkNetwork) { // Since checking the reachability of a host can be expensive, cache the result and perform the reachability check once.
        checkNetwork = NO;
        
        Boolean success;    
        const char *host_name = "localhost";
		
        SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
        SCNetworkReachabilityFlags flags;
        success = SCNetworkReachabilityGetFlags(reachability, &flags);
        _isDataSourceAvailable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
        CFRelease(reachability);
    }
    return _isDataSourceAvailable;
}


- (void)getListOfHookers
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
	NSError *parseError = nil;
	
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    XMLReader *streamingParser = [[XMLReader alloc] init];
    [streamingParser parseXMLFileAtURL:[NSURL URLWithString:feedURLString] parseError:&parseError];
    [streamingParser release];        
    [pool release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    if ([self isDataSourceAvailable] == NO) {
        return;
    } else {
		[self getListOfHookers];
	}
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (NSUInteger)countOfList {
	return [list count];
}

- (id)objectInListAtIndex:(NSUInteger)theIndex {
	return [list objectAtIndex:theIndex];
}

- (void)getList:(id *)objsPtr range:(NSRange)range {
	[list getObjects:objsPtr range:range];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[list release];
	[super dealloc];
}

@end
