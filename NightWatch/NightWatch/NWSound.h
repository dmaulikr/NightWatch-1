//
//  NWSound.h
//  NightWatch
//
//  Created by Marvin Labrador on 4/7/15.
//  Copyright (c) 2015 Marvin Labrador. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "ObjectAL.h"


typedef enum {
   
    NWSFXTypeBurn = 1,
    NWSFXTypeGameOver = 2,
    NWSFXTypeNone = 3

}NWSFXType;

typedef enum {
    
    NWBGMTypeMain = 1,
    NWBGMTypeGame = 2,
    NWBGMTypeGameSounds = 3,
    NWBGMTypeNone = 4
    
} NWBGMType;


@interface NWSound : NSObject

+ (void)AudioInit;

+ (NWSound *)sharedSound;

+ (void)play:(NWSFXType)soundType;
+ (void)stop:(NWSFXType)soundType;
+ (void)backgroundMode;
+ (void)foregroundMode;

+ (void)playPreviousBGM;
+ (void)playBGM:(NWBGMType)type;
+ (void)stopBGM;
+ (void)stopBGMFadeTime:(CGFloat)fadeTime;
+ (void)replayBGM;

+ (void)setPlaying:(BOOL)is;
+ (BOOL)playing;

+ (void)allowPlay;
+ (BOOL)canPlay;

+ (void)play:(NWSFXType)soundType
      target:(id)target
    selector:(SEL)selector;


@end
