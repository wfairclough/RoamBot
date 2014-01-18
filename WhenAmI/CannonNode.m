//
//  CanonNode.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "CannonNode.h"
#import "LevelXmlConstants.h"

@implementation CannonNode

- (id) initWithPosition:(CGPoint)position rotation:(CGFloat)degrees {
    if (self = [super initWithImageNamed:@"Cannon" position:position allowInteraction:NO rotation:degrees]) {
        self.name = @"cannon";
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, self.size.height * 0.43)];
        self.physicsBody.dynamic = NO;
        self.physicsBody.categoryBitMask = cannonConst;
        self.physicsBody.contactTestBitMask = cannonConst | ballConst;
        
        [[self childNodeWithName:@"bounding"] setYScale:0.7f];
        [[self childNodeWithName:@"bounding"] setXScale:1.5f];
    }
    
    return self;
}

+ (id)canonWithPosition:(CGPoint)position rotation:(CGFloat)degrees {
    return [[CannonNode alloc] initWithPosition:position rotation:degrees];
}


- (void)fire {
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Cannon"];
    SKTexture *f1 = [atlas textureNamed:@"CannonFrame1.png"];
    SKTexture *f2 = [atlas textureNamed:@"CannonFrame2.png"];
    SKTexture *f3 = [atlas textureNamed:@"CannonFrame3.png"];
    SKTexture *f4 = [atlas textureNamed:@"CannonFrame4.png"];
    SKTexture *f5 = [atlas textureNamed:@"CannonFrame5.png"];
    NSArray *cannonFireTextures = @[f1,f2,f3,f4, f5];

    SKAction *cannonFireAction = [SKAction animateWithTextures:cannonFireTextures timePerFrame:0.1 resize:YES restore:YES];
    [self runAction:cannonFireAction];
    
    SKAction *cannonNoise = [SKAction playSoundFileNamed:@"cannon_noise.wav" waitForCompletion:NO];
    [self runAction:cannonNoise];
    

}

#pragma mark - XML Writer

- (NSString *)gameNodeXml {
    CGFloat degrees = [GameSpriteNode radiansToDegrees:self.zRotation];
    return [NSString stringWithFormat:@"\t<%@ x='%f' y='%f' rotation='%f' />", kCannonTag, self.position.x, self.position.y,degrees];
}

@end
