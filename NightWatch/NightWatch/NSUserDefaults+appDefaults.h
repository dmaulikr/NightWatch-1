//
//  NSUserDefaults+appDefaults.h
//  LODs
//
//  Created by oosato-t on 2014/02/20.
//
//

#import <Foundation/Foundation.h>



/** アプリで使用するユーザーデフォルトの定義 */
typedef NS_ENUM(NSUInteger, NSUserDefaultsAppKey)
{
    NSUserDefaultsAppKeyShowGuide,
    NSUserDefaultsAppKeyShowGuildGuide,
    NSUserDefaultsAppKeySoundControl,
    NSUserDefaultsAppKeyFacebookLogin,
    NSUserDefaultsAppKeyTwitterLogin,
    NSUserDefaultsAppKeyQuestAnimSpeed,
    NSUserDefaultsAppKeyRaidAnimSpeed,
    NSUserDefaultsAppKeyRaidBattleType,
    NSUserDefaultsAppKeyLastAnnounceId,
    NSUserDefaultsAppKeyItemExchangeSort,
    NSUserDefaultsAppKeyEternalDungeonQuestType,
    NSUserDefaultsAppKeyAnimationSpeedEnableState
};

/** アニメーションスピード */
typedef NS_ENUM(NSUInteger, AnimationSpeed)
{
    AnimationSpeedNormal    = 0,
    AnimationSpeedHigh      = 1,
    AnimationSpeedQuick     = 2
};

/** アニメーションスピード */
typedef NS_ENUM(NSUInteger, RaidEventAnimationSpeed)
{
    RaidEventAnimationSpeedNormal    = 0,
    RaidEventAnimationSpeedHigh      = 1,
    RaidEventAnimationSpeedQuick     = 2
};
typedef NS_ENUM(NSUInteger, RaidEventBattleType)
{
    RaidEventNormalBattle   = 0,
    RaidEventAutoBattle     = 1
};

typedef NS_ENUM(NSUInteger, EternalDungeonQuestType)
{
    EternalDungeonNormalQuest   = 0,
    EternalDungeonAutoQuest     = 1
};

/**
 アプリ内で使用しているuserDefault内のデータアクセスカテゴリー
 */
@interface NSUserDefaults (appDefaults)

/**
 userDefaultの初期化
 */
- (void)registerApplecation;

/**
 userDefaultからのデータ取得
 */
- (id)objectForAppkey:(NSUserDefaultsAppKey)appKey;

/**
 userDefaultへのデータ登録
 */
- (void)setObject:(id)object forAppKey:(NSUserDefaultsAppKey)appKey;



-(void)removeKeysFromDefault:(NSArray*)listOfKeysToBeRemoved;

@end