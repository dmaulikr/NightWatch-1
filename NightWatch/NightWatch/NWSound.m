//
//  NWSound.m
//  NightWatch
//
//  Created by Marvin Labrador on 4/7/15.
//  Copyright (c) 2015 Marvin Labrador. All rights reserved.
//

#import "NWSound.h"
#import "NWSoundCommon.h"
#import "NSUserDefaults+appDefaults.h"




#define kDEFAULT_BGM_VOLUME 0.8f
#define kDEFAULT_BGM_FADE_DURATION 1.0f

static BOOL backgroundMode = NO;

@interface NWSound()

@property (nonatomic) BOOL onSound;
@property (nonatomic) BOOL shouldPlay;

@property (nonatomic, assign) NWBGMType currentSoundBGMType;

@property (nonatomic, assign) NWBGMType lastPlayBGMType;

@property (nonatomic, assign) NWBGMType previousBGMType;

@property (nonatomic, retain) ALDevice* device;

@property (nonatomic, retain) ALContext* context;

@property (nonatomic, retain) ALChannelSource* channel;

@property (nonatomic, retain) OALAudioTrack* audioTrack;

@property (nonatomic, retain) NSArray* effects;

@property (nonatomic, retain) ALBuffer* effectBuffer;

@end


@implementation NWSound

@synthesize onSound = _onSound;

@synthesize currentSoundBGMType = _currentSoundBGMType;

@synthesize lastPlayBGMType = _lastPlayBGMType;

@synthesize device = _device;

@synthesize context = _context;

@synthesize channel = _channel;

@synthesize audioTrack = _audioTrack;

@synthesize effects = _effects;

@synthesize effectBuffer = _effectBuffer;

- (void)dealloc
{
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.onSound = [[[NSUserDefaults standardUserDefaults] objectForAppkey:NSUserDefaultsAppKeySoundControl] boolValue];
        
        self.shouldPlay = NO;
        
        self.currentSoundBGMType = NWBGMTypeNone;
        
        self.device = [ALDevice deviceWithDeviceSpecifier:nil];
        
        self.context = [ALContext contextOnDevice:self.device attributes:nil];
        
        [OpenALManager sharedInstance].currentContext = self.context;
        
        [OALAudioSession sharedInstance].handleInterruptions = YES;
        
        [OALAudioSession sharedInstance].allowIpod = NO;
        
        [OALAudioSession sharedInstance].honorSilentSwitch = YES;
        
        self.channel = [ALChannelSource channelWithSources:32];
        
        self.audioTrack = [OALAudioTrack track];
        
        self.audioTrack.volume = kDEFAULT_BGM_VOLUME;
    }
    
    return self;
}

+ (void)AudioInit
{
    [self sharedSound];
    
    AudioSessionInitialize(NULL, NULL, NULL, NULL);
    
    UInt32 sessionCategory = kAudioSessionCategory_AmbientSound;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                            sizeof(sessionCategory),
                            &sessionCategory);
    AudioSessionSetActive(YES);
}

+ (NWSound *)sharedSound
{
    static NWSound* sharedSound = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSound = [[NWSound alloc] init];
    });
    return sharedSound;
}

- (NSString *)soundFileName:(NWSFXType)type
{
    NSString *fileName = nil;
    
    switch (type) {
        case NWSFXTypeBurn:
            fileName = kNWSoundBurnSFX;
            break;
        case NWSFXTypeGameOver:
            fileName = kNWSoundGameOverSFX;
            break;
        default:
            break;
    }
    
    return [fileName stringByAppendingString:kNWSoundFileExtension];
}

- (NSString *)soundBGMFileName:(NWBGMType)type
{
    NSString *fileName = nil;
    
    switch (type)
    {
        case NWBGMTypeGame:
            fileName = kNWSoundGameBGM;
            break;
        case NWBGMTypeGameSounds:
            fileName = kNWSoundGameSFX;
            break;
        case NWBGMTypeMain:
            fileName = kNWSoundMainBGM;
            break;
        default:
            break;
    }
    
    return [fileName stringByAppendingString:kNWSoundFileExtension];
}

+ (void)play:(NWSFXType)soundType
{
    [self play:soundType target:nil selector:nil];
}

