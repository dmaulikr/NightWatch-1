//
//  NWGameOverViewController.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/24/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWGameOverViewController.h"
#import "NWGamePlayViewController.h"

@interface NWGameOverViewController ()

@property (retain, nonatomic) IBOutlet UIButton *playAgainBtn;
@property (retain, nonatomic) IBOutlet UIButton *mainMenuBtn;
@property (retain, nonatomic) NWGamePlayViewController *game;
@property (retain, nonatomic) IBOutlet UILabel *scoreLabel;

- (IBAction)playAgain:(id)sender;

@end

@implementation NWGameOverViewController
- (IBAction)backToMainMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    _game = [[[NWGamePlayViewController alloc]init]autorelease];
    _game.savedScore = [NSUserDefaults standardUserDefaults];
    [_game.savedScore synchronize];
    _scoreLabel.text = [NSString stringWithFormat:@"You scored %@, Good Job!", [_game.savedScore objectForKey:@"yourScore"]];
    
    [super viewDidLoad];

}

- (void) playAgain:(id)sender
{
    NWGamePlayViewController *playAgain = [[[NWGamePlayViewController alloc]init]autorelease];
    UINavigationController *navController = self.navigationController;
    [[self retain] autorelease];
    
    [navController popViewControllerAnimated:NO];
    [navController pushViewController:playAgain animated:NO];
}

- (void)dealloc {
    [_playAgainBtn release];
    [_mainMenuBtn release];
    [super dealloc];
}
@end
