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
#import "LevelXmlWriter.h"


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
    
    UITapGestureRecognizer *oneFingerDoubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOneFingerDoubleTap:)];
    [oneFingerDoubleTapGestureRecognizer setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:oneFingerDoubleTapGestureRecognizer];
    
    UITapGestureRecognizer *twoFingerTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    [twoFingerTapGestureRecognizer setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:twoFingerTapGestureRecognizer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    
}


#pragma mark - Level Writer

- (void) saveLevelToFile:(NSInteger)level {
    LevelXmlWriter* writer = [[LevelXmlWriter alloc] init];
    
    [writer startXmlWithLevel:5];
    for (SKNode* node in self.children) {
        if ([node isKindOfClass:[GameSpriteNode class]]) {
            GameSpriteNode* gameNode = (GameSpriteNode *)node;
            [writer addXmlTagWithGameNode:gameNode];
        }
    }
    [writer endXml];
}

#pragma mark - Gesture Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.currentlySelectedNode = [self nodeAtPoint:[self convertPointFromView:[[touches anyObject] locationInView:self.view]]];
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
        self.currentlySelectedNode = [self nodeAtPoint:[self convertPointFromView:[sender locationInView:self.view]]];
        if ([self.currentlySelectedNode.parent.name isEqualToString:@"ball"]) {
            self.currentlySelectedNode.parent.physicsBody.dynamic = YES;
        }
        if (kDavMode) {
            if ([self.currentlySelectedNode.name  isEqualToString:@"label"]) {
                SKLabelNode *label = (SKLabelNode*)self.currentlySelectedNode;
                if ([label.text  isEqualToString:@"B"]) {
                    [self addChild:[BallNode ballWithPosition:CGPointMake(self.size.width/2, self.size.height/2) allowInteraction:YES]];
                } else if ([label.text  isEqualToString:@"P"]) {
                    [self addChild:[PlankNode plankWithPosition:CGPointMake(self.size.width/2, self.size.height/2) allowInteraction:YES rotation:0.0f power:NO]];
                }
            }
        }
    }
}

- (void)handleOneFingerDoubleTap:(UITapGestureRecognizer*)sender {
    if (kDavMode) {
        self.currentlySelectedNode = [self nodeAtPoint:[self convertPointFromView:[sender locationInView:self.view]]];
        [self.currentlySelectedNode.parent removeFromParent];
    }
}

- (void)handleTwoFingerTap:(UITapGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (kDavMode) {
            if (![self childNodeWithName:@"label"]) {
                // Add Ball Label
                SKLabelNode *ballLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
                [ballLabel setFontSize:48.0f];
                [ballLabel setPosition:CGPointMake(self.size.width - 40, self.size.height - 40)];
                [ballLabel setText:@"B"];
                [ballLabel setName:@"label"];
                [self addChild:ballLabel];
                
                // Add Plank Label
                SKLabelNode *plankLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
                [plankLabel setFontSize:48.0f];
                [plankLabel setPosition:CGPointMake(self.size.width - 40, self.size.height - 90)];
                [plankLabel setText:@"P"];
                [plankLabel setName:@"label"];
                [self addChild:plankLabel];
            } else {
                if (![self childNodeWithName:@"label"].isHidden) {
                    for (SKNode *s in [self children]) {
                        if ([s.name isEqualToString:@"label"]) {
                            [s removeFromParent];
                        }
                    }
                }
            }
        }
    }
}

- (void)handlePan:(UIPanGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        if ([self.currentlySelectedNode respondsToSelector:@selector(rotateByAngle:)]) {
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
