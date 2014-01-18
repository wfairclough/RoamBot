//
//  WallNode.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "GameSpriteNode.h"

typedef enum wall_t
{
    small = 0,
    large
} WallType;

@interface WallNode : GameSpriteNode

@property WallType wallType;

@end
