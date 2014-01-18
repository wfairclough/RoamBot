//
//  PlankNode.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "PlankNode.h"

@implementation PlankNode
+ (id)plankWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees power:(BOOL)isPowered {
    PlankNode *node = [PlankNode spriteNodeWithImageNamed:@"plank" position:position allowInteraction:isInteractable rotation:degrees];
    node.name = @"plank";
    node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:node.size];
    node.physicsBody.dynamic = NO;
    [[node childNodeWithName:@"bounding"] setYScale:3.0];
    return node;
}
@end
