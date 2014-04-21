FingerPrints
============

#### ***This library is currently unmaintained.***

Displays touches on mirrored Apple AirPlay devices. 

FingerPrints makes demoing apps to clients more informative. By showing your taps, swipes and gestures ontop of the app, the audience can easily see what your doing and how your using the app.

--- 

#### Installation 

Initialise a `FPWindow` instead of the normal `UIWindow` class.

    Class windowClass = [UIWindow class];
    #ifdef DEBUG
        windowClass = [FPWindow class];
    #endif
    
    self.window = [[[windowClass alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
        
---- 

#### Todo 

- Upgrade to use ARC.
- Upgrade code for iOS 7.
- Fix use deprecated orientation APIs.
