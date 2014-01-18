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

-(id)initWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees theme:(NSString*)levelStyle Type:(NSString*)type {
    NSString *imageName;
    imageName = [[[@"wall_" stringByAppendingString:type] stringByAppendingString:@"_"] stringByAppendingString:levelStyle];
    if (self = [super initWithImageNamed:imageName position:position allowInteraction:isInteractable rotation:degrees]) {
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        [[self childNodeWithName:@"bounding"] setXScale:0.8];
        self.physicsBody.dynamic = NO;
        self.physicsBody.restitution = 0.5;
        self.levelStyle = levelStyle;
        self.imageSize = type;
    }
    return self;
}

+ (id)wallWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees theme:(NSString*)levelStyle Type:(NSString*)type {
    return [[WallNode alloc ] initWithPosition:position allowInteraction:isInteractable rotation:degrees theme:levelStyle Type:type];
}



#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    CGFloat degrees = [GameSpriteNode radiansToDegrees:self.zRotation];
    NSString *interacts = (self.allowInteractions) ? @"true" : @"false";
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f' interacts='%@' rotation='%f' levelStyle='%@' type='%@'></%@>", kWallTag, self.position.x, self.position.y, interacts ,degrees, self.levelStyle, self.imageSize, kWallTag];
}



@end
