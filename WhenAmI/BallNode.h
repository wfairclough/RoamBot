//
//  BallNode.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "WorldItemNode.h"

@interface BallNode : WorldItemNode

- (id) initWithPosition:(CGPoint)position;
+ (id)ballWithPosition:(CGPoint)position;

@end
