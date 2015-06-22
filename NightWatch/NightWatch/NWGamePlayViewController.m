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
#import "NWHighScoreManager.h"
#import "NWSound.h"


const NSInteger CROSS_POSITION_Y = 250;
NSInteger BABY_X_POSITION = 0;

const CGFloat EXPLOSION_ALPHA = 1.0;
const CGFloat GHOST_ANIMATE_DURATION = 2.0;
const CGFloat GHOST_EXPLODE_DELAY = 0.2;
const CGFloat COLLISION_TIMER_DELAY = 0.25;
const CGFloat GHOST_ARRIVAL_TIMER_DELAY = 0.45;

NSString *const BOOM_IMAGE = @"boom";

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
    self.highScoreLbl = nil;
    self.yourScoreLbl = nil;
    self.cross = nil;
    self.ghostFirer = nil;
    self.collisionChecker = nil;
    self.arrayOfIncomingGhosts = nil;
    self.randomPosition = nil;
    self.arrayPositions = nil;
 
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [NWSound playBGM:NWBGMTypeGame];
    BABY_X_POSITION = [[UIScreen mainScreen]bounds].size.height - 175;
    [self initializeGame];
}


#pragma mark - touch responder actions


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass: NWCross.class]) {
        crossIsTouched = TRUE;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (crossIsTouched) {

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
    if (crossIsTouched) {
        _cross.frame = CGRectMake(_cross.CROSS_POSITION_X, [_cross randomPositions:_cross.arrayPositions],
                                  _cross.CROSS_WIDTH, _cross.CROSS_HEIGHT);
    }
    crossIsTouched = FALSE;
}


#pragma mark - actions in view


- (void)checkCollision
{
    for (int i = 0; i<_ghostsInScreen; i++) {
        
        if (CGRectIntersectsRect(_cross.frame, [[[_arrayOfIncomingGhosts[i] layer] presentationLayer] frame])) {
            NWGhost *thisGhost = _arrayOfIncomingGhosts[i];
            
            if (didCountScore == FALSE) {
                [NWSound play:NWSFXTypeBurn];
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

    NWGhost *ghostForArray = [[NWGhost alloc]init];
    [_arrayOfIncomingGhosts addObject:ghostForArray];
    
    CGRect startFrame = ghostForArray.ghostFrameStart;

    CGRect endFrame   = CGRectMake(BABY_X_POSITION,
                                   [ghostForArray startPosForAnimation],
                                   [[ghostForArray frameWidth]floatValue],
                                   [[ghostForArray frameHeight]floatValue]);


    [ghostForArray setFrame:startFrame];
    
    [self.view addSubview:ghostForArray];
    
    [UIView animateWithDuration:GHOST_ANIMATE_DURATION
                     animations:^{
                            [ghostForArray setFrame:endFrame];
                        }
                     completion:^(BOOL finished) {
                         [_arrayOfIncomingGhosts removeObject:ghostForArray];
                         _ghostsInScreen--;
                         if (ghostForArray.image != [UIImage imageNamed:BOOM_IMAGE]) {
                             [ghostForArray removeFromSuperview];
                             [ghostForArray release];
                             if (gameOverScreenCalled == FALSE )
                             {
                                 [self gameOver];
                             }
                            }
                        }];
    _ghostsInScreen++;
}

- (void)initializeGame
{
    _yourScore = 0;
    _yourScoreLbl.text = [NSString stringWithFormat:@"%ld", (long)_yourScore];
    
    _cross = [[NWCross alloc]init];
    _cross.frame = _cross.crossFrame;
    _cross.userInteractionEnabled = TRUE;
    
    [self.view addSubview:_cross];

    NWHighScoreManager *highScoreMgr = [[NWHighScoreManager alloc]init];
    
    NSNumber *highScoreObject = [highScoreMgr retrieveHighScore];
    if (highScoreObject != nil) {
        _highScoreLbl.text = [NSString stringWithFormat:@"%@",highScoreObject];
    }
    
    [highScoreMgr release];
    
    _arrayOfIncomingGhosts = [[NSMutableArray alloc]init];
    
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
    [NWSound stopBGM];
    [_ghostFirer invalidate];
    [_collisionChecker invalidate];
    _ghostFirer = nil;
    _collisionChecker = nil;
    
    [_cross removeFromSuperview];
    
    self.cross = nil;
    self.arrayOfIncomingGhosts = nil;
    
    NWGameOverViewController *gameOverViewController = [[NWGameOverViewController alloc] initWithCurrentScore:_yourScore];
    
    [self.navigationController pushViewController:gameOverViewController animated:NO];
    gameOverScreenCalled = TRUE;
    
    [gameOverViewController release];
}

- (void)explodeGhost: (NWGhost *)ghost
{
    ghost.image = [UIImage imageNamed:BOOM_IMAGE];
    ghost.alpha = EXPLOSION_ALPHA;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(GHOST_EXPLODE_DELAY * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [ghost removeFromSuperview];
        
        didCountScore = FALSE;
    });
    
    
}

@end
