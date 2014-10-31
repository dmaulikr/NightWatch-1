//
//  NWHighScoreManager.h
//  NightWatch
//
//  Created by Marvin Labrador on 10/31/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NWHighScoreManager : NSObject

- (BOOL) isHighScore:(NSInteger)score;
- (NSNumber *) retrieveHighScore;
- (void) setScoreAsHighScore:(NSInteger)score;

@end
