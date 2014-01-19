//
//  GoalNode.h
//  WhenAmI
//
//  Created by Kat Butler on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "WorldItemNode.h"
#import "GameConstants.h"
#import "BallNode.h"

@interface GoalNode : WorldItemNode

@property (nonatomic, strong) NSString *theme;

+ (id)goalWithPosition:(CGPoint)position rotation:(CGFloat)rotation theme:(NSString *)theme;
- (void)contactWithBall:(BallNode*)ball;
- (void)resetGoal;
@end
