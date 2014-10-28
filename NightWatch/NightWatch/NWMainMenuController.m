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

@interface NWMainMenuController ()
@property (retain, nonatomic) IBOutlet UIButton *playBtn;
@property (retain, nonatomic) IBOutlet UIButton *instructionsBtn;


@end

@implementation NWMainMenuController
- (IBAction)goToInstructions:(id)sender {
    
    NWInstructionsViewController *instructionsView = [[[NWInstructionsViewController alloc]init]autorelease];
    
    [self.navigationController pushViewController:instructionsView animated:NO];
    
}
- (IBAction)playBtn:(id)sender {
    
    NWGamePlayViewController *game = [[[NWGamePlayViewController alloc]init]autorelease];
    [self.navigationController pushViewController:game animated:NO];
    
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_playBtn release];
    [_instructionsBtn release];
    [super dealloc];
}
@end
