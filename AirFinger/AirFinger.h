//
//  AirFinger.h
//  AirFinger
//
//  Created by Peter McCurrach on 06/02/2013.
//  Copyright (c) 2013 Peter McCurrach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "AFWindow.h"

@interface AirFinger : NSObject {
    UILabel *newLabel;
    UIWindow *secondWindow;
}

+ (void) initialize;

@end
