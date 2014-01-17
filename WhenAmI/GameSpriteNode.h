//
//  GameSpriteNode.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameSpriteNode : SKSpriteNode
+ (id)spriteNodeWithImageNamed:(NSString *)name position:(CGPoint)position;
+ (id)spriteNodeWithImageNamed:(NSString *)name position:(CGPoint)position rotation:(CGFloat)degrees;
@end
