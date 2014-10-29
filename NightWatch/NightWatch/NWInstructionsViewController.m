//
//  NWInstructionsViewController.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/28/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWInstructionsViewController.h"

@interface NWInstructionsViewController ()
@property (retain, nonatomic) IBOutlet UIButton *mainMenuBtn;
@end

@implementation NWInstructionsViewController

- (void)dealloc
{
    
    [_mainMenuBtn release];
    _mainMenuBtn = nil;
    
    [super dealloc];
}

- (IBAction)backToMainMenu:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
