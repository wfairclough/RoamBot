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
#import "WallNode.h"
#import "LevelXmlWriter.h"
#import "GamePlayer.h"
#import "GameSounds.h"


@interface GameScene()

@property (nonatomic, strong) BallNode *ball;
@property (nonatomic, strong) SKNode *currentlySelectedNode;

@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        [[GameSounds sharedInstance] playLevelMusic];
        
        if (kDavMode) {
            [self loadLevel:-1];
        } else {
            NSNumber* level = [[GamePlayer sharedInstance] selectedLevel];
            if (level == nil)
                level = [[GamePlayer sharedInstance] currentLevel];
            
            [self loadLevel:[level integerValue]];
            
        }
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

- (void) saveLevelToFile:(int)level {
    LevelXmlWriter* writer = [[LevelXmlWriter alloc] init];
    
    [writer startXmlWithLevel:level];
    for (SKNode* node in self.children) {
        if ([node isKindOfClass:[GameSpriteNode class]]) {
            GameSpriteNode* gameNode = (GameSpriteNode *)node;
            [writer addXmlTagWithGameNode:gameNode];
        }
    }
    [writer endXml];
}

-(NSString *)documentDirectory{
    [NSFileManager defaultManager];
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
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
            if (kDavMode) {
                [self saveLevelToFile:-1];
            }
            self.currentlySelectedNode.parent.physicsBody.dynamic = YES;
        }
        if (kDavMode) {
            if ([self.currentlySelectedNode.name  isEqualToString:@"label"]) {
                SKLabelNode *label = (SKLabelNode*)self.currentlySelectedNode;
                if ([label.text  isEqualToString:@"B"]) {
                    [self addChild:[BallNode ballWithPosition:CGPointMake(self.size.width/2, self.size.height/2) allowInteraction:YES]];
                } else if ([label.text  isEqualToString:@"P"]) {
                    [self addChild:[PlankNode plankWithPosition:CGPointMake(self.size.width/2, self.size.height/2) allowInteraction:YES rotation:0.0f power:NO]];
                } else if ([label.text  isEqualToString:@"Reset"]) {
                    [self resetLevel];
                } else if ([label.text  isEqualToString:@"S"]) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Hey Davyn! Level number please :D" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"SAVE",nil];
                    alert.tag = 0;
                    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
                    [alert show];
                }
                else if ([label.text  isEqualToString:@"O"]) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Open Level" message:@"enter a level number" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OPEN",nil];
                    alert.tag = 1;
                    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
                    [alert show];
                }
            }
        }
    }
}

// grabs number from save dialog
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView tag] == 0 && buttonIndex == 1) {
        int level = [[[alertView textFieldAtIndex:0] text] intValue];
        NSLog(@"Level: %d", level);
        [self saveLevelToFile:level];
    } else if ([alertView tag] == 1 && buttonIndex == 1) {
        [self loadLevel:[[[alertView textFieldAtIndex:0] text] intValue]];
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
                // Add Reset Label
                SKLabelNode *resetLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
                [resetLabel setFontSize:26.0f];
                [resetLabel setPosition:CGPointMake(40.0f, self.size.height - 20)];
                [resetLabel setText:@"Reset"];
                [resetLabel setName:@"label"];
                [self addChild:resetLabel];
                
                // Add Save Label
                SKLabelNode *saveLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
                [saveLabel setFontSize:36.0f];
                [saveLabel setPosition:CGPointMake(20.0f, 10.0f)];
                [saveLabel setText:@"S"];
                [saveLabel setName:@"label"];
                [self addChild:saveLabel];
                
                // Add Open Label
                SKLabelNode *openLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
                [openLabel setFontSize:36.0f];
                [openLabel setPosition:CGPointMake(20.0f, 70.0f)];
                [openLabel setText:@"O"];
                [openLabel setName:@"label"];
                [self addChild:openLabel];
                
                // Add Plank Label
                SKLabelNode *plankLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
                [plankLabel setFontSize:48.0f];
                [plankLabel setPosition:CGPointMake(self.size.width - 20, self.size.height - 40)];
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

- (void) setupWallWithPosition:(float)x yPosition:(float)y allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees theme:(NSString*)levelStyle Type:(NSString*)type {
    WallNode *wall = [WallNode wallWithPosition:CGPointMake(x, y) allowInteraction:isInteractable rotation:degrees theme:levelStyle Type:type];
    [self addChild:wall];
}

#pragma mark - Game Logic
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

#pragma mark - Private
- (void)loadLevel:(int)level {
    static BOOL firstLoad = YES;

    [self removeAllChildren];
    NSString *filePath = nil;
    if (firstLoad) {
        filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"level_%02d", level] ofType:@"xml"];
        firstLoad = NO;
    } else {
        filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"level_%02d", level] ofType:@"xml"];
        if (kDavMode) {
            filePath = [NSString stringWithFormat:@"%@/level_%02d.xml", [self documentDirectory], level];
        }
    }
    
    NSData *levelData = [NSData dataWithContentsOfFile:filePath];
    
    LevelXmlParser* levelXmlParser = [[LevelXmlParser alloc] initWithData:levelData];
    
    [levelXmlParser setSetupDelegate:self];
    
    [levelXmlParser parse];
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.restitution = 0.5;
}

- (void)resetLevel {
    [self removeAllChildren];
    if (kDavMode) {
        [self loadLevel:-1];
    } else {
        NSNumber* level = [[GamePlayer sharedInstance] selectedLevel];
        if (level == nil)
            level = [[GamePlayer sharedInstance] currentLevel];
        
        [self loadLevel:[level integerValue]];
    }
}


@end
