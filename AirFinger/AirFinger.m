//
//  AirFinger.m
//  AirFinger
//
//  Created by Peter McCurrach on 06/02/2013.
//  Copyright (c) 2013 Peter McCurrach. All rights reserved.
//

#import "AirFinger.h"

@implementation AirFinger

static AirFinger *singletonAirFinger;

+ (void) initialize
{
    if (singletonAirFinger == nil)
        singletonAirFinger = [[AirFinger alloc] init];
}

- (id) init
{
    self = [super init];
    if (self) {

    }
    return self;
}

@end
