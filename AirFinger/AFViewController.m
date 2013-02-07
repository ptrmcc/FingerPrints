//
//  AFViewController.m
//  FingerPrints
//
//  Created by Peter McCurrach on 06/02/2013.
//  Copyright (c) 2013 Peter McCurrach. All rights reserved.
//

#import "AFViewController.h"

@interface AFViewController ()

@end

@implementation AFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) button:(id)sender
{
    [self.view endEditing:YES];
    [self resignFirstResponder];
}

@end
