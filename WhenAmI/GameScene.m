//
//  MyScene.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "GameScene.h"
#import "BallNode.h"
#import "PlankNode.h"

@interface GameScene()
@property (nonatomic, strong) BallNode *ball;
@property (nonatomic, strong) SKNode *currentlySelectedNode;
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.currentlySelectedNode = [self nodeAtPoint:[self convertPointFromView:[[touches anyObject] locationInView:self.view]]];
    NSLog(@"Tap Gesture Began - %@", self.currentlySelectedNode);
}

- (void)handleRotation:(UIRotationGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.currentlySelectedNode = [self nodeAtPoint:[self convertPointFromView:[sender locationInView:self.view]]];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        if ([self.currentlySelectedNode respondsToSelector:@selector(rotateByAngle:)]) {
            GameSpriteNode* boundingBoxNode = (GameSpriteNode *)self.currentlySelectedNode;
            if (boundingBoxNode.isBoundingBox) {
                GameSpriteNode* currentGameNode = (GameSpriteNode *)boundingBoxNode.parent;
                [currentGameNode rotateByAngle:[sender rotation]];
                [sender setRotation:0.0];
            }
        }
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
    }
}

- (void)handleOneFingerTap:(UITapGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.ball.physicsBody.dynamic = YES;
    }
}

- (void)handlePan:(UIPanGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        if ([self.currentlySelectedNode respondsToSelector:@selector(setPosition:)]) {
            GameSpriteNode* boundingBoxNode = (GameSpriteNode *)self.currentlySelectedNode;
            if (boundingBoxNode.isBoundingBox) {
                GameSpriteNode* currentGameNode = (GameSpriteNode *)boundingBoxNode.parent;
                CGPoint pos = CGPointMake((currentGameNode.position.x + [sender translationInView:self.view].x), (currentGameNode.position.y - [sender translationInView:self.view].y));
                [currentGameNode setPosition:pos];
                [sender setTranslation:CGPointMake(0.0, 0.0) inView:self.view];
                
            }
        }
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
    }
}

#pragma mark - Level Setup
- (void) setupBallWithXPosition:(float)x yPosition:(float)y allowInteraction:(BOOL)isInteractable {
    self.ball = [BallNode ballWithPosition:CGPointMake(x, y) allowInteraction:isInteractable];
    [self addChild:self.ball];
}

- (void) setupPlankWithXPosition:(float)x yPosition:(float)y allowInteraction:(BOOL)isInteractable rotationAngle:(float)rotation  powered:(BOOL)powered {
    PlankNode *plank = [PlankNode plankWithPosition:CGPointMake(x, y) allowInteraction:(BOOL)isInteractable rotation:rotation power:YES];
    [self addChild:plank];
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
