//
//  GamePlayer.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GamePlayer : NSObject

+ (GamePlayer *) sharedInstance;

@property (nonatomic, strong) NSNumber* currentLevel;
@property (nonatomic, strong) NSNumber* selectedLevel;
@property (nonatomic, strong) NSNumber* gameAudioEnabled;
@property (nonatomic, strong) NSMutableDictionary* scoreTable;

- (void)loadPlayer;
- (void)savePlayer;
- (int)increaseSelectedLevel;
- (BOOL)setEnergyScoreForSelectedLevel:(int)currentScore;

@end




