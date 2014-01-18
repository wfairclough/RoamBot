//
//  GoalNode.h
//  WhenAmI
//
//  Created by Kat Butler on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "GameSpriteNode.h"
#import "GameConstants.h"

@interface GoalNode : GameSpriteNode

+ (id)goalWithPosition:(CGPoint)position type:(NSString *)type;

@end
