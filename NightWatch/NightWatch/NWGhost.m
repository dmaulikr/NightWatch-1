//
//  NWGhost.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/23/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

const CGFloat ALPHA_GHOST = 0.35;

#import "NWGhost.h"

NSString *const GHOST_IMAGE_NAME = @"Ghost";
NSString *const JSON_NAME = @"ghost";
NSString *const JSON_TYPE = @"json";
NSString *const JSON_KEYFRAMEX = @"frame.x";
NSString *const JSON_KEYFRAMEWIDTH = @"frame.width";
NSString *const JSON_KEYFRAMEHEIGHT = @"frame.height";
NSString *const JSON_KEYFRAMEY1 = @"frame.y";
NSString *const JSON_KEYFRAMEY2 = @"frame.y2";
NSString *const JSON_KEYFRAMEY3 = @"frame.y3";


@implementation NWGhost

- (void)dealloc
{
    self.dictJSON = nil;
    self.attack = nil;
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.image = [UIImage imageNamed:GHOST_IMAGE_NAME];
        self.alpha = ALPHA_GHOST;
        //Fetching the Data from ghost.json
        NSString *JSONFilePath = [[NSBundle mainBundle]pathForResource:JSON_NAME
                                                                ofType:JSON_TYPE];
        
        NSData *JSONData = [NSData dataWithContentsOfFile:JSONFilePath];
        self.dictJSON = [[NSDictionary alloc]init];
        self.dictJSON = [NSJSONSerialization
                         JSONObjectWithData:JSONData
                         options:kNilOptions
                         error:nil];
        
        _frameX = [self.dictJSON objectForKey:JSON_KEYFRAMEX];
        _frameWidth = [self.dictJSON objectForKey:JSON_KEYFRAMEWIDTH];
        _frameHeight = [self.dictJSON objectForKey:JSON_KEYFRAMEHEIGHT];
        
        _arrayPositions = [[[NSMutableArray alloc]initWithObjects:[self.dictJSON objectForKey:JSON_KEYFRAMEY1],
                                                                  [self.dictJSON objectForKey:JSON_KEYFRAMEY2],
                                                                  [self.dictJSON objectForKey:JSON_KEYFRAMEY3],
                                                                   nil]autorelease];
        
        //Assign the object Frame and Start location
        _ghostFrameStart = CGRectMake([_frameX floatValue],
                                 [self randomPositions:_arrayPositions],
                                 [_frameWidth floatValue],
                                 [_frameHeight floatValue]);

        //to give a different x position for the end frame
        _startPosForAnimation = [self randomPositions:_arrayPositions];
        
        self.dictJSON = nil;
    }
    return self;

}

- (NSInteger)randomPositions:(NSMutableArray *)array
{
    _randomPosition = [array[arc4random() % [array count]]integerValue];
    return _randomPosition;
}

@end
