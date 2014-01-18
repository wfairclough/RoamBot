//
//  MyScene.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "GameScene.h"
#import "BallNode.h"

@interface GameScene()
@property (nonatomic, strong) BallNode *ball;
@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        [self loadLevel];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    // setup gesture recognizer
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [self.view addGestureRecognizer:rotationGestureRecognizer];
    
    UITapGestureRecognizer *oneFingerTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOneFingerTap:)];
    [self.view addGestureRecognizer:oneFingerTapGestureRecognizer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
}

#pragma mark - Gesture Handling

- (void)handleRotation:(UIRotationGestureRecognizer*)sender {
    NSLog(@"Rotate");
}

- (void)handleOneFingerTap:(UITapGestureRecognizer*)sender {
    NSLog(@"1 Finger");
    self.ball.physicsBody.dynamic = YES;
}

- (void)handlePan:(UIPanGestureRecognizer*)sender {
    NSLog(@"Pan");
}

#pragma mark - Level Setup
- (void) setupBallWithXPosition:(float)x yPosition:(float)y {
    self.ball = [BallNode ballWithPosition:CGPointMake(x, y)];
    [self addChild:self.ball];
}

#pragma mark - Game Logic
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

#pragma mark - Private
- (void)loadLevel {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"level_01" ofType:@"xml"];
    NSData *levelData = [NSData dataWithContentsOfFile:filePath];
    
    LevelXmlParser* levelXmlParser = [[LevelXmlParser alloc] initWithData:levelData];
    
    [levelXmlParser setSetupDelegate:self];
    
    [levelXmlParser parse];
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.restitution = 0.5;
}

@end
