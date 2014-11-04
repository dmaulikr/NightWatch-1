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
#import "NWHighScoreManager.h"

@interface NWMainMenuController ()

@property (retain, nonatomic) IBOutlet UIButton *playBtn;
@property (retain, nonatomic) IBOutlet UIButton *instructionsBtn;
@property (retain, nonatomic) IBOutlet UIButton *aboutBtn;
@property (retain, nonatomic) IBOutlet UILabel *highScoreLbl;
@property (retain, nonatomic) IBOutlet UIImageView *welcomeImg;

@end


@implementation NWMainMenuController

- (void)dealloc
{
    self.playBtn = nil;
    self.instructionsBtn = nil;
    self.aboutBtn = nil;
    self.highScoreLbl = nil;
    
    [_welcomeImg release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    NWHighScoreManager *highScoreMgr = [[NWHighScoreManager alloc]init];
    
    NSNumber *highScoreObject = [highScoreMgr retrieveHighScore];
    
    if(highScoreObject != nil){
        _highScoreLbl.text = [NSString stringWithFormat:@"%@",highScoreObject];
    }
    
    [highScoreMgr release];
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
