//
//  NWGamePlayViewController.h
//  NightWatch
//
//  Created by Marvin Labrador on 10/22/14.
//  Copyright (c) 2014 Marvin Labrador. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NWGamePlayViewController : UIViewController

@property (retain, nonatomic) NSNumber *randomPosition;
@property (assign, nonatomic) NSInteger yourScore;
@property (assign, nonatomic) NSInteger highScore;
@property (retain, nonatomic) NSMutableArray *arrayPositions;
@property (retain, nonatomic) NSUserDefaults *savedScore;

-(void)checkCollision;
-(void)ghostsArrive;
-(void)initializeGame;

@end
