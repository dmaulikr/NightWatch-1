//
//  NWGameOverViewController.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/24/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWGameOverViewController.h"

@interface NWGameOverViewController ()

@property (retain, nonatomic) IBOutlet UIButton *playAgainBtn;
@property (retain, nonatomic) IBOutlet UIButton *mainMenuBtn;

- (IBAction)playAgain:(id)sender;

@end

@implementation NWGameOverViewController

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

- (void) playAgain:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)dealloc {
    [_playAgainBtn release];
    [_mainMenuBtn release];
    [super dealloc];
}
@end
