//
//  NWAboutViewController.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/28/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWAboutViewController.h"

NSString *fullURL = @"http://en.wikipedia.org/wiki/Halloween";


@interface NWAboutViewController () <UIWebViewDelegate>

@property (retain, nonatomic) IBOutlet UIWebView *halloweenWebView;
@property (retain, nonatomic) IBOutlet UIButton *mainMenuBtn;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end


@implementation NWAboutViewController

- (void)dealloc
{
    [_halloweenWebView release];
    [_mainMenuBtn release];
    [_loadingIndicator release];
    
    _halloweenWebView = nil;
    _mainMenuBtn = nil;
    _loadingIndicator = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    _halloweenWebView.delegate = self;
    
    [super viewDidLoad];
    
    void (^blockWebView)(void) =^{
        
        NSURL *halloweenURL = [NSURL URLWithString:fullURL];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:halloweenURL];
        
        [_halloweenWebView loadRequest:request];
    };
    
    [_loadingIndicator startAnimating];
    
    blockWebView();
}

- (IBAction)backToMainMenu:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_loadingIndicator stopAnimating];
    [_loadingIndicator removeFromSuperview];
}


@end
