//
//  NWMainMenuController.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/27/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWMainMenuController.h"
#import "NWGamePlayViewController.h"
#import "NWInstructionsViewController.h"
#import "NWAboutViewController.h"

NSString *const HIGH_SCORE_KEY0 = @"highScore";


@interface NWMainMenuController ()

@property (retain, nonatomic) IBOutlet UIButton *playBtn;
@property (retain, nonatomic) IBOutlet UIButton *instructionsBtn;
@property (retain, nonatomic) IBOutlet UIButton *aboutBtn;
@property (retain, nonatomic) IBOutlet UILabel *highScoreLbl;


@end


@implementation NWMainMenuController

- (void)dealloc
{
    self.playBtn = nil;
    self.instructionsBtn = nil;
    self.aboutBtn = nil;
    self.highScoreLbl = nil;
    
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    NWGamePlayViewController *gameViewController;
    gameViewController = [[NWGamePlayViewController alloc]init];
    
    gameViewController.savedScore = [NSUserDefaults standardUserDefaults];
    [gameViewController.savedScore synchronize];
    NSObject *object = [gameViewController.savedScore objectForKey:HIGH_SCORE_KEY0];
    
    if(object != nil){
        _highScoreLbl.text = [NSString stringWithFormat:@"%@",[gameViewController.savedScore objectForKey:HIGH_SCORE_KEY0]];
    }
    
    [gameViewController release];
}


#pragma mark - buttons actions


- (IBAction)goToAbout:(id)sender
{
    NWAboutViewController *aboutViewController = [[NWAboutViewController alloc]init];
    
    [self.navigationController pushViewController:aboutViewController animated:NO];
    
    [aboutViewController autorelease];
}

- (IBAction)goToInstructions:(id)sender
{
    NWInstructionsViewController *instructionsViewController = [[NWInstructionsViewController alloc]init];
    
    [self.navigationController pushViewController:instructionsViewController animated:NO];
    
    [instructionsViewController release];
}

- (IBAction)startPlaying:(id)sender
{
    NWGamePlayViewController *gameViewController = [[NWGamePlayViewController alloc]init];

    [self.navigationController pushViewController:gameViewController animated:NO];
    
    [gameViewController release];
}



@end
