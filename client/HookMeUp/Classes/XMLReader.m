//
//  XMLReader.m
//  HookMeUp
//
//  Created by Ted on 11/19/08.
//  Copyright 2008 Anachromystic. All rights reserved.
//

#import "XMLReader.h"

static NSUInteger parsedHookersCounter;

@implementation XMLReader

@synthesize currentHookerObject = _currentHookerObject;
@synthesize contentOfCurrentHookerProperty = _contentOfCurrentHookerProperty;

#define MAX_EARTHQUAKES 20

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    parsedHookersCounter = 0;
}

- (void)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error
{	
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
    [parser setDelegate:self];

    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    
    [parser parse];
    
    NSError *parseError = [parser parserError];
    if (parseError && error) {
        *error = parseError;
    }
    
    [parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	
    if (parsedHookersCounter >= MAX_EARTHQUAKES) {
        [parser abortParsing];
    }
    
    if ([elementName isEqualToString:@"hooker"]) {
        parsedHookersCounter++;
        self.currentHookerObject = [[Hooker alloc] init];
        [(id)[[UIApplication sharedApplication] delegate] performSelectorOnMainThread:@selector(addToHookerList:) withObject:self.currentHookerObject waitUntilDone:YES];
        return;
    }
	
    if ([elementName isEqualToString:@"name"]) {
        self.contentOfCurrentHookerProperty = [NSMutableString string];        
    } else if ([elementName isEqualToString:@"age"]) {
        self.contentOfCurrentHookerProperty = [NSMutableString string];        
    } else if ([elementName isEqualToString:@"gender"]) {
        self.contentOfCurrentHookerProperty = [NSMutableString string];        
    } else if ([elementName isEqualToString:@"distance"]) {
        self.contentOfCurrentHookerProperty = [NSMutableString string];        
    } else {
        // The element isn't one that we care about, so set the property that holds the 
        // character content of the current element to nil. That way, in the parser:foundCharacters:
        // callback, the string that the parser reports will be ignored.
        self.contentOfCurrentHookerProperty = nil;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"name"]) {
        self.currentHookerObject.name = self.contentOfCurrentHookerProperty;
	}
    
    if ([elementName isEqualToString:@"age"]) {
        self.currentHookerObject.age = self.contentOfCurrentHookerProperty;
	}
    
    if ([elementName isEqualToString:@"gender"]) {
        self.currentHookerObject.gender = self.contentOfCurrentHookerProperty;
	}
    
    if ([elementName isEqualToString:@"distance"]) {
        self.currentHookerObject.distance = self.contentOfCurrentHookerProperty;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.contentOfCurrentHookerProperty) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        [self.contentOfCurrentHookerProperty appendString:string];
    }
}

@end
