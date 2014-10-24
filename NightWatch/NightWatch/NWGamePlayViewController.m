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


const int CROSS_POSITION_Y = 250;

@interface NWGamePlayViewController ()

@property (retain, nonatomic) IBOutlet UILabel *highScoreLbl;

@property (retain, nonatomic) NWCross *cross;
@property (retain, nonatomic) NWGhost *ghost;

@property (assign, nonatomic) BOOL crossIsTouched;

@end

@implementation NWGamePlayViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _cross = [[[NWCross alloc]init]autorelease];
    _cross.frame = _cross.Cframe;
    _cross.userInteractionEnabled = TRUE;
    
    [self.view addSubview:_cross];

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    if ([touch.view isKindOfClass: NWCross.class]) {
        _crossIsTouched = TRUE;
       
    }

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_crossIsTouched){
            UITouch *touch = [[event allTouches]anyObject];
            CGPoint touchPoint = [touch locationInView:self.view];
            CGRect crossFrame = CGRectMake(touchPoint.x - (_cross.CROSS_WIDTH/2),
                                           touchPoint.y - (_cross.CROSS_HEIGHT/2),
                                           _cross.CROSS_WIDTH,
                                           _cross.CROSS_HEIGHT);
        _cross.frame = crossFrame;
        

    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_crossIsTouched){
        _cross.frame = CGRectMake(_cross.CROSS_POSITION_X, [[_cross randomPositions:_cross.arrayPositions] intValue],
                                  _cross.CROSS_WIDTH, _cross.CROSS_HEIGHT);
        
        NSLog(@"%d, %d, %d, %d", _cross.CROSS_POSITION_X, [_cross.randomPosition intValue],
              _cross.CROSS_WIDTH, _cross.CROSS_HEIGHT);
    }
    _crossIsTouched = FALSE;
}


- (void)dealloc {
    [_highScoreLbl release];
    [super dealloc];
}


@end
