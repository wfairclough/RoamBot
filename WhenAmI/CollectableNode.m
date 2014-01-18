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


#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    CGFloat degrees = [GameSpriteNode degreesToRadians:self.zRotation];
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f'></%@>", kCollectableTag, self.position.x, self.position.y, kCollectableTag];
}


@end
