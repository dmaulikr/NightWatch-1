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
#import "NWHighScoreManager.h"

NSInteger gameScore;

@interface NWGameOverViewController ()

@property (retain, nonatomic) IBOutlet UIButton *playAgainBtn;
@property (retain, nonatomic) IBOutlet UIButton *mainMenuBtn;
@property (retain, nonatomic) IBOutlet UILabel *scoreLabel;
@property (retain, nonatomic) NWHighScoreManager *highScoreMgr;

- (IBAction)playAgain:(id)sender;

@end

@implementation NWGameOverViewController

- (void)dealloc
{
    self.playAgainBtn = nil;
    self.mainMenuBtn = nil;
    self.scoreLabel = nil;
    self.highScoreMgr = nil;
    
    [super dealloc];
}

- (id)initWithCurrentScore:(NSInteger)score
{
    self = [super init];
    
    if (self) {
        _highScoreMgr = [[NWHighScoreManager alloc]init];
        
        if ([_highScoreMgr isHighScore:score]) {
            [self updateHighScore:score];
        }
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

- (void) updateHighScore:(NSInteger)score
{
    UIAlertView *newHighScoreAlert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%ld",(long)score]
                                                               message:@"YOU'VE SET A NEW HIGH SCORE!!!!"
                                                              delegate:self
                                                     cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
    [newHighScoreAlert show];
    [_highScoreMgr setScoreAsHighScore:score];
    
}

- (void) printGameScore:(NSInteger)score
{
    _scoreLabel.text = [NSString stringWithFormat:@"You scored %ld, Good Job!", (long)score];
}

@end
