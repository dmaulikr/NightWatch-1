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
@property (assign, nonatomic) NSInteger randomPosition;
@property (retain, nonatomic) NSNumber *frameX;
@property (retain, nonatomic) NSNumber *frameWidth;
@property (retain, nonatomic) NSNumber *frameHeight;
@property (retain, nonatomic) CAKeyframeAnimation *attack;
@property (assign, nonatomic) CGFloat startPosForAnimation;


- (BOOL)wasIntersectedByCross:(CGRect)collider;
- (NSInteger)randomPositions:(NSMutableArray *)array;


@end
