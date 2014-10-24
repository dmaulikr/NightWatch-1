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

- (BOOL)wasIntersectedByCross;
- (void)die;
- (void)animateAttack:(CALayer *)layer;

@end
