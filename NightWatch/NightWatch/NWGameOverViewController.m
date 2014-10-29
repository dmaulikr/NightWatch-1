//
//  NWGameOverViewController.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/24/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWGameOverViewController.h"
#import "NWGamePlayViewController.h"
#import "NWMainMenuController.h"

NSInteger gameScore;
NSString *myHighScore = @"highScore";

@interface NWGameOverViewController ()

@property (retain, nonatomic) IBOutlet UIButton *playAgainBtn;
@property (retain, nonatomic) IBOutlet UIButton *mainMenuBtn;
@property (retain, nonatomic) NWGamePlayViewController *game;
@property (retain, nonatomic) IBOutlet UILabel *scoreLabel;

- (IBAction)playAgain:(id)sender;

@end

@implementation NWGameOverViewController

- (void)dealloc
{
    [_playAgainBtn release];
    [_mainMenuBtn release];
    [_scoreLabel release];
    
    _playAgainBtn = nil;
    _mainMenuBtn = nil;
    _scoreLabel = nil;
    
    [super dealloc];
}


- (id)initWithCurrentScore:(NSInteger)score
{
    self = [super init];
    
    if (self) {
        [self checkIfHighScore:score];
        gameScore = score;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self printGameScore:gameScore];
}

#pragma mark - buttons actions

- (IBAction)backToMainMenu:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void) playAgain:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark - actions in view

- (void) checkIfHighScore:(NSInteger)score
{
    
    NSInteger highScore = [[[NSUserDefaults standardUserDefaults] valueForKey:myHighScore] intValue];
    
    if (score > highScore) {
        
        _scoreLabel.text = [NSString stringWithFormat:@"You scored %ld, Good Job!", (long)score];
        UIAlertView *newHighScoreAlert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%ld",(long)score]
                                                                   message:@"YOU'VE SET A NEW HIGH SCORE!!!!"
                                                                  delegate:self
                                                         cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [newHighScoreAlert show];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:score] forKey:myHighScore];
        
    }
}

- (void) printGameScore:(NSInteger)score
{
    _scoreLabel.text = [NSString stringWithFormat:@"You scored %ld, Good Job!", (long)score];
}

@end
