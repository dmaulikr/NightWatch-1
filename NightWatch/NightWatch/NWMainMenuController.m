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
@property (retain, nonatomic) IBOutlet UILabel *highScoreLbl;
@property (retain, nonatomic) NWGamePlayViewController *game;
@property (retain, nonatomic) IBOutlet UIButton *aboutBtn;


@end

@implementation NWMainMenuController


- (void)dealloc {
    
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

- (IBAction)viewAbout:(id)sender {
   
    NWAboutViewController *about = [[[NWAboutViewController alloc]init]autorelease];
    
    [self.navigationController pushViewController:about animated:NO];
    
}


- (IBAction)goToInstructions:(id)sender {
    
    NWInstructionsViewController *instructionsView = [[[NWInstructionsViewController alloc]init]autorelease];
    
    [self.navigationController pushViewController:instructionsView animated:NO];
    
}
- (IBAction)playBtn:(id)sender {
    
    NWGamePlayViewController *game = [[[NWGamePlayViewController alloc]init]autorelease];

    [self.navigationController pushViewController:game animated:NO];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    _game = [[[NWGamePlayViewController alloc]init]autorelease];
    _game.savedScore = [NSUserDefaults standardUserDefaults];
    [_game.savedScore synchronize];
    NSObject *object = [_game.savedScore objectForKey:highScore];
    
    if(object != nil){
        _highScoreLbl.text = [NSString stringWithFormat:@"%@",[_game.savedScore objectForKey:highScore]];
    }
    
    
    
}

@end
