//
//  GamePlayer.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "GamePlayer.h"

#define kFirstTimeLoad @"firstTimeLoad"
#define kCurrentLevel @"currentLevel"
#define kGameAudioEnabled @"gameAudioEnabled"

/**
 * Singleton for GamePlayer
 */
static GamePlayer* _sharedInstance;

@implementation GamePlayer

-(id)init {
    if (self=[super init]) {
        [self loadPlayer];
    }
    
    return self;
}

+ (void)initialize
{
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        _sharedInstance = [[GamePlayer alloc] init];
    }
}

+ (GamePlayer *) sharedInstance {
    return _sharedInstance;
}

- (int) increaseSelectedLevel {
    self.selectedLevel = [NSNumber numberWithInt:[self.selectedLevel intValue] + 1];
    if ([self.selectedLevel intValue] > [self.currentLevel intValue])
        self.currentLevel = self.selectedLevel;
    
    [self savePlayer];
    return [self.selectedLevel intValue];
}

- (void)loadPlayer {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (([defaults objectForKey:kFirstTimeLoad] == nil) || ([[defaults objectForKey:kFirstTimeLoad] isEqualToNumber:[NSNumber numberWithBool:YES]])) {
        // Init First Time
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{kFirstTimeLoad: [NSNumber numberWithBool:NO],
                                                                  kCurrentLevel: [NSNumber numberWithInteger:1],
                                                                  kGameAudioEnabled: [NSNumber numberWithBool:YES]}];
    }
    self.currentLevel = [defaults objectForKey:kCurrentLevel];
    self.gameAudioEnabled = [defaults objectForKey:kGameAudioEnabled];
    
    NSLog(@"Current Level - %@, Audio - %@", self.currentLevel, self.gameAudioEnabled);
}

- (void)savePlayer {
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:kFirstTimeLoad];
    [[NSUserDefaults standardUserDefaults] setObject:self.currentLevel forKey:kCurrentLevel];
    [[NSUserDefaults standardUserDefaults] setObject:self.gameAudioEnabled forKey:kGameAudioEnabled];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
