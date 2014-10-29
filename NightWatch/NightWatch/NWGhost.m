//
//  NWGhost.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/23/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWGhost.h"

NSString *AGhostImageName = @"Ghost";
NSString *jsonName = @"ghost";
NSString *jsonType = @"json";
NSString *jsonKeyFrameX = @"frame.x";
NSString *jsonKeyFrameWidth = @"frame.width";
NSString *jsonKeyFrameHeight = @"frame.height";
NSString *jsonKeyFrameY1 = @"frame.y";
NSString *jsonKeyFrameY2 = @"frame.y2";
NSString *jsonKeyFrameY3 = @"frame.y3";


@implementation NWGhost


- (id)init
{
    
    self = [super init];
    if (self) {
    
        self.image = [UIImage imageNamed:AGhostImageName];
        //Fetching the Data from ghost.json
        NSString *JSONFilePath = [[NSBundle mainBundle]pathForResource:jsonName
                                                                ofType:jsonType];
        
        NSData *JSONData = [NSData dataWithContentsOfFile:JSONFilePath];
        self.dictJSON = [[[NSDictionary alloc]init]autorelease];
        self.dictJSON = [NSJSONSerialization
                         JSONObjectWithData:JSONData
                         options:kNilOptions
                         error:nil];
        
        _frameX = [self.dictJSON objectForKey:jsonKeyFrameX];
        _frameWidth = [self.dictJSON objectForKey:jsonKeyFrameWidth];
        _frameHeight = [self.dictJSON objectForKey:jsonKeyFrameHeight];
        
        _arrayPositions = [[[NSMutableArray alloc]initWithObjects:[self.dictJSON objectForKey:jsonKeyFrameY1],
                                                                  [self.dictJSON objectForKey:jsonKeyFrameY2],
                                                                  [self.dictJSON objectForKey:jsonKeyFrameY3],
                                                                   nil]autorelease];
        
        //Assign the object Frame and Start location
        _ghostFrame = CGRectMake([_frameX floatValue],
                                 [self randomPositions:_arrayPositions],
                                 [_frameWidth floatValue],
                                 [_frameHeight floatValue]);
        
        _startPosForAnimation = [self randomPositions:_arrayPositions];

    }
    return self;
}


- (NSInteger)randomPositions:(NSMutableArray *)array
{
    _randomPosition = [array[arc4random() % [array count]]integerValue];
    return _randomPosition;
}




@end
