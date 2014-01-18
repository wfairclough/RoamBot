//
//  PlankNode.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "PlankNode.h"
#import "LevelXmlConstants.h"


@implementation PlankNode

+ (id)plankWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees power:(BOOL)isPowered {
    PlankNode *node = [PlankNode spriteNodeWithImageNamed:@"plank" position:position allowInteraction:isInteractable rotation:degrees];
    node.name = @"plank";
    node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:node.size];
    node.physicsBody.dynamic = NO;
    [[node childNodeWithName:@"bounding"] setYScale:3.0];
    return node;
}



#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    NSString *interacts = (self.allowInteractions) ? @"true" : @"false";
    CGFloat degrees = [GameSpriteNode degreesToRadians:self.zRotation];
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f' interacts='%@' rotation='%f'></%@>", kPlankTag, self.position.x, self.position.y, interacts, degrees, kPlankTag];
}


@end
