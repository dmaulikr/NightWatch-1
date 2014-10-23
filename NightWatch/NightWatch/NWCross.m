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


- (id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];

    if (self) {
        

        self.Cframe = CGRectMake(250, 100, self.CROSS_WIDTH, self.CROSS_HEIGHT);
        self.image = [UIImage imageNamed:crossImageName];
    }
    
    return self;
}





@end
