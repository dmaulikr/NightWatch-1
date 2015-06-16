//
//  NSUserDefaults+appDefaults.m
//  LODs
//
//  Created by oosato-t on 2014/02/20.
//
//

#import "NSUserDefaults+appDefaults.h"

// ガイド表示フラグ
#define kShowGuideFlgKey @"Show guide"

// ギルドガイド表示フラグ
#define kShowGuildGuideFlgKey @"Show guild guide"

// サウンドコントロール
#define kDEFAULT_VK_SOUND_CONTROL @"userDefault_valueKey_sb_sound_control"

// Facebook Common
#define FacebookFirstLoginKey     @"FBFirstLogin"

// Twitter Common
#define TwitterFirstLoginKey @"TwitterFirstLogin"

// 最後にロードしたお知らせIDキー
#define kLastShowAnnounceIDKey @"Last show announce ID"

// アイテム交換所のソート状態
#define kKeyItemExchangeSortSettingModel @"SBItemExchangeSortSettingModel"

// クエストアニメーションスピード
static NSString *const AnimationSpeedKey = @"setting_animation_speed_key_value";

// レイドアニメーションスピード
static NSString *const RaidEventAnimationSpeedKey = @"setting_raid_event_animation_speed_key_value";

static NSString *const RaidEventBattleTypeKey = @"setting_raid_event_battle_type_key_value";

static NSString *const AutoEDKey = @"setting_auto_ed_key_value";

static NSString *const AnimationSpeedSelectorEnableState = @"AnimationSpeedSelectorEnableState";

@implementation NSUserDefaults (appDefaults)

- (void)registerApplecation
{
    // ユーザデフォルト設定
    NSDictionary* defaults = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithBool:YES], kShowGuildGuideFlgKey,
                              [NSNumber numberWithBool:YES], kShowGuideFlgKey,
                              [NSNumber numberWithBool:YES], FacebookFirstLoginKey,
                              [NSNumber numberWithBool:YES], TwitterFirstLoginKey,
                              [NSNumber numberWithBool:YES], kDEFAULT_VK_SOUND_CONTROL,
                              [NSNumber numberWithInteger:AnimationSpeedNormal], AnimationSpeedKey,
                              [NSNumber numberWithInteger:RaidEventAnimationSpeedNormal], RaidEventAnimationSpeedKey,
                              [NSNumber numberWithInteger:RaidEventNormalBattle], RaidEventBattleTypeKey,
                              [NSNumber numberWithInteger:0], kLastShowAnnounceIDKey,
                              @[@0,@0,@0], kKeyItemExchangeSortSettingModel,
                              [NSNumber numberWithInteger:EternalDungeonNormalQuest], AutoEDKey,
                              [NSNumber numberWithBool:YES],AnimationSpeedSelectorEnableState,
                              nil];
    
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}

- (NSString *)SB_AppKeyString:(NSUserDefaultsAppKey)appKey
{
    NSString *str = nil;
    
    switch (appKey) {
        case NSUserDefaultsAppKeyFacebookLogin:
            str = FacebookFirstLoginKey;
            break;
            
        case NSUserDefaultsAppKeyShowGuide:
            str = kShowGuideFlgKey;
            break;
            
        case NSUserDefaultsAppKeyShowGuildGuide:
            str = kShowGuildGuideFlgKey;
            break;
            
        case NSUserDefaultsAppKeySoundControl:
            str = kDEFAULT_VK_SOUND_CONTROL;
            break;
            
        case NSUserDefaultsAppKeyTwitterLogin:
            str = TwitterFirstLoginKey;
            break;
            
        case NSUserDefaultsAppKeyItemExchangeSort:
            str = kKeyItemExchangeSortSettingModel;
            break;
            
        case NSUserDefaultsAppKeyLastAnnounceId:
            str = kLastShowAnnounceIDKey;
            break;
            
        case NSUserDefaultsAppKeyQuestAnimSpeed:
            str = AnimationSpeedKey;
            break;
            
        case NSUserDefaultsAppKeyRaidAnimSpeed:
            str = RaidEventAnimationSpeedKey;
            break;
            
        case NSUserDefaultsAppKeyRaidBattleType:
            str = RaidEventBattleTypeKey;
            break;
        case NSUserDefaultsAppKeyEternalDungeonQuestType:
            str = AutoEDKey;
            break;
        case NSUserDefaultsAppKeyAnimationSpeedEnableState:
            str = AnimationSpeedSelectorEnableState;
            break;
        default:
            str = @"";
            break;
    }
    
    return str;
}

-(id)objectForAppkey:(NSUserDefaultsAppKey)appKey
{
    return [self objectForKey:[self SB_AppKeyString:appKey]];
}

- (void)setObject:(id)object forAppKey:(NSUserDefaultsAppKey)appKey
{
    [self setObject:object forKey:[self SB_AppKeyString:appKey]];
    [self synchronize];
}

-(void)removeKeysFromDefault:(NSArray*)listOfKeysToBeRemoved
{
    for (NSString *key in listOfKeysToBeRemoved) {
        [self removeObjectForKey:key];
    }
    [self synchronize];
}

@end
