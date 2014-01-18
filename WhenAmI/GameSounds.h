//
//  GameSounds.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface GameSounds : NSObject

+ (GameSounds *) sharedInstance;


- (void) playMenuMusic;
- (void) playLevelMusic;


@end
