//
//  NWAboutViewController.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/28/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWAboutViewController.h"
#import "NWSound.h"

NSString *const FULL_URL = @"http://en.wikipedia.org/wiki/Halloween";


@interface NWAboutViewController () <UIWebViewDelegate>

@property (retain, nonatomic) IBOutlet UIWebView *halloweenWebView;
@property (retain, nonatomic) IBOutlet UIButton *mainMenuBtn;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end


@implementation NWAboutViewController

- (void)dealloc
{
    self.halloweenWebView = nil;
    self.mainMenuBtn = nil;
    self.loadingIndicator = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self loadWebView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [NWSound playBGM:NWBGMTypeGameSounds];
}

- (void)loadWebView
{
    _halloweenWebView.delegate = self;
    
    void (^blockWebView)(void) =^{
        
        NSURL *halloweenURL = [NSURL URLWithString:FULL_URL];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:halloweenURL];
        
        [_halloweenWebView loadRequest:request];
    };
    
    [_loadingIndicator startAnimating];
    
    blockWebView();
}

- (IBAction)backToMainMenu:(id)sender
{
    [NWSound stopBGM];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_loadingIndicator stopAnimating];
    [_loadingIndicator removeFromSuperview];
}


@end
