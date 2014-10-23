//
//  NWCross.h
//  NightWatch
//
//  Created by Marvin Labrador on 10/23/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NWCross : UIImageView

@property (assign, nonatomic) CGRect Cframe;
@property (assign, nonatomic) const int CROSS_HEIGHT, CROSS_WIDTH;
@property (retain, nonatomic) NSMutableArray *arrayPositions;
@property (retain, nonatomic) NSNumber *CROSS_POSITION_Y1, *CROSS_POSITION_Y2, *CROSS_POSITION_Y3, *randomPosition;


@end
