@class Hooker, HookMeUpAppDelegate;

@interface HookMeUpAppDelegate (AppDelegateMethods)

- (void)showHookerInfo:(Hooker *)dictionary;
- (void)addToHookerList:(Hooker *)hooker;
- (BOOL)isDataSourceAvailable;

@end
