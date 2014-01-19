//
//  GameSpriteNode.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameConstants.h"

@interface GameSpriteNode : SKSpriteNode

@property BOOL allowInteractions;

- (id)initWithImageNamed:(NSString *)name position:(CGPoint)position allowInteraction:(BOOL)isInteractable;
- (id)initWithImageNamed:(NSString *)name position:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees;
+ (id)spriteNodeWithImageNamed:(NSString *)name position:(CGPoint)position allowInteraction:(BOOL)isInteractable;
+ (id)spriteNodeWithImageNamed:(NSString *)name position:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees;
- (void)rotateByAngle:(CGFloat)rotation;
- (BOOL)isBoundingBox;
- (BOOL) allowsUserInteraction;
- (void) initializeCollision;


- (NSString *)gameNodeXml;

#pragma mark - Utility Methods

+ (CGFloat)degreesToRadians:(CGFloat)degrees;
+ (CGFloat)radiansToDegrees:(CGFloat)radians;

@end
