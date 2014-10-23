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
        _CROSS_POSITION_Y1 = [NSNumber numberWithInt:0];
        _CROSS_POSITION_Y2 = [NSNumber numberWithInt:100];
        _CROSS_POSITION_Y3 = [NSNumber numberWithInt:200];
        
        

        
    }
    
    return self;
}





@end
