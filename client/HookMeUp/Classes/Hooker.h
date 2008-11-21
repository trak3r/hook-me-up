//
//  Hooker.h
//  Hooker
//
//  Created by FIXME on 2008-11-21.
//  Copyright 2008 FIXME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hooker : NSObject {

@private    
    NSString *_name;
    NSString *_age;
    NSString *_gender;
    NSString *_distance;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *age;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *distance;

@end
