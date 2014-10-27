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
const int BABY_X_POSITION = 350;
NSString *boomImage = @"boom";
NSInteger ghostFirerInterval = 2.0;
BOOL didScore = FALSE;

@interface NWGamePlayViewController ()

@property (retain, nonatomic) IBOutlet UILabel *highScoreLbl;
@property (retain, nonatomic) IBOutlet UILabel *yourScoreLbl;

@property (retain, nonatomic) NWCross *cross;
@property (readwrite, retain, nonatomic) NWGhost *ghost;

@property (retain, nonatomic) NSTimer *ghostFirer;
@property (readwrite, retain, nonatomic) NSMutableArray *arrayOfIncomingGhosts;

@property (assign, nonatomic) BOOL crossIsTouched;
@property (assign, nonatomic) NSInteger ghostsInScreen;
@property (assign, nonatomic) NSInteger yourScore;
@property (assign, nonatomic) NSInteger highScore;
@property (retain, nonatomic) NSUserDefaults *savedHighScore;

@end

@implementation NWGamePlayViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _cross = [[[NWCross alloc]init]autorelease];
    _cross.frame = _cross.Cframe;
    _cross.userInteractionEnabled = TRUE;
    [self.view addSubview:_cross];
    
    _savedHighScore = [NSUserDefaults standardUserDefaults];
    [_savedHighScore synchronize];
    _highScoreLbl.text = [NSString stringWithFormat:@"%@",[_savedHighScore objectForKey:@"highScore"]];

    _highScore = [[_savedHighScore objectForKey:@"highScore"]intValue];
    
    _arrayOfIncomingGhosts = [[NSMutableArray alloc]init];
    _ghostFirer = [NSTimer timerWithTimeInterval:ghostFirerInterval
                                         target:self
                                       selector:@selector(ghostsArrive)
                                       userInfo:nil
                                        repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_ghostFirer forMode:NSDefaultRunLoopMode];

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
        [self checkCollision];
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


- (void)dealloc
{
    [_highScoreLbl release];
    [_yourScoreLbl release];
    [super dealloc];
}

-(void)checkCollision
{
 
    for (int i = 0; i<_ghostsInScreen; i++) {
        
        if (CGRectIntersectsRect(_cross.frame, [[[_arrayOfIncomingGhosts[i] layer] presentationLayer] frame])) {
            _yourScore++;
            _yourScoreLbl.text = [NSString stringWithFormat:@"%d",_yourScore];

            NWGhost *thisGhost = _arrayOfIncomingGhosts[i];
            thisGhost.image = [UIImage imageNamed:boomImage];

            double delayInSeconds = 0.4;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [thisGhost removeFromSuperview];
            });
        }
        
    }
}

-(void)ghostsArrive
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
    
    [UIView animateWithDuration:2.0
                     animations:^{
                            [currentGhost setFrame:endFrame];
                        }
                     completion:^(BOOL finished) {
                            [_arrayOfIncomingGhosts removeObject:currentGhost];
                            _ghostsInScreen--;
                            [currentGhost removeFromSuperview];

                            if (currentGhost.image != [UIImage imageNamed:boomImage]) {
                                [_ghostFirer invalidate];
                                _ghostFirer = nil;
                                NWGameOverViewController *gameOver = [[[NWGameOverViewController alloc]init]autorelease];

                                [self.navigationController pushViewController:gameOver animated:NO];
                                
                                if (_yourScore > _highScore) {
                                    UIAlertView *newHighScore = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%d",_yourScore] message:@"You set a new High Score" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                    [newHighScore show];
                                    
                                    [_savedHighScore setObject:[NSNumber numberWithInteger:_yourScore] forKey:@"highScore"];
                                }
                            }
                        }];

    _ghostsInScreen++;
}

@end
