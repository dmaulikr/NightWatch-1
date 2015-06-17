//
//  NWInstructionsViewController.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/28/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWInstructionsViewController.h"
#import "NWSound.h"

@interface NWInstructionsViewController ()

@property (retain, nonatomic) IBOutlet UIButton *mainMenuBtn;

@end

@implementation NWInstructionsViewController

- (void)dealloc
{
    self.mainMenuBtn = nil;
    
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [NWSound playBGM:NWBGMTypeGameSounds];
    
}

- (IBAction)backToMainMenu:(id)sender
{
    [NWSound stopBGM];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
