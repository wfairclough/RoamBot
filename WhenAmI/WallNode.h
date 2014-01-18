//
//  WallNode.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "GameSpriteNode.h"

@interface WallNode : GameSpriteNode

@property (nonatomic, strong) NSString *theme;
@property (nonatomic, strong) NSString *imageSize;

+ (id)wallWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees theme:(NSString*)theme imageSize:(NSString*)imageSize;

@end
