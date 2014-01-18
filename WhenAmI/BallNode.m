//
//  BallNode.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "BallNode.h"
#import "LevelXmlConstants.h"


@implementation BallNode


+ (id)ballWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable {
    BallNode *node = [BallNode spriteNodeWithImageNamed:@"ball" position:position allowInteraction:isInteractable];
    node.name = @"ball";
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:node.size.width/2];
    node.physicsBody.dynamic = NO;
    node.physicsBody.restitution = 0.75;
    return node;
}



#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f'></%@>", kBallTag, self.position.x, self.position.y, kBallTag];
}


@end
