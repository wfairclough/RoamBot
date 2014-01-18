//
//  CollectableNode.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "CollectableNode.h"
#import "LevelXmlConstants.h"


@implementation CollectableNode


- (id)initWithPosition:(CGPoint)position type:(NSString *)type {
    if (self = [super initWithImageNamed:@"energy_collectable" position:position allowInteraction:NO]) {
        self.name = @"collectable";
        self.physicsBody.dynamic = NO;
    }
    
    return self;
}

+ (id)collectableWithPosition:(CGPoint)position type:(NSString *)type {
    return [[CollectableNode alloc] initWithPosition:position type:type];
}

#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f'/>", kCollectableTag, self.position.x, self.position.y];
}


@end
