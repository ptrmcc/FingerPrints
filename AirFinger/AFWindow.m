//
//  AFWindow.m
//  AirFinger
//
//  Created by Peter McCurrach on 07/02/2013.
//  Copyright (c) 2013 Peter McCurrach. All rights reserved.
//

#import "AFWindow.h"

@interface AFWindow()
- (void) initAirFinger;
- (void) processTouches:(NSSet *)touches;
@end

@implementation AFWindow

#pragma mark overridden methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initAirFinger];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAirFinger];
    }
    return self;
}

- (id) init
{
    self = [super init];
    if (self) {
        [self initAirFinger];
    }
    return self;
}

- (void) bringSubviewToFront:(UIView *)view
{
    [super bringSubviewToFront:view];
    
    //If enabled, bring fingerprints to front
    if ([self airFingerEnabled])
        [super bringSubviewToFront:self.fingerPrintContainer];
}

- (void) sendEvent:(UIEvent *)event
{
    [super sendEvent:event];
    
    //If enabled, process the event
    if ([self airFingerEnabled])
        [self processTouches:[event allTouches]];
}

#pragma mark private methods

- (void) initAirFinger
{
    [self setAirFingerEnabled:YES];
    [self setShowAirFingerInReleaseMode:NO];
    [self setAlwaysShowAirFinger:NO];
    [self setRequestAirFingerConfirmation:NO];
    
    //Observers for keyboard actions
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    //Observers for secondScreens
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDidConnect:) name:UIScreenDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDidDisconnect:) name:UIScreenDidDisconnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenModeDidChange:) name:UIScreenModeDidChangeNotification object:nil];
}

- (void) processTouches:(NSSet *)touches
{
    NSLog(@"touches = %@", touches);
}

#pragma mark noticication handlers

- (void) keyboardDidHide:(NSNotification *)keyboardDidHideNotification
{
    
}

-  (void) keyboardDidShow:(NSNotification *)keyboardDidShowNotification
{

}

- (void) screenDidConnect:(NSNotification *)screenDidConnectNotification
{
    
}

- (void) screenDidDisconnect:(NSNotification *)screenDidDisconnectNotification
{
    
}

- (void) screenModeDidChange:(NSNotification *)screenModeDidChangeNotification
{
    
}


@end