+ (void)play:(NWSFXType)soundType target:(id)target selector:(SEL)selector
{
    NWSound* sound = [NWSound sharedSound];
    
//    if (backgroundMode) {
//        [sound.channel stop];
//        return;
//    }
    
//    if (![NWSound canPlay])
//    {
//        return;
//    }
//    
//    if (sound.onSound)
//    {
        sound.effectBuffer = [[OpenALManager sharedInstance] bufferFromFile:[sound soundFileName:soundType]];
        
        [sound.channel play:sound.effectBuffer];
//    }
    
    [target performSelector:selector withObject:nil afterDelay:0.5f];
}

+ (void)stop:(NWSFXType)soundType
{
    NWSound* sound = [NWSound sharedSound];
    
    [sound.channel stop];
}

+ (void)backgroundMode
{
    NWSound* sound = [NWSound sharedSound];
    
    sound.currentSoundBGMType = NWBGMTypeNone;
    
    [sound.channel stop];
    
    [sound.audioTrack stop];
    
    backgroundMode =  YES;
}

+ (void)foregroundMode
{
//    NWSound* sound = [NWSound sharedSound];
//    
//    SBAppController *appController = [SBAppController sharedAppController];
//    
//    if (sound.onSound && appController.isMultitasking) {
//        
//        SBSoundBGMType type = sound.lastPlayBGMType;
//        
//        if ([SBSound canPlay])
//        {
//            [sound.audioTrack playFile:[sound soundBGMFileName:type] loops:-1];
//        }
//    }
//    
//    backgroundMode =  NO;
}

+ (void)playBGM
{
    NWSound* sound = [NWSound sharedSound];
//    if (![NWSound canPlay])
//    {
//        return;
//    }
    
//    if (sound.onSound && !backgroundMode)
//    {
    sound.audioTrack.volume = kDEFAULT_BGM_VOLUME;
//    [sound.audioTrack setMuted:!sound.onSound];
    
//        if ([NWSound canPlay])
//        {
    [sound.audioTrack playFile:[sound soundBGMFileName:sound.currentSoundBGMType] loops:-1];
//    [sound.audioTrack playFile:@"NWMainBGM.caf" loops:-1];
//        }
//    }
}

+ (void)playBGM:(NWBGMType)type
{
    NWSound* sound = [NWSound sharedSound];
    
//    if (![NWSound canPlay])
//    {
//        return;
//    }
    
//    if (sound.currentSoundBGMType != type && sound.onSound)
//    {
    
        sound.previousBGMType = sound.currentSoundBGMType;
        sound.currentSoundBGMType = type;
        sound.lastPlayBGMType = type;
        
        if (sound.audioTrack.playing)
        {
            [sound.audioTrack fadeTo:0.f
                            duration:kDEFAULT_BGM_FADE_DURATION
                              target:self
                            selector:@selector(playBGM)];
            
            return;
        }
        
        [NWSound playBGM];
//    }

}

+ (void)stopBGM
{
    NWSound* sound = [NWSound sharedSound];
    sound.currentSoundBGMType = NWBGMTypeNone;
    [sound.audioTrack stop];
}

+ (void)stopBGMFadeTime:(CGFloat)fadeTime
{
    NWSound* sound = [NWSound sharedSound];
    
    [sound.audioTrack fadeTo:0.f
                    duration:fadeTime
                      target:self
                    selector:@selector(stopBGM)];
}

+(void)replayBGM
{
    if (![NWSound canPlay])
    {
        return;
    }
    
    [NWSound playBGM:[NWSound sharedSound].lastPlayBGMType];
}

+ (void)setPlaying:(BOOL) is
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:is] forAppKey:NSUserDefaultsAppKeySoundControl];
    
    NWSound* sound = [NWSound sharedSound];
    
    sound.onSound = is;
    
    if (sound.onSound)
    {
        [NWSound playBGM:NWBGMTypeNone];
    }
    else
    {
        sound.currentSoundBGMType = NWBGMTypeNone;
        [NWSound stop:NWSFXTypeNone];
        [NWSound stopBGM];
    }
}

+ (BOOL)playing
{
    return [NWSound sharedSound].onSound;
}

+ (void)allowPlay
{
    [NWSound sharedSound].shouldPlay = YES;
}

+ (BOOL)canPlay
{
    return [NWSound sharedSound].shouldPlay;
}

+ (void)playPreviousBGM
{
    [NWSound playBGM:[NWSound sharedSound].previousBGMType];
}


@end
