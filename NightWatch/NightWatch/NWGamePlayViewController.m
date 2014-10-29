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
const CGFloat GHOST_ANIMATE_DURATION = 2.0;
const CGFloat GHOST_EXPLODE_DELAY = 0.2;
const CGFloat COLLISION_TIMER_DELAY = 0.25;
const CGFloat GHOST_ARRIVAL_TIMER_DELAY = 0.4;

NSString *boomImage = @"boom";
NSString *keyHighScore = @"highScore";
NSString *keyYourScore = @"yourScore";

BOOL didCountScore = FALSE;
BOOL highScoreAlertCalled = FALSE;
BOOL gameOverScreenCalled;


@interface NWGamePlayViewController ()

@property (retain, nonatomic) IBOutlet UILabel *highScoreLbl;
@property (retain, nonatomic) IBOutlet UILabel *yourScoreLbl;

@property (retain, nonatomic) NWCross *cross;

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
    [_cross release];
    [_ghostFirer release];
    [_collisionChecker release];
    [_arrayOfIncomingGhosts release];    
    [_randomPosition release];
    [_arrayPositions release];
    [_savedScore release];

    _highScoreLbl = nil;
    _yourScoreLbl = nil;
    _cross = nil;
    _ghostFirer = nil;
    _collisionChecker = nil;
    _arrayOfIncomingGhosts = nil;
    _randomPosition = nil;
    _savedScore = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated
{
    [self initializeGame];
    

    
}

#pragma mark - touch responder actions

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
    if (_crossIsTouched) {
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


#pragma mark - actions in view

- (void)checkCollision
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

- (void)ghostsArrive
{
    
    [_arrayOfIncomingGhosts addObject:[[NWGhost alloc]init]];
    
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
    
    
    [UIView animateWithDuration:GHOST_ANIMATE_DURATION
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
                            [currentGhost release];
                        }];
    _ghostsInScreen++;

}

- (void)initializeGame
{
    _yourScore = 0;
    _yourScoreLbl.text = [NSString stringWithFormat:@"%ld", (long)_yourScore];
    _cross = [[NWCross alloc]init];
    _cross.frame = _cross.Cframe;
    _cross.userInteractionEnabled = TRUE;
    
    [self.view addSubview:_cross];
    
    _savedScore = [NSUserDefaults standardUserDefaults];
    [_savedScore synchronize];
    
    NSObject *object = [_savedScore objectForKey:keyHighScore];
    
    if (object != nil) {
        _highScoreLbl.text = [NSString stringWithFormat:@"%@",[_savedScore objectForKey:keyHighScore]];
    }
    
    _highScore = [[_savedScore objectForKey:keyHighScore]intValue];
    _arrayOfIncomingGhosts = [[NSMutableArray alloc]init];
    _ghostFirerInterval = 0.4;
    
    _ghostFirer = [NSTimer timerWithTimeInterval:GHOST_ARRIVAL_TIMER_DELAY
                                          target:self
                                        selector:@selector(ghostsArrive)
                                        userInfo:nil
                                         repeats:YES];
    
    _collisionChecker = [NSTimer timerWithTimeInterval:COLLISION_TIMER_DELAY
                                                target:self
                                              selector:@selector(checkCollision)
                                              userInfo:nil
                                               repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_ghostFirer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop mainRunLoop] addTimer:_collisionChecker forMode:NSDefaultRunLoopMode];
    
    gameOverScreenCalled = FALSE;

}

- (void)gameOver
{

    [_cross removeFromSuperview];
    [_savedScore setObject:[NSNumber numberWithInteger:_yourScore] forKey:keyYourScore];
    
    [_ghostFirer invalidate];
    _ghostFirer = nil;
    
    NWGameOverViewController *gameOver = [[NWGameOverViewController alloc] initWithCurrentScore:_yourScore];

    [self.navigationController pushViewController:gameOver animated:NO];
    gameOverScreenCalled = TRUE;
    
    [gameOver release];
}

- (void)explodeGhost: (NWGhost *)ghost
{
    ghost.image = [UIImage imageNamed:boomImage];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(GHOST_EXPLODE_DELAY * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [ghost removeFromSuperview];
        didCountScore = FALSE;
    });
}

@end
