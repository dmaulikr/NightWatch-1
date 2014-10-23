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
        
    }
    return self;
}


@end
