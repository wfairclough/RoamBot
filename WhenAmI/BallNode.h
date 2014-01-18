//
//  BallNode.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "WorldItemNode.h"

@interface BallNode : WorldItemNode
+ (id)ballWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable;

@end
