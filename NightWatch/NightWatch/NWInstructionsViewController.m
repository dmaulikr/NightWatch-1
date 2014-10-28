//
//  NWInstructionsViewController.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/28/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWInstructionsViewController.h"

@interface NWInstructionsViewController ()
@property (retain, nonatomic) IBOutlet UIButton *mainMenuBtn;

@end

@implementation NWInstructionsViewController
- (IBAction)backToMainMenu:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:NO];
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
    [_mainMenuBtn release];
    [super dealloc];
}
@end
