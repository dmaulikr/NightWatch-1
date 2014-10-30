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
    NWGamePlayViewController *game;
    game = [[NWGamePlayViewController alloc]init];
    
    game.savedScore = [NSUserDefaults standardUserDefaults];
    [game.savedScore synchronize];
    NSObject *object = [game.savedScore objectForKey:HIGH_SCORE_KEY0];
    
    if(object != nil){
        _highScoreLbl.text = [NSString stringWithFormat:@"%@",[game.savedScore objectForKey:HIGH_SCORE_KEY0]];
    }
    
    [game release];
}


#pragma mark - buttons actions


- (IBAction)goToAbout:(id)sender
{
    NWAboutViewController *about = [[NWAboutViewController alloc]init];
    
    [self.navigationController pushViewController:about animated:NO];
    
    [about autorelease];
}

- (IBAction)goToInstructions:(id)sender
{
    NWInstructionsViewController *instructionsView = [[NWInstructionsViewController alloc]init];
    
    [self.navigationController pushViewController:instructionsView animated:NO];
    
    [instructionsView release];
}

- (IBAction)startPlaying:(id)sender
{
    NWGamePlayViewController *game = [[NWGamePlayViewController alloc]init];

    [self.navigationController pushViewController:game animated:NO];
    
    [game release];
}



@end
