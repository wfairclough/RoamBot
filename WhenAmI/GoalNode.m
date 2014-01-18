//
//  GoalNode.m
//  WhenAmI
//
//  Created by Kat Butler on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "GoalNode.h"
#import "LevelXmlConstants.h"

@implementation GoalNode

- (id)initWithPosition:(CGPoint)position type:(NSString *)type {
    if (self = [super initWithImageNamed:@"goal" position:position allowInteraction:NO]) {
        self.name = @"goal";
        self.physicsBody.dynamic = NO;
    }
    
    return self;
}

+ (id)goalWithPosition:(CGPoint)position type:(NSString *)type {
    return [[GoalNode alloc] initWithPosition:position type:type];
}



#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f'/>", kGoalTag, self.position.x, self.position.y];
}

@end
