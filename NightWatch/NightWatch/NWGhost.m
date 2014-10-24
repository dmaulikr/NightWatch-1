//
//  NWGhost.m
//  NightWatch
//
//  Created by Marvin Labrador on 10/23/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import "NWGhost.h"

NSString *AGhostImageName = @"Ghost";


@implementation NWGhost


- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
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
        
        NSNumber *frameX = [self.dictJSON objectForKey:@"frame.x"];
        NSNumber *frameY = [self.dictJSON objectForKey:@"frame.y"];
        NSNumber *frameWidth = [self.dictJSON objectForKey:@"frame.width"];
        NSNumber *frameHeight = [self.dictJSON objectForKey:@"frame.height"];
        
        
        //Assign the object Frame and Start location
        _ghostFrame = CGRectMake([frameX floatValue],
                                 [frameY floatValue],
                                 [frameWidth floatValue],
                                 [frameHeight floatValue]);

        
    }
    return self;
}

- (void)animateAttack:(CALayer *)layer
{
    NSString *keyPath = @"transform.translation.x";
    
    CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    
    translation.duration = 4.0f;
    //    translation.repeatCount = HUGE_VAL;
    
    
    NSMutableArray *values = [[[NSMutableArray alloc]init]autorelease];
    
    //start value
    [values addObject:[NSNumber numberWithFloat:0.0f]];
    
    //end value
    CGFloat width = [[UIScreen mainScreen]applicationFrame].size.width + 300;
    [values addObject:[NSNumber numberWithFloat:width]];
    translation.values = values;
    
    [layer addAnimation:translation forKey:keyPath];
    
}

- (void)die;
{
    
    
}

- (BOOL)wasIntersectedByCross
{
    return TRUE;
}


@end
