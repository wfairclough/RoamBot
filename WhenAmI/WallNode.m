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


-(id)initWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees theme:(NSString*)levelStyle Type:(WallType)type {
    NSString *imageName;
    if (type == small) {
        imageName = [@"wall_small_" stringByAppendingString:levelStyle];
    } else if (type == medium) {
        imageName = [@"wall_medium_" stringByAppendingString:levelStyle];
    } else if (type == large) {
        imageName = [@"wall_large_" stringByAppendingString:levelStyle];
    }
    if (self = [super initWithImageNamed:imageName position:position allowInteraction:isInteractable rotation:degrees]) {
        self.physicsBody.restitution = 0.5;
        self.wallType = type;
    }
    return self;
}




#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    CGFloat degrees = [GameSpriteNode radiansToDegrees:self.zRotation];
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f' rotation='%f' type='%d'></%@>", kWallTag, self.position.x, self.position.y, degrees, self.wallType, kWallTag];
}



@end
