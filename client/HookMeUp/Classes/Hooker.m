//
//  Hooker.h
//  Hooker
//
//  Created by FIXME on 2008-11-21.
//  Copyright 2008 FIXME. All rights reserved.
//

#import "Hooker.h"


@implementation Hooker

@synthesize name = _name;
@synthesize age = _age;
@synthesize gender = _gender;
@synthesize distance = _distance;

@end

// This initialization function gets called when we import the Ruby module.
// It doesn't need to do anything because the RubyCocoa bridge will do
// all the initialization work.
// The rbiphonetest test framework automatically generates bundles for 
// each objective-c class containing the following line. These
// can be used by your tests.
void Init_Hooker() { }