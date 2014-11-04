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
    [super dealloc];
}

- (id)init
{
    self = [super init];

    if (self) {
        self.image = [UIImage imageNamed:CROSS_IMAGE_NAME];
        _CROSS_POSITION_X = 410;
        _CROSS_HEIGHT = 75;
        _CROSS_WIDTH = 75;
        
        NSNumber *Y1 = [NSNumber numberWithInt:28];
        NSNumber *Y2 = [NSNumber numberWithInt:135];
        NSNumber *Y3 = [NSNumber numberWithInt:243];
        
        _arrayPositions = [[NSMutableArray alloc]initWithObjects:Y1,Y2,Y3, nil];
        
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
