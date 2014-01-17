//
//  WallNode.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "WallNode.h"

static const uint32_t ball = 0x1 << 0;

@implementation WallNode


-(id)initType:(WallType)type {
    if (self = [super initWithImageNamed:@"wall_rome"]) {
        self.physicsBody.restitution = 0.5;
        self.wallType = type;
    }
    return self;
}

@end
