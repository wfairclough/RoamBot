//
//  GameSpriteNode.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "GameSpriteNode.h"

@implementation GameSpriteNode
+ (id)spriteNodeWithImageNamed:(NSString *)name position:(CGPoint)position {
    GameSpriteNode *node = [GameSpriteNode spriteNodeWithImageNamed:name];
    node.position = position;
    GameSpriteNode *boundingBox = [GameSpriteNode spriteNodeWithColor:[SKColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3] size:node.size];
    boundingBox.name = @"bounding";
    [boundingBox setHidden:YES];
    [node addChild:boundingBox];
    return node;
}

+ (id)spriteNodeWithImageNamed:(NSString *)name position:(CGPoint)position rotation:(CGFloat)degrees {
    GameSpriteNode * node = [GameSpriteNode spriteNodeWithImageNamed:name position:position];
    node.zRotation = [GameSpriteNode degreesToRadians:degrees];
    return node;
}

+ (CGFloat)degreesToRadians:(CGFloat)degrees {
    return degrees * M_PI / 180;
}

+ (CGFloat)radiansToDegrees:(CGFloat)radians {
    return radians * 180 / M_PI;
}
@end
