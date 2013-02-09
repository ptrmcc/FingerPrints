//
//  FPWindow.h
//  FingerPrints
//
//  Created by Peter McCurrach on 07/02/2013.
//  Copyright (c) 2013 Peter McCurrach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FPWindow : UIWindow {
    NSMutableDictionary *touchMap;
}

@property (nonatomic, retain) UIView *fingerPrintContainer;

@property (nonatomic, readonly) BOOL showFingerPrints;
@property (nonatomic, assign) BOOL fingerPrintsEnabled;
@property (nonatomic, assign) BOOL showFingerPrintsInReleaseMode; //By default, FingerPrints only shows in DEBUG mode.
@property (nonatomic, readonly) BOOL isInReleaseMode;
//@property (nonatomic, assign) BOOL requestFingerPrintsConfirmation; //Asks user whether to activate FingerPrints when second screen is connected.
//@property (nonatomic, readonly) BOOL FingerPrintsConfirmed;
@property (nonatomic, assign) BOOL alwaysShowFingerPrints; //By default FingerPrints only appears when a second screen is connected.

- (void) keyboardDidHide: (NSNotification *) keyboardDidHideNotification;
- (void) keyboardDidShow: (NSNotification *) keyboardDidShowNotification;

- (void) screenDidConnect: (NSNotification *) screenDidConnectNotification;
- (void) screenDidDisconnect: (NSNotification *) screenDidDisconnectNotification;
- (void) screenModeDidChange: (NSNotification *) screenModeDidChangeNotification;

@end
