//
//  NWGhost.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/23/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWGhost.h"

NSString *AGhostImageName = @"Ghost";
NSString *keyPath = @"transform.translation.x";

@implementation NWGhost

- (id)init
{
    
    self = [super init];
    if (self) {
    
        self.image = [UIImage imageNamed:AGhostImageName];
        //Fetching the Data from ghost.json
        NSString *JSONFilePath = [[NSBundle mainBundle]pathForResource:@"ghost"
                                                                ofType:@"json"];
        NSData *JSONData = [NSData dataWithContentsOfFile:JSONFilePath];
        self.dictJSON = [[[NSDictionary alloc]init]autorelease];
        self.dictJSON = [NSJSONSerialization
                         JSONObjectWithData:JSONData
                         options:kNilOptions
                         error:nil];
        
        _frameX = [self.dictJSON objectForKey:@"frame.x"];
        _frameWidth = [self.dictJSON objectForKey:@"frame.width"];
        _frameHeight = [self.dictJSON objectForKey:@"frame.height"];
        
        _arrayPositions = [[[NSMutableArray alloc]initWithObjects:[self.dictJSON objectForKey:@"frame.y"],
                                                                  [self.dictJSON objectForKey:@"frame.y2"],
                                                                  [self.dictJSON objectForKey:@"frame.y3"],
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
