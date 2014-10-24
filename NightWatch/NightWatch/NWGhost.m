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
        
        NSNumber *frameX = [self.dictJSON objectForKey:@"frame.x"];
        NSNumber *frameWidth = [self.dictJSON objectForKey:@"frame.width"];
        NSNumber *frameHeight = [self.dictJSON objectForKey:@"frame.height"];
        
        _arrayPositions = [[[NSMutableArray alloc]initWithObjects:[self.dictJSON objectForKey:@"frame.y"],
                                                                  [self.dictJSON objectForKey:@"frame.y2"],
                                                                  [self.dictJSON objectForKey:@"frame.y3"],
                                                                   nil]autorelease];
        
        //Assign the object Frame and Start location
        _ghostFrame = CGRectMake([frameX floatValue],
                                 [[self randomPositions:_arrayPositions] floatValue],
                                 [frameWidth floatValue],
                                 [frameHeight floatValue]);
      
        [self animateAttack:self.layer];
    }
    return self;
}

- (void)animateAttack:(CALayer *)layer
{
    
    _attack = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    
    _attack.duration = [[self.dictJSON objectForKey:@"speed"] floatValue];
    NSMutableArray *values = [[[NSMutableArray alloc]init]autorelease];
    
    //start value
    [values addObject:[NSNumber numberWithFloat:0.0f]];
    
    //end value
    CGFloat width = [[UIScreen mainScreen]applicationFrame].size.width + 300;
    [values addObject:[NSNumber numberWithFloat:width]];
    _attack.values = values;
    _attack.repeatCount = HUGE_VAL;
    
    [layer addAnimation:_attack forKey:keyPath];

}

- (void)die;
{
    
    
}

- (BOOL)wasIntersectedByCross:(CGRect)collider
{
    if (CGRectIntersectsRect(self.frame, collider)) {
        return TRUE;
        NSLog(@"Intersecting");
    } else {
        return FALSE;
    }

}

- (NSNumber *)randomPositions:(NSMutableArray *)array
{
    _randomPosition = array[arc4random() % [array count]];
    return _randomPosition;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    NSLog(@"Stopped Animation");
    
}

- (void)reachedTheBaby
{
    
    NSLog(@"GAME OVER");
    
}



@end
