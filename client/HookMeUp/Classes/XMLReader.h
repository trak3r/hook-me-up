//
//  XMLReader.h
//  HookMeUp
//
//  Created by Ted on 11/19/08.
//  Copyright 2008 Anachromystic. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Hooker.h"

@interface XMLReader : NSObject {
	
@private        
    Hooker *_currentHookerObject;
    NSMutableString *_contentOfCurrentHookerProperty;
}

@property (nonatomic, retain) Hooker *currentHookerObject;
@property (nonatomic, retain) NSMutableString *contentOfCurrentHookerProperty;

- (void)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error;

@end
