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

- (id)initWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees power:(BOOL)powered {
    if (self = [super initWithImageNamed:@"plank" position:position allowInteraction:isInteractable rotation:degrees]) {
        self.name = @"plank";
        self.isPowered = powered;
        [[self childNodeWithName:@"bounding"] setYScale:3.0];
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = NO;
        [self gameNodeXml];
    }
    
    return self;
}

+ (id)plankWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees power:(BOOL)isPowered {
    return [[PlankNode alloc ] initWithPosition:position allowInteraction:isInteractable rotation:degrees power:isPowered];
}



#pragma mark - XML Writer

- (void)gameNodeXml {
    NSString *interacts = (self.allowInteractions) ? @"true" : @"false";
    CGFloat degrees = [GameSpriteNode radiansToDegrees:self.zRotation];
    self.xmlTag = [NSString stringWithFormat:@"\t<%@ x='%f' y='%f' interacts='%@' rotation='%f'></%@>", kPlankTag, self.position.x, self.position.y, interacts, degrees, kPlankTag];
}


@end
