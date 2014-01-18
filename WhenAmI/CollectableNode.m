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


-(id) init {
    if (self = [super initWithImageNamed:@"energy_collectable"]) {
        self.physicsBody.categoryBitMask = collectableConst;
        
        
        // Init stuff here
        // self.physicsBody.restitution = 1.0; // Stuff like this here but you dont need restitution for this one
        
    }
    return self;
    
}

#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f'></%@>", kCollectableTag, self.position.x, self.position.y, kCollectableTag];
}


@end
