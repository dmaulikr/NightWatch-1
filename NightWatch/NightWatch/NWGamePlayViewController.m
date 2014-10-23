//
//  NWGamePlayViewController.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/22/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWGamePlayViewController.h"
#import "NWGhost.h"
#import "NWCross.h"

const int CROSS_HEIGHT = 75;
const int CROSS_WIDTH = 50;

const int CROSS_POSITION_X1 = 350;
const int CROSS_POSITION_X2 = 0;
const int CROSS_POSITION_Y = 250;




@interface NWGamePlayViewController ()
@property (retain, nonatomic) IBOutlet UILabel *highScoreLbl;
@property (retain, nonatomic) NSDictionary *dictJSON;
@property (retain, nonatomic) NWCross *cross;
@property (assign, nonatomic) BOOL objectTouched;

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
    
     int randomPosition = CROSS_POSITION_X2 + arc4random() % (CROSS_POSITION_X1 - CROSS_POSITION_X2);
    //Instantiate Cross
    CGRect crossframe = CGRectMake(randomPosition, CROSS_POSITION_Y, CROSS_WIDTH, CROSS_HEIGHT);
    
    _cross = [[[NWCross alloc]initWithFrame:crossframe]autorelease];
    [self.view addSubview:_cross];
    
    
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
    CGFloat width = [[UIScreen mainScreen]applicationFrame].size.width + 300;
    [values addObject:[NSNumber numberWithFloat:width]];
    translation.values = values;
    
    [layer addAnimation:translation forKey:keyPath];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

            UITouch *touch = [[event allTouches]anyObject];
            CGPoint touchPoint = [touch locationInView:self.view];
            _cross.frame = CGRectMake(touchPoint.x - (CROSS_WIDTH/2),
                                      touchPoint.y - (CROSS_HEIGHT/2),
                                      CROSS_WIDTH,
                                      CROSS_HEIGHT);
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    int randomPosition = CROSS_POSITION_X2 + arc4random() % (CROSS_POSITION_X1 - CROSS_POSITION_X2);
    _cross.frame = CGRectMake(randomPosition, CROSS_POSITION_Y, CROSS_WIDTH, CROSS_HEIGHT);
}


- (void)dealloc {
    [_highScoreLbl release];
    [super dealloc];
}
@end
