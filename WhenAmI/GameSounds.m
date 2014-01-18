//
//  GameSounds.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "GameSounds.h"

static GameSounds* _sharedInstance;

@interface GameSounds()

@property AVAudioPlayer* musicPlayer;

@end

@implementation GameSounds

-(id)init {
    if (self=[super init]) {
        
    }
    
    return self;
}

+ (void)initialize
{
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        _sharedInstance = [[GameSounds alloc] init];
    }
}

+ (GameSounds *) sharedInstance {
    return _sharedInstance;
}


#pragma mark - Audio

- (void) playMenuMusic {
    [self playSoundWithFileName:@"MainMenuWithIntro"];
}

- (void) playLevelMusic {
    [self playSoundWithFileName:@"RomeBotLevel"];
}

- (void) playSoundWithFileName:(NSString *)filename {
    NSError *error;
	NSURL *musicURL = [[NSBundle mainBundle] URLForResource:filename withExtension:@"mp3"];
	self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:&error];
	self.musicPlayer.numberOfLoops = -1;
	self.musicPlayer.volume = 0.40f;
	[self.musicPlayer prepareToPlay];
	[self.musicPlayer play];
}

@end
