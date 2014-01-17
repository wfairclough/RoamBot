//
//  PlankNode.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "PlankNode.h"

@implementation PlankNode
+ (id)plankWithPosition:(CGPoint)position rotation:(CGFloat)degrees power:(BOOL)isPowered {
    PlankNode *node = [PlankNode spriteNodeWithImageNamed:@"plank" position:position rotation:degrees];
    node.name = @"plank";
    return node;
}
@end
