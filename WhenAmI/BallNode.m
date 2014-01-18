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

- (id) initWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable {
    if (self = [super initWithImageNamed:@"ball" position:position allowInteraction:isInteractable]) {
        self.name = @"ball";
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
        self.physicsBody.dynamic = NO;
        self.physicsBody.restitution = 0.75;
        [self gameNodeXml];
    }
    
    return self;
}

+ (id)ballWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable {
    return [[BallNode alloc] initWithPosition:position allowInteraction:isInteractable];
}



#pragma mark - XML Writer

- (void)gameNodeXml {
    self.xmlTag = [NSString stringWithFormat:@"\t<%@ x='%f' y='%f'></%@>", kBallTag, self.position.x, self.position.y, kBallTag];
}


@end
