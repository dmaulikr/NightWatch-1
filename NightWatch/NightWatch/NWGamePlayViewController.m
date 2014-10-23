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
const int CROSS_POSITION_Y = 250;

@interface NWGamePlayViewController ()

@property (retain, nonatomic) IBOutlet UILabel *highScoreLbl;
@property (retain, nonatomic) NSDictionary *dictJSON;

@property (retain, nonatomic) NWCross *cross;
@property (retain, nonatomic) NWGhost *ghost;

@property (assign, nonatomic) BOOL objectTouched;

@property (assign, nonatomic) int randomPositionx;
@property (assign, nonatomic) int randomPositiony;

@property (retain, nonatomic) NSMutableArray *arrayPositions;



@end

@implementation NWGamePlayViewController


- (void) viewWillAppear:(BOOL)animated
{
    
    _randomPosition = [NSNumber numberWithInt:arc4random() % ([_arrayPositions count] - 1)];
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
    _ghost = [[[NWGhost alloc]initWithFrame:ghostFrame]autorelease];
    [self.view addSubview:_ghost];
    [self attack:_ghost.layer];
    
    //Instantiate Cross
    _cross = [[[NWCross alloc]init]autorelease];
    
    int randomFromFiveDefaultPositions = [_cross.arrayPositions[[_cross.randomPosition intValue]]intValue];
    
    CGRect crossframe = CGRectMake(randomFromFiveDefaultPositions, CROSS_POSITION_Y, CROSS_WIDTH, CROSS_HEIGHT);
    
    _cross.frame  = crossframe;
    
    [self.view addSubview:_cross];
    _cross.userInteractionEnabled = YES;
    
    _arrayPositions = [[NSMutableArray alloc]initWithObjects:_cross.CROSS_POSITION_Y1,_cross.CROSS_POSITION_Y2, _cross.CROSS_POSITION_Y3,nil];
    
    NSLog(@"%d",[_cross.arrayPositions[[_cross.randomPosition intValue]]intValue]);
    
    
}




- (void)attack:(CALayer *)layer
{
    NSString *keyPath = @"transform.translation.x";
    
    CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    
    translation.duration = 4.0f;
//    translation.repeatCount = HUGE_VAL;

    
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
    
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    if ([touch.view isKindOfClass: NWCross.class]) {
        _objectTouched = TRUE;
       
    }

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_objectTouched){
            UITouch *touch = [[event allTouches]anyObject];
            CGPoint touchPoint = [touch locationInView:self.view];
            _cross.frame = CGRectMake(touchPoint.x - (CROSS_WIDTH/2),
                                      touchPoint.y - (CROSS_HEIGHT/2),
                                      CROSS_WIDTH,
                                      CROSS_HEIGHT);
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_objectTouched){
        int randomFromFiveDefaultPositions = [_cross.arrayPositions[[_cross.randomPosition intValue]]intValue];
        CGRect crossframe = CGRectMake(randomFromFiveDefaultPositions, CROSS_POSITION_Y, CROSS_WIDTH, CROSS_HEIGHT);
        _cross.frame = crossframe;
    }
    _objectTouched = FALSE;
}


- (void)dealloc {
    [_highScoreLbl release];
    [super dealloc];
}


@end
