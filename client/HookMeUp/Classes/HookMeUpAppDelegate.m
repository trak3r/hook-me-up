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

   	NSMutableString *feedURLStringWithParams = [[NSMutableString alloc] init];
	[feedURLStringWithParams appendString:feedURLString];
	[feedURLStringWithParams appendString:@"?"];
	[feedURLStringWithParams appendString:@"name="];
	[feedURLStringWithParams appendString:[@"Ted" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]; // TODO: get from profile
	[feedURLStringWithParams appendString:@"&"];
	[feedURLStringWithParams appendString:@"age="];
	[feedURLStringWithParams appendString:@"36"]; // TODO: get from profile
	[feedURLStringWithParams appendString:@"&"];
	[feedURLStringWithParams appendString:@"gender="];
	[feedURLStringWithParams appendString:@"m"]; // TODO: get from profile
	[feedURLStringWithParams appendString:@"&"];
	[feedURLStringWithParams appendString:@"phone="];
	[feedURLStringWithParams appendString:@"9548168827"]; // TODO: get from device
	[feedURLStringWithParams appendString:@"&"];
	[feedURLStringWithParams appendString:@"latitude="];
	[feedURLStringWithParams appendString:@"26.1353"]; // TODO: get from device
	[feedURLStringWithParams appendString:@"&"];
	[feedURLStringWithParams appendString:@"longitude="];
	[feedURLStringWithParams appendString:@"-80.4038"]; // TODO: get from device
    XMLReader *streamingParser = [[XMLReader alloc] init];
    [streamingParser parseXMLFileAtURL:[NSURL URLWithString:feedURLStringWithParams] parseError:&parseError];
    [streamingParser release];        
	[feedURLStringWithParams release];
    [pool release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)reloadTable
{
    [[(RootViewController *)[self.navigationController topViewController] tableView] reloadData];
}


- (void)addToHookerList:(Hooker *)newHooker
{
//    [self.list addObject:newHooker];
    [list addObject:newHooker];
    // The table needs to be reloaded to reflect the new content of the list.
    [self reloadTable];
}


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	self.list = [NSMutableArray array];
	
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
