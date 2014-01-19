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

- (id)initWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees power:(BOOL)powered theme:(NSString*)theme {
    NSString *imageName;
    NSLog(@"Plank Theme: %@", theme);
    imageName = [@"plank_" stringByAppendingString:theme];
    if (self = [super initWithImageNamed:imageName position:position allowInteraction:isInteractable rotation:degrees]) {
        self.name = @"plank";
        self.isPowered = powered;
        self.theme = theme;
        [[self childNodeWithName:@"bounding"] setYScale:3.0];
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = NO;
        

        [self initializeCollision];
        
        if (powered) {
            self.physicsBody.restitution = 1.0f;
        }
    }
    
    return self;
}

+ (id)plankWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees power:(BOOL)isPowered theme:(NSString*)levelStyle {
    return [[PlankNode alloc ] initWithPosition:position allowInteraction:isInteractable rotation:degrees power:isPowered theme:levelStyle];
}


- (void) initializeCollision {
//    NSLog(@"Initialized Collision for Plank: %x    %x", self.physicsBody.categoryBitMask, self.physicsBody.collisionBitMask);
    self.physicsBody.categoryBitMask = plankConst;
    self.physicsBody.collisionBitMask = 0xFFFFFFFF;
    self.physicsBody.contactTestBitMask = 0x0;
//    NSLog(@"Did Initialized Collision for Plank: %x    %x", self.physicsBody.categoryBitMask, self.physicsBody.collisionBitMask);
}



#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    NSString *interacts = (self.allowInteractions) ? @"true" : @"false";
    CGFloat degrees = [GameSpriteNode radiansToDegrees:self.zRotation];
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f' interacts='%@' rotation='%f' theme='%@' />", kPlankTag, self.position.x, self.position.y, interacts, degrees, self.theme];
}


@end
