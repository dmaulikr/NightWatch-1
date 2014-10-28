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

@interface NWMainMenuController ()
@property (retain, nonatomic) IBOutlet UIButton *playBtn;
@property (retain, nonatomic) IBOutlet UIButton *instructionsBtn;
@property (retain, nonatomic) IBOutlet UILabel *highScoreLbl;
@property (retain, nonatomic) NWGamePlayViewController *game;
@property (retain, nonatomic) IBOutlet UIButton *aboutBtn;


@end

@implementation NWMainMenuController


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
    
    UINavigationController *navController = self.navigationController;
    [[self retain] autorelease];
    
    [navController popViewControllerAnimated:NO];
    [navController pushViewController:game animated:NO];
    
//    NWGamePlayViewController *game = [[[NWGamePlayViewController alloc]init]autorelease];
//    [self.navigationController pushViewController:game animated:NO];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _game = [[[NWGamePlayViewController alloc]init]autorelease];
    _game.savedScore = [NSUserDefaults standardUserDefaults];
    [_game.savedScore synchronize];
    _highScoreLbl.text = [NSString stringWithFormat:@"%@", [_game.savedScore objectForKey:@"highScore"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_playBtn release];
    [_instructionsBtn release];
    [_aboutBtn release];
    [super dealloc];
}
@end
