//
//  NWAboutViewController.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/28/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWAboutViewController.h"

@interface NWAboutViewController () <UIWebViewDelegate>
@property (retain, nonatomic) IBOutlet UIWebView *halloweenWebView;
@property (retain, nonatomic) IBOutlet UIButton *mainMenuBtn;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end

@implementation NWAboutViewController
- (IBAction)returnToMainMenu:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
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
    _halloweenWebView.delegate = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    void (^blockWebView)(void) =^{
        NSString *fullURL = [NSString stringWithFormat:@"http://en.wikipedia.org/wiki/Halloween"];
        
        NSURL *halloweenURL = [NSURL URLWithString:fullURL];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:halloweenURL];
        
        [_halloweenWebView loadRequest:request];
    };
    
    blockWebView();
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    [_loadingIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_loadingIndicator stopAnimating];
    [_loadingIndicator removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_halloweenWebView release];
    [_mainMenuBtn release];
    [_loadingIndicator release];
    [super dealloc];
}
@end
