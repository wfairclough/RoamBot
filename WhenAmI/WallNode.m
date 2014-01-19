//
//  WallNode.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "WallNode.h"
#import "LevelXmlConstants.h"


@implementation WallNode


// IsInteractable is NEVER used, but that's okay
-(id)initWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees theme:(NSString*)theme imageSize:(NSString*)imageSize {
    NSString *imageName;
    imageName = [[[@"wall_" stringByAppendingString:imageSize] stringByAppendingString:@"_"] stringByAppendingString:theme];
    if (self = [super initWithImageNamed:imageName position:position allowInteraction:NO rotation:degrees]) {
        self.name = @"wall";
        self.allowInteractions = NO;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        [[self childNodeWithName:@"bounding"] setXScale:2.5];
        self.physicsBody.dynamic = NO;
        self.physicsBody.restitution = 0.5;

        [self initializeCollision];
        
        self.theme = theme;
        self.imageSize = imageSize;
    }
    return self;
}

+ (id)wallWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees theme:(NSString*)theme imageSize:(NSString*)imageSize {
    return [[WallNode alloc ] initWithPosition:position allowInteraction:isInteractable rotation:degrees theme:theme imageSize:imageSize];
}


- (void) initializeCollision {
//    NSLog(@"Initialized Collision for Wall: %x    %x", self.physicsBody.categoryBitMask, self.physicsBody.collisionBitMask);
    self.physicsBody.categoryBitMask = wallConst;
    self.physicsBody.collisionBitMask = 0xFFFFFFFF;
    self.physicsBody.contactTestBitMask = 0x0;
}

#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    CGFloat degrees = [GameSpriteNode radiansToDegrees:self.zRotation];
    NSString *interacts = (self.allowInteractions) ? @"true" : @"false";
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f' interacts='%@' rotation='%f' theme='%@' imageSize='%@'></%@>", kWallTag, self.position.x, self.position.y, interacts ,degrees, self.theme, self.imageSize, kWallTag];
}



@end
