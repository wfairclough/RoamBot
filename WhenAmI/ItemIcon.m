//
//  ItemIcon.m
//  WhenAmI
//
//  Created by Ben Fairclough on 1/19/2014.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//
#define xOffset 70
#define yOffset 22

#import "ItemIcon.h"

@implementation ItemIcon
- (id) initWithPosition:(CGPoint)position item:(NSString *)item amount:(int)amount {
    if ([item isEqualToString:@"poweredplank"]) {
        if (self = [super initWithImageNamed:@"plank_space" position:position allowInteraction:NO]) {
            
            self.name = @"poweredplankicon";
            self.position = self.position;
            [self setScale:0.40];
            [[self childNodeWithName:@"bounding"] setXScale:1.37f];
            [[self childNodeWithName:@"bounding"] setYScale:7.0f];
            _amountText = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
            [_amountText setText:[NSString stringWithFormat:@"x%d",amount]];
            [_amountText setFontSize:12.0f];
            [_amountText setPosition:CGPointMake(position.x, position.y - yOffset)];
            
        }
    } else if ([item isEqualToString:@"woodplank"]) {
        if (self = [super initWithImageNamed:@"plank_greek" position:position allowInteraction:NO]) {
            
            self.name = @"woodplankicon";
            self.position = CGPointMake(self.position.x - xOffset, self.position.y);
            [self setScale:0.40];
            [[self childNodeWithName:@"bounding"] setXScale:1.37f];
            [[self childNodeWithName:@"bounding"] setYScale:7.0f];
            _amountText = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
            [_amountText setText:[NSString stringWithFormat:@"x%d",amount]];
            [_amountText setFontSize:12.0f];
            [_amountText setPosition:CGPointMake(position.x - xOffset, position.y - yOffset)];
        }
        
    } else if ([item isEqualToString:@"cannon"]) {
        
        if (self = [super initWithImageNamed:@"Cannon" position:position allowInteraction:NO]) {
            self.name = @"cannonicon";
            self.position = CGPointMake(self.position.x + xOffset, self.position.y);
            self.zRotation = [GameSpriteNode degreesToRadians:90];
            [self setScale:0.40];
            [[self childNodeWithName:@"bounding"] setXScale:3.5f];
            [[self childNodeWithName:@"bounding"] setYScale:1.57f];
            _amountText = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
            [_amountText setText:[NSString stringWithFormat:@"x%d",amount]];
            [_amountText setFontSize:12.0f];
            [_amountText setPosition:CGPointMake(position.x + xOffset, position.y - yOffset)];
        }
        
    }
    return self;
}

+ (id)itemWithPosition:(CGPoint)position item:(NSString *)item amount:(int)amount {
    return [[ItemIcon alloc] initWithPosition:position item:item amount:amount];
}


@end
