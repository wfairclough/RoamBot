//
//  GameSpriteNode.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "GameSpriteNode.h"
#import "LevelXmlConstants.h"


@implementation GameSpriteNode
+ (id)spriteNodeWithImageNamed:(NSString *)name position:(CGPoint)position allowInteraction:(BOOL)isInteractable {
    GameSpriteNode *node = [GameSpriteNode spriteNodeWithImageNamed:name];
    node.allowInteractions = isInteractable;
    node.position = position;
    GameSpriteNode *boundingBox = [GameSpriteNode spriteNodeWithColor:[SKColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3] size:node.size];
    boundingBox.name = @"bounding";
    [boundingBox setHidden:YES];
    [node addChild:boundingBox];
    return node;
}

+ (id)spriteNodeWithImageNamed:(NSString *)name position:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees {
    GameSpriteNode * node = [GameSpriteNode spriteNodeWithImageNamed:name position:position allowInteraction:isInteractable];
    node.zRotation = [GameSpriteNode degreesToRadians:degrees];
    return node;
}

+ (CGFloat)degreesToRadians:(CGFloat)degrees {
    return degrees * M_PI / 180;
}

+ (CGFloat)radiansToDegrees:(CGFloat)radians {
    return radians * 180 / M_PI;
}

- (void)rotateByAngle:(CGFloat)rotation {
    [self runAction:[SKAction rotateByAngle:-2*rotation duration:0.0]];
}

- (BOOL)isBoundingBox {
    return [self.name isEqualToString:@"bounding"];
}


- (BOOL) isDavMode {
    if (kDavMode)
        return kDavMode;
    
    return self.allowInteractions;
        
}


#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    NSString *interacts = (self.allowInteractions) ? @"true" : @"false";
    CGFloat degrees = [GameSpriteNode degreesToRadians:self.zRotation];
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f' interacts='%@' rotation='%f'></%@>", kGameNodeTag, self.position.x, self.position.y, interacts, degrees, kGameNodeTag];
}

@end
