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


-(id)initType:(WallType)type {
    if (self = [super initWithImageNamed:@"wall_rome"]) {
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
