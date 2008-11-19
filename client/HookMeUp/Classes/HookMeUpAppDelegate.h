//
//  HookMeUpAppDelegate.h
//  HookMeUp
//
//  Created by Ted on 11/19/08.
//  Copyright Anachromystic 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HookMeUpAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;

	NSMutableArray *list;
    BOOL _isDataSourceAvailable;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;


@property (nonatomic, retain) NSMutableArray *list;

- (BOOL)isDataSourceAvailable;

- (NSUInteger)countOfList;
- (id)objectInListAtIndex:(NSUInteger)theIndex;
- (void)getList:(id *)objsPtr range:(NSRange)range;


@end

