//
//  MyScene.h
//  WhenAmI
//

//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import "LevelXmlParser.h"
#import "GameConstants.h"

@interface GameScene : SKScene <UIGestureRecognizerDelegate, LevelSetupDelegate>

@end
