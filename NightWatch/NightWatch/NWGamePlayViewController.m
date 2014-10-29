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
#import "NWGameOverViewController.h"

const int CROSS_POSITION_Y = 250;
const int BABY_X_POSITION = 300;

NSString *boomImage = @"boom";

BOOL didCountScore = FALSE;
BOOL highScoreAlertCalled = FALSE;
BOOL gameOverScreenCalled;




@interface NWGamePlayViewController ()

@property (retain, nonatomic) IBOutlet UILabel *highScoreLbl;
@property (retain, nonatomic) IBOutlet UILabel *yourScoreLbl;

@property (retain, nonatomic) NWCross *cross;
//@property (retain, nonatomic) NWGhost *ghost;

@property (retain, nonatomic) NSTimer *ghostFirer;
@property (retain, nonatomic) NSTimer *collisionChecker;

@property (retain, nonatomic) NSMutableArray *arrayOfIncomingGhosts;

@property (assign, nonatomic) BOOL crossIsTouched;
@property (assign, nonatomic) NSInteger ghostsInScreen;


@property (assign, nonatomic) CGFloat ghostFirerInterval;

- (void)gameOver;


@end


@implementation NWGamePlayViewController

- (void)dealloc
{
    [_highScoreLbl release];
    [_yourScoreLbl release];
    [_randomPosition release];
    [_savedScore release];
    [_cross release];
    [_ghostFirer release];
    [_collisionChecker release];
    [_arrayOfIncomingGhosts release];
    
    _highScoreLbl = nil;
    _yourScoreLbl = nil;
    _randomPosition = nil;
    _savedScore = nil;
    _cross = nil;
    _ghostFirer = nil;
    _collisionChecker = nil;
    _arrayOfIncomingGhosts = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeGame];
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
    if (_crossIsTouched) {
        _cross.frame = CGRectMake(_cross.CROSS_POSITION_X, [_cross randomPositions:_cross.arrayPositions],
                                  _cross.CROSS_WIDTH, _cross.CROSS_HEIGHT);
    }
    _crossIsTouched = FALSE;
}

-(void)checkCollision
{
    for (int i = 0; i<_ghostsInScreen; i++) {
        if (CGRectIntersectsRect(_cross.frame, [[[_arrayOfIncomingGhosts[i] layer] presentationLayer] frame])) {
            NWGhost *thisGhost = _arrayOfIncomingGhosts[i];
            thisGhost.image = [UIImage imageNamed:boomImage];
            
            if (didCountScore == FALSE) {
                _yourScore++;
                _yourScoreLbl.text = [NSString stringWithFormat:@"%ld",(long)_yourScore];
                didCountScore = TRUE;
                [self explodeGhost:thisGhost];
            }
        }
    }
}

-(void)ghostsArrive
{
    
    [_arrayOfIncomingGhosts addObject:[[[NWGhost alloc]init]autorelease]];
    
    NWGhost *currentGhost = _arrayOfIncomingGhosts[_ghostsInScreen];
    
    CGRect startFrame = CGRectMake([[currentGhost frameX]floatValue],
                                   [currentGhost startPosForAnimation],
                                   [[currentGhost frameWidth]floatValue],
                                   [[currentGhost frameHeight]floatValue]);

    CGRect endFrame   = CGRectMake(BABY_X_POSITION,
                                   [currentGhost startPosForAnimation],
                                   [[currentGhost frameWidth]floatValue],
                                   [[currentGhost frameHeight]floatValue]);
    
    [currentGhost setFrame:startFrame];
    [self.view addSubview:currentGhost];
    
    
    [UIView animateWithDuration:2.0
                     animations:^{
                            [currentGhost setFrame:endFrame];
                        }
                     completion:^(BOOL finished) {
                         
                            [_arrayOfIncomingGhosts removeObject:currentGhost];
                            _ghostsInScreen--;
                            [currentGhost removeFromSuperview];
                         
                            if (currentGhost.image != [UIImage imageNamed:boomImage] &&
                                gameOverScreenCalled == FALSE ) {
                                [self gameOver];
                            }
                        }];
    _ghostsInScreen++;
}

-(void)initializeGame
{
    _cross = [[NWCross alloc]init];
    _cross.frame = _cross.Cframe;
    _cross.userInteractionEnabled = TRUE;
    
    [self.view addSubview:_cross];
    
    _savedScore = [NSUserDefaults standardUserDefaults];
    [_savedScore synchronize];
    
    NSObject *object = [_savedScore objectForKey:@"highScore"];
    
    if(object != nil){
        _highScoreLbl.text = [NSString stringWithFormat:@"%@",[_savedScore objectForKey:@"highScore"]];
    }
    
    _highScore = [[_savedScore objectForKey:@"highScore"]intValue];
    _arrayOfIncomingGhosts = [[NSMutableArray alloc]init];
    _ghostFirerInterval = 0.4;
    
    _ghostFirer = [NSTimer timerWithTimeInterval:_ghostFirerInterval
                                          target:self
                                        selector:@selector(ghostsArrive)
                                        userInfo:nil
                                         repeats:YES];
    
    _collisionChecker = [NSTimer timerWithTimeInterval:0.25
                                                target:self
                                              selector:@selector(checkCollision)
                                              userInfo:nil
                                               repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_ghostFirer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop mainRunLoop] addTimer:_collisionChecker forMode:NSDefaultRunLoopMode];
    
    gameOverScreenCalled = FALSE;
}

-(void)gameOver
{
    
    [_arrayOfIncomingGhosts release];
    [_cross release];
    
    _arrayOfIncomingGhosts = nil;
    
    [_savedScore setObject:[NSNumber numberWithInteger:_yourScore] forKey:@"yourScore"];
    
    [_ghostFirer invalidate];
    _ghostFirer = nil;
    
    NWGameOverViewController *gameOver = [[[NWGameOverViewController alloc] initWithCurrentScore:_yourScore]autorelease];
    
    UINavigationController *navController = self.navigationController;

    [navController pushViewController:gameOver animated:NO];
    gameOverScreenCalled = TRUE;

}

- (void)explodeGhost: (NWGhost *)ghost
{
    ghost.image = [UIImage imageNamed:boomImage];
    
    double delayInSeconds = 0.2;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [ghost removeFromSuperview];
        didCountScore = FALSE;
    });

}

@end
