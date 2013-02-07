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
- (BOOL) hasSecondaryMirroredScreen;
- (void) refreshState;
- (void) showHideFingerprints;
- (UIView *) getCachedFingerPrintFromTouchPointer:(NSString *)touchPointer;
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

- (void) insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview
{
    [super insertSubview:view aboveSubview:siblingSubview];
    [super bringSubviewToFront:self.fingerPrintContainer];
}

- (void) insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    [super insertSubview:view atIndex:index];
    [super bringSubviewToFront:self.fingerPrintContainer];
}

- (void) addSubview:(UIView *)view
{
    [super addSubview:view];
    [super bringSubviewToFront:self.fingerPrintContainer];
}

- (void) setRootViewController:(UIViewController *)rootViewController
{
    [super setRootViewController:rootViewController];
    [super bringSubviewToFront:self.fingerPrintContainer];
}

- (void) bringSubviewToFront:(UIView *)view
{
    [super bringSubviewToFront:view];
    [super bringSubviewToFront:self.fingerPrintContainer];
}

- (void) sendEvent:(UIEvent *)event
{
    [super sendEvent:event];
    
    //If enabled, process the event
    if ([self showAirFinger])
        [self processTouches:[event allTouches]];
}

#pragma mark private methods

//Main methods

- (void) initAirFinger
{
    [self setAirFingerEnabled:YES];
    
    #ifndef DEBUG
        _isInReleaseMode = YES;
    #endif
    
    [self setShowAirFingerInReleaseMode:NO];
    [self setAlwaysShowAirFinger:NO];
    //[self setRequestAirFingerConfirmation:NO];
    
    touchMap = [[NSMutableDictionary alloc] init];
    
    //TODO move to AFAppDelegate
    //[self setAlwaysShowAirFinger:YES];
    
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
    for (UITouch *touch in touches){
        NSString *touchPointer = [NSString stringWithFormat:@"%p", touch];
        UIView *fingerPrint = [self getCachedFingerPrintFromTouchPointer:touchPointer];
        if ([touch phase] == UITouchPhaseBegan || [touch phase] == UITouchPhaseMoved || [touch phase] == UITouchPhaseStationary){
            [fingerPrint setCenter:[touch locationInView:self]];
        } else {
            [touchMap removeObjectForKey:touchPointer];
            [fingerPrint removeFromSuperview];
        }
    }
}

- (UIView *) getCachedFingerPrintFromTouchPointer:(NSString *)touchPointer
{
    UIView *fingerPrint = (UIView *)[touchMap objectForKey:touchPointer];
    if (fingerPrint == nil){
        fingerPrint = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [(UIImageView*)fingerPrint setImage:[UIImage imageNamed:@"FingerPrint.png"]];
        [fingerPrint setUserInteractionEnabled:NO];
        [touchMap setObject:fingerPrint forKey:touchPointer];
        [self.fingerPrintContainer addSubview:fingerPrint];
    }
    return fingerPrint;
}

//Utility/State methods

- (void) refreshState
{
    BOOL newShowAirFinger = self.airFingerEnabled &&
    ([self hasSecondaryMirroredScreen] || self.alwaysShowAirFinger) &&
    //(!self.requestAirFingerConfirmation || self.airFingerConfirmed) &&
    (!self.isInReleaseMode || self.showAirFingerInReleaseMode);
    
    BOOL hasStateChanged = newShowAirFinger != _showAirFinger;
    _showAirFinger = newShowAirFinger;
    
    if (hasStateChanged)
        [self showHideFingerprints];
    
    NSLog(@"Show air finger = %i", newShowAirFinger);
}

- (BOOL) hasSecondaryMirroredScreen
{
    if ([[UIScreen screens] count] <= 1)
        return NO;
    
    BOOL hasFoundMirroredScreen = NO;
    NSInteger screenCount = [[UIScreen screens] count] -1;
    while (!hasFoundMirroredScreen && screenCount > 0){
        hasFoundMirroredScreen = [[[UIScreen screens] objectAtIndex:screenCount] mirroredScreen] == [UIScreen mainScreen];
        screenCount -= 1;
    }
    
    return hasFoundMirroredScreen;
}

- (void) showHideFingerprints
{
    if (self.showAirFinger){
        //TODO get the window associated with [UIScreen mainScreen];
        self.fingerPrintContainer = [[UIView alloc] initWithFrame:self.bounds];
        [self.fingerPrintContainer setUserInteractionEnabled:NO];
        [self.fingerPrintContainer setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [self.fingerPrintContainer setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.fingerPrintContainer];
    } else {
        [self.fingerPrintContainer removeFromSuperview];
        [self setFingerPrintContainer:nil];
    }
}

#pragma mark noticication handlers

- (void) keyboardDidHide:(NSNotification *)keyboardDidHideNotification
{
    UIWindow *frontMostWindow = [[[UIApplication sharedApplication] windows] lastObject];
    [frontMostWindow addSubview:self.fingerPrintContainer];
}

-  (void) keyboardDidShow:(NSNotification *)keyboardDidShowNotification
{
    UIWindow *frontMostWindow = [[[UIApplication sharedApplication] windows] lastObject];
    [frontMostWindow addSubview:self.fingerPrintContainer];
}

- (void) screenDidConnect:(NSNotification *)screenDidConnectNotification
{
    [self refreshState];
}

- (void) screenDidDisconnect:(NSNotification *)screenDidDisconnectNotification
{
    [self refreshState];
}

- (void) screenModeDidChange:(NSNotification *)screenModeDidChangeNotification
{
    [self refreshState];
}

#pragma mark overridden getters ^ setters

- (void) setAirFingerEnabled:(BOOL)airFingerEnabled
{
    _airFingerEnabled = airFingerEnabled;
    [self refreshState];
}

- (void) setAlwaysShowAirFinger:(BOOL)alwaysShowAirFinger
{
    _alwaysShowAirFinger = alwaysShowAirFinger;
    [self refreshState];
}

- (void) setShowAirFingerInReleaseMode:(BOOL)showAirFingerInReleaseMode
{
    _showAirFingerInReleaseMode = showAirFingerInReleaseMode;
    [self refreshState];
}

/*- (void) setRequestAirFingerConfirmation:(BOOL)requestAirFingerConfirmation
{
    _requestAirFingerConfirmation = requestAirFingerConfirmation;
    [self refreshState];
}
*/

@end
