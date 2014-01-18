//
//  CanonNode.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "CannonNode.h"
#import "LevelXmlConstants.h"

@implementation CannonNode

- (id) initWithPosition:(CGPoint)position rotation:(CGFloat)degrees {
    if (self = [super initWithImageNamed:@"Cannon" position:position allowInteraction:NO rotation:degrees]) {
        self.name = @"cannon";
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = NO;
        self.physicsBody.categoryBitMask = cannonConst;
        self.physicsBody.contactTestBitMask = cannonConst | ballConst;
    }
    
    return self;
}

+ (id)canonWithPosition:(CGPoint)position rotation:(CGFloat)degrees {
    return [[CannonNode alloc] initWithPosition:position rotation:degrees];
}


#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    CGFloat degrees = [GameSpriteNode radiansToDegrees:self.zRotation];
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f' rotation='%f' />", kCannonTag, self.position.x, self.position.y,degrees];
}

@end
