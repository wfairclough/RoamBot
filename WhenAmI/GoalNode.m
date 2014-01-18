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

- (id)initWithPosition:(CGPoint)position rotation:(CGFloat)rotation theme:(NSString *)theme {
    if (self = [super initWithImageNamed:@"world_2_goal" position:position allowInteraction:NO]) {
        self.name = @"goal";
        self.theme = theme;
        [self setAnchorPoint:CGPointMake(self.anchorPoint.x, 0.0f)];
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = NO;
        self.physicsBody.categoryBitMask = goalConst;
        self.physicsBody.contactTestBitMask = goalConst | ballConst;

    }
    
    return self;
}

+ (id)goalWithPosition:(CGPoint)position rotation:(CGFloat)rotation theme:(NSString *)theme {
    return [[GoalNode alloc] initWithPosition:position rotation:rotation theme:theme];
}

- (void)contactWithBall {
    NSLog(@"CONTACT WITH BALL");
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, self.size.height * 0.2)];
    self.physicsBody.dynamic = NO;
    self.physicsBody.contactTestBitMask ^= ballConst;
    [self setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"world_2_base"]]];
    
    SKAction *cannonNoise = [SKAction playSoundFileNamed:@"Level Complete.mp3" waitForCompletion:NO];
    [self runAction:cannonNoise];
}



#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    CGFloat degrees = [GameSpriteNode radiansToDegrees:self.zRotation];
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f' rotation='%f' theme='%@' />", kGoalTag, self.position.x, self.position.y, degrees, self.theme];
}

@end
