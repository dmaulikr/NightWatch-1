//
//  NWCross.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/23/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWCross.h"

NSString *crossImageName = @"Cross";


@implementation NWCross


- (id)init
{

    self = [super init];

    if (self) {
        self.image = [UIImage imageNamed:crossImageName];
        _CROSS_POSITION_Y1 = [NSNumber numberWithInt:28];
        _CROSS_POSITION_Y2 = [NSNumber numberWithInt:135];
        _CROSS_POSITION_Y3 = [NSNumber numberWithInt:243];
        _CROSS_POSITION_X = 410;
        _CROSS_HEIGHT = 75;
        _CROSS_WIDTH = 75;
        
        
        _arrayPositions = [[NSMutableArray alloc]initWithObjects:_CROSS_POSITION_Y1,
                           _CROSS_POSITION_Y2,
                           _CROSS_POSITION_Y3, nil];
        
        
        _Cframe = CGRectMake(_CROSS_POSITION_X, [[self randomPositions:_arrayPositions] intValue], _CROSS_WIDTH, _CROSS_HEIGHT);
        
    }
    
    return self;
}


- (NSNumber *)randomPositions:(NSMutableArray *)array
{
    _randomPosition = array[arc4random() % [array count]];
    return _randomPosition;
}


@end
