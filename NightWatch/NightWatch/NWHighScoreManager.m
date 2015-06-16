//
//  NWHighScoreManager.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/31/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWHighScoreManager.h"

NSString *const HIGH_SCOREKEY = @"highScore";

@implementation NWHighScoreManager

-(void) dealloc
{
    [super dealloc];
}
-(void) setScoreAsHighScore:(NSInteger)score
{
    NSNumber *scoreObject = [NSNumber numberWithInteger:score];
    [[NSUserDefaults standardUserDefaults]setObject:scoreObject forKey:HIGH_SCOREKEY];
}

-(NSNumber *) retrieveHighScore
{
    NSNumber *returnHighScore = [[NSUserDefaults standardUserDefaults] objectForKey:HIGH_SCOREKEY];
    return returnHighScore;
}

- (BOOL) isHighScore:(NSInteger)score
{
    NSInteger highScore = [[[NSUserDefaults standardUserDefaults] valueForKey:HIGH_SCOREKEY] intValue];
    
    if (score > highScore) {
        return TRUE;
    }
    return  FALSE;
    
}


@end
