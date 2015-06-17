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
#import "NWSound.h"

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

- (void)viewDidLoad
{
//    [NWSound playBGM:NWBGMTypeMain];
}

- (void)viewWillAppear:(BOOL)animated
{
    [NWSound playBGM:NWBGMTypeMain];
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
    [NWSound stopBGM];
    NWAboutViewController *aboutViewController = [[NWAboutViewController alloc]init];
    
    [self.navigationController pushViewController:aboutViewController animated:NO];
    
    [aboutViewController autorelease];
}

- (IBAction)goToInstructions:(id)sender
{
    [NWSound stopBGM];
    NWInstructionsViewController *instructionsViewController = [[NWInstructionsViewController alloc]init];
    
    [self.navigationController pushViewController:instructionsViewController animated:NO];
    
    [instructionsViewController release];
}

- (IBAction)startPlaying:(id)sender
{
    [NWSound stopBGM];
    NWGamePlayViewController *gameViewController = [[NWGamePlayViewController alloc]init];

    [self.navigationController pushViewController:gameViewController animated:NO];
    
    [gameViewController release];
}



@end
