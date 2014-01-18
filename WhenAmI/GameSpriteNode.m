//
//  GameSpriteNode.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "GameSpriteNode.h"
#import "LevelXmlConstants.h"


@implementation GameSpriteNode

- (id)initWithImageNamed:(NSString *)name position:(CGPoint)position allowInteraction:(BOOL)isInteractable {
    if (self = [super initWithImageNamed:name]) {
        self.allowInteractions = isInteractable;
        self.position = position;
        GameSpriteNode *boundingBox = [GameSpriteNode spriteNodeWithColor:[SKColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3] size:self.size];
        boundingBox.name = @"bounding";
        [boundingBox setHidden:YES];
        [self addChild:boundingBox];
    }
    
    return self;
}

- (id)initWithImageNamed:(NSString *)name position:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees {
    if (self = [self initWithImageNamed:name position:position allowInteraction:isInteractable]) {
        self.zRotation = [GameSpriteNode degreesToRadians:degrees];
    }
    
    return self;
}

+ (id)spriteNodeWithImageNamed:(NSString *)name position:(CGPoint)position allowInteraction:(BOOL)isInteractable {
    return [[GameSpriteNode alloc] initWithImageNamed:name position:position allowInteraction:isInteractable];
}

+ (id)spriteNodeWithImageNamed:(NSString *)name position:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees {
    return [[GameSpriteNode alloc] initWithImageNamed:name position:position allowInteraction:isInteractable rotation:degrees];
}

+ (CGFloat)degreesToRadians:(CGFloat)degrees {
    return degrees * M_PI / 180;
}

+ (CGFloat)radiansToDegrees:(CGFloat)radians {
    return radians * 180 / M_PI;
}

- (void)rotateByAngle:(CGFloat)rotation {
    [self runAction:[SKAction rotateByAngle:-2*rotation duration:0.0]];
    
}

- (BOOL)isBoundingBox {
    return [self.name isEqualToString:@"bounding"];
}


- (BOOL) isDavMode {
    if (kDavMode)
        return kDavMode;
    
    return self.allowInteractions;
        
}


@end
