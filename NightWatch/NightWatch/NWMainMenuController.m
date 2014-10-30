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

NSString *highScore = @"highScore";


@interface NWMainMenuController ()

@property (retain, nonatomic) IBOutlet UIButton *playBtn;
@property (retain, nonatomic) IBOutlet UIButton *instructionsBtn;
@property (retain, nonatomic) IBOutlet UIButton *aboutBtn;
@property (retain, nonatomic) IBOutlet UILabel *highScoreLbl;
@property (retain, nonatomic) NWGamePlayViewController *game;

@end


@implementation NWMainMenuController

- (void)dealloc
{
    [_playBtn release];
    [_instructionsBtn release];
    [_aboutBtn release];
    [_highScoreLbl release];
    
    _playBtn = nil;
    _instructionsBtn = nil;
    _aboutBtn = nil;
    _highScoreLbl = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    _game = [[NWGamePlayViewController alloc]init];
    _game.savedScore = [NSUserDefaults standardUserDefaults];
    [_game.savedScore synchronize];
    NSObject *object = [_game.savedScore objectForKey:highScore];
    
    if(object != nil){
        _highScoreLbl.text = [NSString stringWithFormat:@"%@",[_game.savedScore objectForKey:highScore]];
    }
    
    [_game release];
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
