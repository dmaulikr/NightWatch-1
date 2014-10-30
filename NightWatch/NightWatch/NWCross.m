//
//  NWCross.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/23/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWCross.h"

NSString *const CROSS_IMAGE_NAME = @"Cross";


@implementation NWCross

- (void)dealloc
{
    self.arrayPositions = nil;
    self.CROSS_POSITION_Y1 = nil;
    self.CROSS_POSITION_Y2 = nil;
    self.CROSS_POSITION_Y3 = nil;
    
    [super dealloc];
}

- (id)init
{
    self = [super init];

    if (self) {
        self.image = [UIImage imageNamed:CROSS_IMAGE_NAME];
        _CROSS_POSITION_Y1 = [NSNumber numberWithInt:28];
        _CROSS_POSITION_Y2 = [NSNumber numberWithInt:135];
        _CROSS_POSITION_Y3 = [NSNumber numberWithInt:243];
        _CROSS_POSITION_X = 410;
        _CROSS_HEIGHT = 75;
        _CROSS_WIDTH = 75;
        
        _arrayPositions = [[NSMutableArray alloc]initWithObjects:_CROSS_POSITION_Y1,
                           _CROSS_POSITION_Y2,
                           _CROSS_POSITION_Y3, nil];
        
        _crossFrame = CGRectMake(_CROSS_POSITION_X, [self randomPositions:_arrayPositions], _CROSS_WIDTH, _CROSS_HEIGHT);
    }
    return self;
}

- (NSInteger)randomPositions:(NSMutableArray *)array
{
    _randomPosition = [array[arc4random() % [array count]]integerValue];
    return _randomPosition;
}


@end
