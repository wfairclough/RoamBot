//
//  ItemIcon.h
//  WhenAmI
//
//  Created by Ben Fairclough on 1/19/2014.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameSpriteNode.h"

@interface ItemIcon : GameSpriteNode

@property (nonatomic, strong) SKLabelNode *amountText;

- (id) initWithPosition:(CGPoint)position item:(NSString*)item amount:(int)amount;
+ (id) itemWithPosition:(CGPoint)position item:(NSString*)item amount:(int)amount;

@end