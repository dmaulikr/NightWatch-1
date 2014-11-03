//
//  NWGhost.h
//  NightWatch
//
//  Created by Marvin Labrador on 10/23/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NWGhost : UIImageView

@property (retain, nonatomic) NSDictionary *dictJSON;
@property (retain, nonatomic) NSMutableArray *arrayPositions;
@property (retain, nonatomic) NSNumber *frameX;
@property (retain, nonatomic) NSNumber *frameWidth;
@property (retain, nonatomic) NSNumber *frameHeight;
@property (retain, nonatomic) CAKeyframeAnimation *attack;

@property (assign, nonatomic) CGFloat startPosForAnimation;
@property (assign, nonatomic) CGRect ghostFrameStart;
@property (assign, nonatomic) CGRect ghostFrameEnd;
@property (assign, nonatomic) NSInteger randomPosition;

- (NSInteger)randomPositions:(NSMutableArray *)array;


@end
