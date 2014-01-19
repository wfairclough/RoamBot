//
//  CollectableNode.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "GameSpriteNode.h"
#import "GameConstants.h"

@interface CollectableNode : GameSpriteNode

+ (id)collectableWithPosition:(CGPoint)position type:(NSString *)type;
- (void)contactWithBall;

@end
