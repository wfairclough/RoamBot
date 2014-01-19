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

- (id) initWithPosition:(CGPoint)position {
    if (self = [super initWithImageNamed:@"ball" position:position allowInteraction:NO]) {
        self.name = @"ball";
        self.zPosition = 1000.0f;
        [[self childNodeWithName:@"bounding"] setScale:1.6];
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
        self.physicsBody.restitution = 0.75;
        self.physicsBody.dynamic = NO;
        self.physicsBody.affectedByGravity = NO;
        
        [self initializeCollision];
    }
    
    return self;
}

+ (id)ballWithPosition:(CGPoint)position {
    return [[BallNode alloc] initWithPosition:position];
}


- (void) initializeCollision {
    NSLog(@"Initialized Collision for Ball: %x    %x", self.physicsBody.categoryBitMask, self.physicsBody.collisionBitMask);
    self.physicsBody.categoryBitMask = ballConst;
    self.physicsBody.collisionBitMask = 0xFFFFFFFF;
    self.physicsBody.collisionBitMask ^= collectableConst | goalConst;
//    self.physicsBody.contactTestBitMask = 0x0;
    NSLog(@"Did Initialized Collision for Ball: %x    %x", self.physicsBody.categoryBitMask, self.physicsBody.collisionBitMask);
}


#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f'></%@>", kBallTag, self.position.x, self.position.y, kBallTag];
}


@end
