//
//  AFWindow.h
//  AirFinger
//
//  Created by Peter McCurrach on 07/02/2013.
//  Copyright (c) 2013 Peter McCurrach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface AFWindow : UIWindow {
    NSMutableDictionary *touchMap;
}

@property (nonatomic, retain) UIView *fingerPrintContainer;

@property (nonatomic, readonly) BOOL showAirFinger;
@property (nonatomic, assign) BOOL airFingerEnabled;
@property (nonatomic, assign) BOOL showAirFingerInReleaseMode; //By default, AirFinger only shows in DEBUG mode.
@property (nonatomic, readonly) BOOL isInReleaseMode;
//@property (nonatomic, assign) BOOL requestAirFingerConfirmation; //Asks user whether to activate AirFinger when second screen is connected.
//@property (nonatomic, readonly) BOOL airFingerConfirmed;
@property (nonatomic, assign) BOOL alwaysShowAirFinger; //By default AirFinger only appears when a second screen is connected.

- (void) keyboardDidHide: (NSNotification *) keyboardDidHideNotification;
- (void) keyboardDidShow: (NSNotification *) keyboardDidShowNotification;

- (void) screenDidConnect: (NSNotification *) screenDidConnectNotification;
- (void) screenDidDisconnect: (NSNotification *) screenDidDisconnectNotification;
- (void) screenModeDidChange: (NSNotification *) screenModeDidChangeNotification;

@end
