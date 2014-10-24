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
@property (assign, nonatomic) CGRect ghostFrame;
@property (retain, nonatomic) NSMutableArray *arrayPositions;
@property (retain, nonatomic) NSNumber *randomPosition, *frameX, *frameWidth, *frameHeight;
@property (retain, nonatomic) CAKeyframeAnimation *attack;
@property (assign, nonatomic) float startPosForAnimation;


- (BOOL)wasIntersectedByCross:(CGRect)collider;
- (NSNumber *)randomPositions:(NSMutableArray *)array;


@end
