//
//  NWGamePlayViewController.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/22/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWGamePlayViewController.h"
#import "NWGhost.h"


@interface NWGamePlayViewController ()
@property (retain, nonatomic) IBOutlet UILabel *highScoreLbl;
@property (retain, nonatomic) NSDictionary *dictJSON;

@end

@implementation NWGamePlayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        

        
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //Fetching the Data from ghost.json
    NSString *JSONFilePath = [[NSBundle mainBundle]pathForResource:@"ghost"
                                                            ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:JSONFilePath];
    self.dictJSON = [[[NSDictionary alloc]init]autorelease];
    self.dictJSON = [NSJSONSerialization
                           JSONObjectWithData:JSONData
                           options:kNilOptions
                           error:nil];
    

    
    NSNumber *frameX = [self.dictJSON objectForKey:@"frame.x"];
    NSNumber *frameY = [self.dictJSON objectForKey:@"frame.y"];
    NSNumber *frameWidth = [self.dictJSON objectForKey:@"frame.width"];
    NSNumber *frameHeight = [self.dictJSON objectForKey:@"frame.height"];
    
    
    //Assign the object Frame and Start location
    CGRect ghostFrame = CGRectMake([frameX floatValue],
                                   [frameY floatValue],
                                   [frameWidth floatValue],
                                   [frameHeight floatValue]);

    
    
    //Instantiate Ghost Object
    NWGhost *ghost = [[[NWGhost alloc]initWithFrame:ghostFrame]autorelease];
    [self.view addSubview:ghost];
    [self attack:ghost.layer];
    
}


- (void)attack:(CALayer *)layer
{
    NSString *keyPath = @"transform.translation.x";
    
    CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    
    translation.duration = 4.0f;
    translation.repeatCount = HUGE_VAL;

    
    NSMutableArray *values = [[[NSMutableArray alloc]init]autorelease];
    
    //start value
    [values addObject:[NSNumber numberWithFloat:0.0f]];
    
    //end value
    CGFloat width = [[UIScreen mainScreen]applicationFrame].size.width + 400;
    [values addObject:[NSNumber numberWithFloat:width]];
    translation.values = values;
    
    [layer addAnimation:translation forKey:keyPath];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_highScoreLbl release];
    [super dealloc];
}
@end
