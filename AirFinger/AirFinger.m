//
//  AirFinger.m
//  AirFinger
//
//  Created by Peter McCurrach on 06/02/2013.
//  Copyright (c) 2013 Peter McCurrach. All rights reserved.
//

#import "AirFinger.h"


/*
 Touches aren't yet instantiated in hit test / point inside methods
 
 @interface UITouchInterceptView : UIView

@end

@implementation UITouchInterceptView

- (BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"point = %f %f", point.x, point.y);
    NSLog(@"event = %@", event);
    
    UIWindow *thisWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    
    NSSet *touched = [event ];
    
    NSLog(@"touched = %@", touched);
    
    for (UITouch *touch in touched){
        NSLog(@"Touch = %@", touch);
    }
    
    return [super pointInside:point withEvent:event];
}

@end

*/

//Using a subview in the UIWindow that overried pointInside, always returning NO, you can determine the first location of every touch on screen.
//No way to distinguish between touches. No way to detect movement or end locations.

@interface InterceptTouchesGesture : UIGestureRecognizer

@end

@implementation InterceptTouchesGesture

- (void)reset
{
    [super reset];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"began");
    [super touchesBegan:touches withEvent:event];
    /*
    for (UITouch *aTouch in touches){
        [aTouch ]
        [aTouch addObserver:self forKeyPath:<#(NSString *)#> options:<#(NSKeyValueObservingOptions)#> context:<#(void *)#>]
        NSLog(@"t = %@", aTouch);
    }
    */
    //[self setState:UIGestureRecognizerStateFailed];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"moved");
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"ended");
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"cancelled");
    [super touchesCancelled:touches withEvent:event];
}

@end


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
        
        NSLog(@"Number of screens = %i", [[UIScreen screens] count]);
        
        //newLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        //[newLabel setBackgroundColor:[UIColor redColor]];
        
        //UIScreen *secondScreen = [[UIScreen screens] objectAtIndex:1];
        
        //NSLog(@"screen - %@", secondScreen);
        
        NSLog(@"num of winds = %i", [[UIApplication sharedApplication] windows].count);
        
        secondWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        
        NSLog(@"window = %@", secondWindow);
        
        //[secondWindow addSubview:newLabel];
        
        //[newLabel setCenter:secondWindow.center];
        
        //UITapGestureRecognizer *generic = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchFired:)];
        
        //[secondWindow addGestureRecognizer:generic];
        
        
        
        ///UITouchInterceptView *myView = [[UITouchInterceptView alloc] initWithFrame:CGRectMake(-1,-1, 1, 1)];
        
        ///[secondWindow addSubview:myView];
        
        
        
        ////InterceptTouchesGesture *touches = [[InterceptTouchesGesture alloc] initWithTarget:self action:@selector(touchFired:)];

        ////[secondWindow addGestureRecognizer:touches];

    }
    return self;
}

- (void) touchFired:(UIGestureRecognizer *) gesture
{
    NSLog(@"gest = %@", gesture);
    CGPoint touch = [gesture locationInView:secondWindow.subviews.lastObject];
    NSLog(@"touch = %f %f", touch.x, touch.y);
    [newLabel setCenter:touch];
}

@end
