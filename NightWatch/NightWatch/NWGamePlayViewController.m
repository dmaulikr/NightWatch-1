//
//  NWGamePlayViewController.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/22/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWGhost.h"
#import "NWCross.h"
#import "NWGamePlayViewController.h"
#import "NWGameOverViewController.h"

const NSInteger CROSS_POSITION_Y = 250;
const NSInteger BABY_X_POSITION = 300;

const CGFloat GHOST_ANIMATE_DURATION = 2.0;
const CGFloat GHOST_EXPLODE_DELAY = 0.2;
const CGFloat COLLISION_TIMER_DELAY = 0.25;
const CGFloat GHOST_ARRIVAL_TIMER_DELAY = 0.25;

NSString *const BOOM_IMAGE = @"boom";
NSString *const HIGH_SCORE_KEY1 = @"highScore";
NSString *const YOUR_SCORE_KEY1 = @"yourScore";

BOOL didCountScore = FALSE;
BOOL highScoreAlertCalled = FALSE;
BOOL gameOverScreenCalled;
BOOL crossIsTouched;


@interface NWGamePlayViewController ()

@property (retain, nonatomic) IBOutlet UILabel *highScoreLbl;
@property (retain, nonatomic) IBOutlet UILabel *yourScoreLbl;
@property (retain, nonatomic) NWCross *cross;
@property (retain, nonatomic) NSTimer *ghostFirer;
@property (retain, nonatomic) NSTimer *collisionChecker;
@property (assign, nonatomic) NSInteger ghostsInScreen;
@property (retain, nonatomic) NSMutableArray *arrayOfIncomingGhosts;

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
    //save your touch point to a variable
    UITouch *touch = [touches anyObject];
    
    //make cross responsive to touchesMoved upon touchesBegan
    if ([touch.view isKindOfClass: NWCross.class]) {
        crossIsTouched = TRUE;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (crossIsTouched) {
        //save your touch point to a variable
        UITouch *touch = [[event allTouches]anyObject];
        CGPoint touchPoint = [touch locationInView:self.view];
        
        //continuously changes the frame of the Cross according to your touch movements
        CGRect crossFrame = CGRectMake(touchPoint.x - (_cross.CROSS_WIDTH/2),
                                        touchPoint.y - (_cross.CROSS_HEIGHT/2),
                                        _cross.CROSS_WIDTH,
                                        _cross.CROSS_HEIGHT);
        _cross.frame = crossFrame;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //make cross reappear in three random positions among the three orbs in the rightmost part of the screen
    if (crossIsTouched) {
        _cross.frame = CGRectMake(_cross.CROSS_POSITION_X, [_cross randomPositions:_cross.arrayPositions],
                                  _cross.CROSS_WIDTH, _cross.CROSS_HEIGHT);
    }
    
    //make cross unresponsive to touchesMoved upon touchesEnd
    crossIsTouched = FALSE;
}


#pragma mark - actions in view


- (void)checkCollision
{
    //checkking ALL ghost instances onscreen
    for (int i = 0; i<_ghostsInScreen; i++) {
        
        //collision detected
        if (CGRectIntersectsRect(_cross.frame, [[[_arrayOfIncomingGhosts[i] layer] presentationLayer] frame])) {
            //store the collided ghost into a variable
            NWGhost *thisGhost = _arrayOfIncomingGhosts[i];
            
            //added this filter to increment score only once despite continuous loop
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
    //method will be called continuously via _ghostFirer NSTimer
    //instantiate a ghost object
    [_arrayOfIncomingGhosts addObject:[[NWGhost alloc]init]];
    
    NWGhost *currentGhost = _arrayOfIncomingGhosts[_ghostsInScreen];
    
    //set frames for animation
    CGRect startFrame = CGRectMake([[currentGhost frameX]floatValue],
                                   [currentGhost startPosForAnimation],
                                   [[currentGhost frameWidth]floatValue],
                                   [[currentGhost frameHeight]floatValue]);

    CGRect endFrame   = CGRectMake(BABY_X_POSITION,
                                   [currentGhost startPosForAnimation],
                                   [[currentGhost frameWidth]floatValue],
                                   [[currentGhost frameHeight]floatValue]);
    
    //make the ghost appear in screen
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
                            if (currentGhost.image != [UIImage imageNamed:BOOM_IMAGE] &&
                                gameOverScreenCalled == FALSE ) {
                                [self gameOver];
                            }
                            [currentGhost release];
                        }];
    
    //count the ghosts onscreen
    _ghostsInScreen++;
}

- (void)initializeGame
{
    //reset current score
    _yourScore = 0;
    _yourScoreLbl.text = [NSString stringWithFormat:@"%ld", (long)_yourScore];
    
    //make the cross appear
    _cross = [[NWCross alloc]init];
    _cross.frame = _cross.Cframe;
    _cross.userInteractionEnabled = TRUE;
    
    [self.view addSubview:_cross];
    
    //display the saved highscore
    _savedScore = [NSUserDefaults standardUserDefaults];
    [_savedScore synchronize];
    
    NSObject *object = [_savedScore objectForKey:HIGH_SCORE_KEY1];
    
    if (object != nil) {
        _highScoreLbl.text = [NSString stringWithFormat:@"%@",[_savedScore objectForKey:HIGH_SCORE_KEY1]];
    }
    
    _highScore = [[_savedScore objectForKey:HIGH_SCORE_KEY1]intValue];
    
    //allocate Array for incoming ghost instances
    _arrayOfIncomingGhosts = [[NSMutableArray alloc]init];
    
    //start continuous firing ghosts
    _ghostFirer = [NSTimer timerWithTimeInterval:GHOST_ARRIVAL_TIMER_DELAY
                                          target:self
                                        selector:@selector(ghostsArrive)
                                        userInfo:nil
                                         repeats:YES];
    
    //start continuous collision checking
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
    [_savedScore setObject:[NSNumber numberWithInteger:_yourScore] forKey:YOUR_SCORE_KEY1];
    
    //invalidate the timers
    [_ghostFirer invalidate];
    _ghostFirer = nil;
    
    [_collisionChecker invalidate];
    _collisionChecker = nil;
    
    NWGameOverViewController *gameOver = [[NWGameOverViewController alloc] initWithCurrentScore:_yourScore];

    [self.navigationController pushViewController:gameOver animated:NO];
    gameOverScreenCalled = TRUE;
    
    [gameOver release];
}

- (void)explodeGhost: (NWGhost *)ghost
{
    ghost.image = [UIImage imageNamed:BOOM_IMAGE];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(GHOST_EXPLODE_DELAY * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [ghost removeFromSuperview];
        didCountScore = FALSE;
    });
}

@end
