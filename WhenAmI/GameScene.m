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
#import "CannonNode.h"
#import "LevelXmlWriter.h"
#import "GamePlayer.h"
#import "GameSounds.h"
#import "GoalNode.h"
#import "CollectableNode.h"
#import "ItemIcon.h"
#import "LevelCompleteDialog.h"



#define kSpaceWorld @"space"
#define kGreekWorld @"greek"
#define kMedievalWorld @"medieval"

@interface GameScene()

@property (nonatomic) BOOL inProgress;

@property (nonatomic, strong) BallNode *ball;
@property (nonatomic, strong) SKNode *currentlySelectedNode;
@property (nonatomic) CGPoint ballStartPoint;
@property (nonatomic) CGPoint collectableStartPos1;
@property (nonatomic) CGPoint collectableStartPos2;
@property (nonatomic) CGPoint collectableStartPos3;

@property (nonatomic) int numberOfPoweredPlanksAvailiable;
@property (nonatomic) int numberOfWoodPlanksAvailiable;
@property (nonatomic) int numberOfCannonsAvailiable;

@property (nonatomic) int energyScore;

@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {

        [self setBackgroundColor:[UIColor colorWithRed:6.0f/255.0f green:80.0f/255.0f blue:112.0f/255.0f alpha:1]];
        [self.physicsWorld setContactDelegate:self];
        
        [[GameSounds sharedInstance] playLevelMusic];
        
        if (kDavMode) {
            [self loadLevel:-1];
        } else {
            NSNumber* level = [[GamePlayer sharedInstance] selectedLevel];
            if (level == nil)
                level = [[GamePlayer sharedInstance] currentLevel];
            
            [self loadLevel:[level integerValue]];
            
        }
        
        //TEMP TEMP TEMP
        NSArray *listOfXMLs = @[@"level_-1", @"level_00", @"level_01", @"level_02", @"level_03", @"level_04", @"level_05", @"level_06", @"level_07", @"level_08", @"level_09"];
        for (NSString *s in listOfXMLs) {
            NSURL *fileFromBundle = [[NSBundle mainBundle]URLForResource:s withExtension:@"xml"];
            
            if (fileFromBundle == nil) continue;
            
            NSURL *destinationURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                             inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:[s stringByAppendingString:@".xml"]];
            [[NSFileManager defaultManager]copyItemAtURL:fileFromBundle toURL:destinationURL error:nil];
        }
        //TEMP TEMP TEMP
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
                
                if ([currentGameNode allowsUserInteraction] && !self.inProgress) {
                    [currentGameNode rotateByAngle:[sender rotation]];
                    [sender setRotation:0.0];
                }
            }
        }
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
    }
}

- (void)handleOneFingerTap:(UITapGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.currentlySelectedNode = [self nodeAtPoint:[self convertPointFromView:[sender locationInView:self.view]]];
        NSLog(@"Tapped on parent: %@", self.currentlySelectedNode.parent.name);
        if ([self.currentlySelectedNode.parent.name isEqualToString:@"ball"]) {
            [self ballTapped];
        }
        
        if ([self.currentlySelectedNode.parent.name isEqualToString:@"cannon"]) {
            CannonNode* cannon = (CannonNode *)self.currentlySelectedNode.parent;
            [cannon fire];
        }
        
        if ([self.currentlySelectedNode.name isEqualToString:@"resetBounding"]) {
            [self resetLevel];
        }
        
        if ([self.currentlySelectedNode.name isEqualToString:@"closeBounding"]) {
            [self closeGame];
        }
        
        if ([self.currentlySelectedNode.name isEqualToString:@"nextButton"]) {
            [self selectedNextButton];
        }
        
        if ([self.currentlySelectedNode.name isEqualToString:@"refreshButton"]) {
            [self selectedRefreshButton];
        }
        
        if ([self.currentlySelectedNode.name isEqualToString:@"closeButton"]) {
            [self closeGame];
        }
        
        if ([self.currentlySelectedNode.parent.name isEqualToString:@"poweredplankicon"]) {
            ItemIcon *temp = (ItemIcon*)[[self currentlySelectedNode] parent];
            if ([temp amount] > 0) {
                [self addChild:[PlankNode plankWithPosition:CGPointMake(self.size.width/2, self.size.height/2) allowInteraction:YES rotation:0.0f power:YES theme:@"space"]];
                [temp redrawText];
                _numberOfPoweredPlanksAvailiable = [temp amount];
            }
        } else if ([self.currentlySelectedNode.parent.name isEqualToString:@"woodplankicon"]) {
            ItemIcon *temp = (ItemIcon*)[[self currentlySelectedNode] parent];
            if ([temp amount] > 0) {
                [self addChild:[PlankNode plankWithPosition:CGPointMake(self.size.width/2, self.size.height/2) allowInteraction:YES rotation:0.0f power:NO theme:@"greek"]];
                [temp redrawText];
                _numberOfWoodPlanksAvailiable = [temp amount];
            }
        } else if ([self.currentlySelectedNode.parent.name isEqualToString:@"cannonicon"]) {
            ItemIcon *temp = (ItemIcon*)[[self currentlySelectedNode] parent];
            if ([temp amount] > 0) {
                [self addChild:[CannonNode canonWithPosition:CGPointMake(self.size.width/2, self.size.height/2) rotation:45.0f]];
                [temp redrawText];
                _numberOfCannonsAvailiable = [temp amount];
            }
        }
        
        // DavMode Only
        if (kDavMode) {
            if ([self.currentlySelectedNode.name  isEqualToString:@"label"]) {
                SKLabelNode *label = (SKLabelNode*)self.currentlySelectedNode;
                if ([label.text  isEqualToString:@"W"]) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Select a size" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"small",@"medium",@"large",nil];
                    alert.tag = 2;
                    [alert show];
                } else if ([label.text  isEqualToString:@"P1"]) {
                    [self addChild:[PlankNode plankWithPosition:CGPointMake(self.size.width/2, self.size.height/2) allowInteraction:YES rotation:0.0f power:YES theme:@"space"]];
                } else if ([label.text  isEqualToString:@"P"]) {
                    [self addChild:[PlankNode plankWithPosition:CGPointMake(self.size.width/2, self.size.height/2) allowInteraction:YES rotation:0.0f power:NO theme:@"greek"]];
                } else if ([label.text  isEqualToString:@"Reset"]) {
                    [self resetLevel];
                } else if ([label.text  isEqualToString:@"C"]) {
                    [self addChild:[CannonNode canonWithPosition:CGPointMake(self.size.width/2, self.size.height/2) rotation:45.0f]];
                } else if ([label.text  isEqualToString:@"E"]) {
                    [self addChild:[CollectableNode collectableWithPosition:CGPointMake(self.size.width/2, self.size.height/2) type:@""]];
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
    } else if ([alertView tag] == 2) {
        if (buttonIndex == 1) {
            [self addChild:[WallNode wallWithPosition:CGPointMake(self.size.width/2, self.size.height/2) allowInteraction:NO rotation:0.0f theme:@"space" imageSize:@"small"]];
        } else if (buttonIndex == 2) {
            [self addChild:[WallNode wallWithPosition:CGPointMake(self.size.width/2, self.size.height/2) allowInteraction:NO rotation:0.0f theme:@"space" imageSize:@"medium"]];
        } else if (buttonIndex == 3) {
            [self addChild:[WallNode wallWithPosition:CGPointMake(self.size.width/2, self.size.height/2) allowInteraction:NO rotation:0.0f theme:@"space" imageSize:@"large"]];
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
                // Add Reset Label
//                SKLabelNode *resetLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
//                [resetLabel setFontSize:26.0f];
//                [resetLabel setPosition:CGPointMake(40.0f, self.size.height - 20)];
//                [resetLabel setText:@"Reset"];
//                [resetLabel setName:@"label"];
//                [self addChild:resetLabel];
                
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
                SKLabelNode *powerPlankLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
                [powerPlankLabel setFontSize:48.0f];
                [powerPlankLabel setPosition:CGPointMake(self.size.width - 30, self.size.height - 90)];
                [powerPlankLabel setText:@"P"];
                [powerPlankLabel setName:@"label"];
                [self addChild:powerPlankLabel];
                
                // Add Wall Label
                SKLabelNode *wallLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
                [wallLabel setFontSize:48.0f];
                [wallLabel setPosition:CGPointMake(self.size.width - 30, self.size.height - 140)];
                [wallLabel setText:@"W"];
                [wallLabel setName:@"label"];
                [self addChild:wallLabel];
                
                // Add Cannon Label
                SKLabelNode *cannonLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
                [cannonLabel setFontSize:48.0f];
                [cannonLabel setPosition:CGPointMake(self.size.width - 30, self.size.height - 190)];
                [cannonLabel setText:@"C"];
                [cannonLabel setName:@"label"];
                [self addChild:cannonLabel];
                
                // Add Cannon Label
                SKLabelNode *energyLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
                [energyLabel setFontSize:48.0f];
                [energyLabel setPosition:CGPointMake(self.size.width - 30, self.size.height - 240)];
                [energyLabel setText:@"E"];
                [energyLabel setName:@"label"];
                [self addChild:energyLabel];
                
                // Add Powered Plank Label
                SKLabelNode *plankLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
                [plankLabel setFontSize:48.0f];
                [plankLabel setPosition:CGPointMake(self.size.width - 30, self.size.height - 290)];
                [plankLabel setText:@"P1"];
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
                if ([currentGameNode allowsUserInteraction] && !self.inProgress) {
                    CGPoint pos = CGPointMake((currentGameNode.position.x + [sender translationInView:self.view].x), (currentGameNode.position.y - [sender translationInView:self.view].y));
                    [currentGameNode setPosition:pos];
                    [sender setTranslation:CGPointMake(0.0, 0.0) inView:self.view];
                }
                
            }
        }
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
    }
}


#pragma mark - Contact Delegate

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    uint32_t collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
    
    if (collision == (goalConst | ballConst)) {
        GoalNode *goal;
        
        if ([contact.bodyA.node.name isEqualToString:@"goal"])
        {
            goal = (GoalNode*)contact.bodyA.node;
        } else {
            goal = (GoalNode*)contact.bodyB.node;
        }
        
        [goal contactWithBall: self.ball];
        
        
        if (!kDavMode) {
            [[self childNodeWithName:@"reset"] setHidden:YES];
            [self childNodeWithName:@"close"].hidden = YES;
            
            if ([[GamePlayer sharedInstance] setEnergyScoreForSelectedLevel:_energyScore]) {
                
            }
            
            LevelCompleteDialog *dialog = [[LevelCompleteDialog alloc] initWithSize:self.size];
            [self addChild:dialog];
            
        }
        
        return;
    }
    
    if (collision == (collectableConst | ballConst)) {
        CollectableNode *collectable;
        
        if ([contact.bodyA.node.name isEqualToString:@"collectable"])
        {
            collectable = (CollectableNode*)contact.bodyA.node;
        } else {
            collectable = (CollectableNode*)contact.bodyB.node;
        }
        
        [collectable contactWithBall];
        
        _energyScore++;
        
        return;
    }
    
    
    
    if (collision == (cannonConst | ballConst)) {
        CannonNode *cannon;
        
        if ([contact.bodyA.node.name isEqualToString:@"cannon"])
        {
            cannon = (CannonNode *)contact.bodyA.node;
        } else {
            cannon = (CannonNode *)contact.bodyB.node;
        }
        
        [cannon contactWithBall: self.ball];
        
    }
    
}

- (void)didEndContact:(SKPhysicsContact *)contact {
    
}

#pragma mark - LoadLevel Dialog

- (void) selectedNextButton {
    NSLog(@"Next pressed");
    int newLevel = [[GamePlayer sharedInstance] increaseSelectedLevel];
    [[self childNodeWithName:@"loadCompleteDialog"] removeFromParent];
    [self loadLevel:newLevel];
}

- (void) selectedRefreshButton {
    NSLog(@"Refresh pressed");
    [[GamePlayer sharedInstance] increaseSelectedLevel];
    [[self childNodeWithName:@"loadCompleteDialog"] removeFromParent];
    
    self.ball.hidden = NO;
    [self childNodeWithName:@"reset"].hidden = NO;
    [self childNodeWithName:@"close"].hidden = NO;
    
    [self resetLevel];
}

- (void) dialogInteraction {
    
}

#pragma mark - Level Setup

- (void) setupWorldType:(NSString*)worldType {
    
    if ([worldType isEqualToString:kSpaceWorld]) {
        SKSpriteNode* bg = [SKSpriteNode spriteNodeWithImageNamed:@"space-bg"];
        [bg setAnchorPoint:CGPointMake(0.0f, 0.0f)];
        [self addChild:bg];
    } else if ([worldType isEqualToString:kGreekWorld]) {
        SKSpriteNode* bg = [SKSpriteNode spriteNodeWithImageNamed:@"greek-bg"];
        [bg setAnchorPoint:CGPointMake(0.0f, 0.0f)];
        [self addChild:bg];
    } else if ([worldType isEqualToString:kMedievalWorld]) {
        SKSpriteNode* bg = [SKSpriteNode spriteNodeWithImageNamed:@"medieval-bg"];
        [bg setAnchorPoint:CGPointMake(0.0f, 0.0f)];
        [self addChild:bg];
    }
}

- (void) setupBallWithXPosition:(float)x yPosition:(float)y {
    self.ball = [BallNode ballWithPosition:CGPointMake(x, y)];
    [self addChild:self.ball];
}

- (void) setupPlankWithXPosition:(float)x yPosition:(float)y allowInteraction:(BOOL)isInteractable rotationAngle:(float)rotation  powered:(BOOL)powered theme:(NSString*)theme{
    PlankNode *plank = [PlankNode plankWithPosition:CGPointMake(x, y) allowInteraction:(BOOL)isInteractable rotation:rotation power:powered theme:theme];
    [self addChild:plank];
}

- (void) setupWallWithPosition:(float)x yPosition:(float)y allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees theme:(NSString*)theme imageSize:(NSString*)imageSize {
    WallNode *wall = [WallNode wallWithPosition:CGPointMake(x, y) allowInteraction:isInteractable rotation:degrees theme:theme imageSize:imageSize];
    [self addChild:wall];
}
    
- (void) setupGoalWithXPosition:(float)x yPosition:(float)y rotationAngle:(float)rotation theme:(NSString*)theme {
    GoalNode *goal = [GoalNode goalWithPosition:CGPointMake(x, y) rotation:rotation theme:theme];
    [self addChild:goal];
}

- (void) setupCollectableWithXPosition:(float)x yPosition:(float)y type:(NSString*)type {
    CollectableNode *collectable = [CollectableNode collectableWithPosition:CGPointMake(x, y) type:type];
    [self addChild:collectable];
}

- (void) setupCanonWithXPosition:(float)x yPosition:(float)y rotationAngle:(float)degrees {
    CannonNode* canon = [CannonNode canonWithPosition:CGPointMake(x, y) rotation:degrees];
    [self addChild:canon];
}

- (void) setupItemIconsWithItem:(NSString *)item amount:(int)amount {
    if ([item isEqualToString:@"poweredplank"]) {
        _numberOfPoweredPlanksAvailiable = amount;
    } else if ([item isEqualToString:@"woodplank"]) {
        _numberOfWoodPlanksAvailiable = amount;
    } else if ([item isEqualToString:@"cannon"]) {
        _numberOfCannonsAvailiable = amount;
    }
    
    ItemIcon* icon;
    
    if ([item isEqualToString:@"poweredplank"] && _numberOfPoweredPlanksAvailiable >= 0) {
        icon = [ItemIcon itemWithPosition:CGPointMake(self.size.width/2, self.size.height-20) item:item amount:amount];
        [self addChild:icon];
        [self addChild:[icon amountText]];
    } else if ([item isEqualToString:@"woodplank"] && _numberOfWoodPlanksAvailiable >= 0) {
        icon = [ItemIcon itemWithPosition:CGPointMake(self.size.width/2, self.size.height-20) item:item amount:amount];
        [self addChild:icon];
        [self addChild:[icon amountText]];
    } else if ([item isEqualToString:@"cannon"] && _numberOfCannonsAvailiable >= 0) {
        icon = [ItemIcon itemWithPosition:CGPointMake(self.size.width/2, self.size.height-20) item:item amount:amount];
        [self addChild:icon];
        [self addChild:[icon amountText]];
    }

}

#pragma mark - Game Logic
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


- (void) ballTapped {
    if (kDavMode) {
        [self saveLevelToFile:-1];
    }
    
    
    for (GameSpriteNode *gs in [self children]) {
        if ([gs respondsToSelector:@selector(initializeCollision)]) {
            [gs initializeCollision];
        }
    }
    
    [self.ball.physicsBody setAffectedByGravity:YES];
    [self.ball.physicsBody setDynamic:YES];

    if (!kDavMode) {
       self.inProgress = YES;
    }
    
    
}


#pragma mark - Private
- (void)loadLevel:(int)level {
    static BOOL firstLoad = YES;
    
    _energyScore = 0;

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
    _numberOfPoweredPlanksAvailiable = -1;
    _numberOfWoodPlanksAvailiable = -1;
    _numberOfCannonsAvailiable = -1;
    
    NSData *levelData = [NSData dataWithContentsOfFile:filePath];
    
    LevelXmlParser* levelXmlParser = [[LevelXmlParser alloc] initWithData:levelData];
    
    [levelXmlParser setSetupDelegate:self];
    
    [levelXmlParser parse];
    
    
    
    SKSpriteNode *closeBtn = [SKSpriteNode spriteNodeWithImageNamed:@"close"];
    [closeBtn setName:@"close"];
    [closeBtn setPosition:CGPointMake(20, self.size.height - 20)];
    SKSpriteNode *closeBounding = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.4f] size:CGSizeMake(closeBtn.size.width*2, closeBtn.size.height*2)];
    [closeBounding setName:@"closeBounding"];
    [closeBounding setHidden:YES];
    [closeBtn addChild:closeBounding];
    [self addChild:closeBtn];
    
    
    
    SKSpriteNode *reset = [SKSpriteNode spriteNodeWithImageNamed:@"reload"];
    [reset setName:@"reset"];
    [reset setPosition:CGPointMake(self.size.width - 20, self.size.height - 20)];
    SKSpriteNode *resetBounding = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.4f] size:CGSizeMake(reset.size.width*2, reset.size.height*2)];
    [resetBounding setName:@"resetBounding"];
    [resetBounding setHidden:YES];
    [reset addChild:resetBounding];
    [self addChild:reset];
    
    
    [self setBallStartPoint:[self childNodeWithName:@"ball"].position];
    int collectCount = 1;
    for (GameSpriteNode *gs in [self children]) {
        if ([gs.name isEqualToString:@"collectable"]) {
            if (collectCount == 1) {
                self.collectableStartPos1 = [gs position];
            } else if (collectCount == 2) {
                self.collectableStartPos2 = [gs position];
            } else if (collectCount == 3) {
                self.collectableStartPos3 = [gs position];
            }
            collectCount++;
        }
        
    }
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.restitution = 0.5;
    
    
    self.inProgress = NO;
}

- (void)resetLevel {
    _energyScore = 0;
    
    GoalNode* goal = (GoalNode *)[self childNodeWithName:@"goal"];
    
    if (goal != nil)
        [goal resetGoal];
    
    self.inProgress = NO;
    
    if (kDavMode) {
        [self removeAllChildren];
        [self loadLevel:-1];
    } else {
        [self.ball.physicsBody setAffectedByGravity:NO];
        [self.ball.physicsBody setAngularVelocity:0.0f];
        [self.ball.physicsBody setVelocity:CGVectorMake(0.0f, 0.0f)];
        [self.ball setPosition:self.ballStartPoint];

        self.ball.physicsBody.contactTestBitMask = 0x0;
        self.ball.physicsBody.collisionBitMask = 0x0;
        for (SKSpriteNode *gs in self.children) {
            if (gs.physicsBody != nil) {
                gs.physicsBody.contactTestBitMask = 0x0;
                gs.physicsBody.collisionBitMask = 0x0;
            }
        }
        
        for (SKSpriteNode *gs in self.children) {
            if ([gs.name isEqualToString:@"collectable"]) {
                [gs removeFromParent];
            } else if ([gs.name isEqualToString:@"poweredplankicon"]) {
                [(ItemIcon*)gs setAmount:_numberOfPoweredPlanksAvailiable];
                [[(ItemIcon*)gs amountText] removeFromParent];
            } else if ([gs.name isEqualToString:@"woodplankicon"]) {
                [(ItemIcon*)gs setAmount:_numberOfWoodPlanksAvailiable];
                [[(ItemIcon*)gs amountText] removeFromParent];
            } else if ([gs.name isEqualToString:@"cannonicon"]) {
                [(ItemIcon*)gs setAmount:_numberOfCannonsAvailiable];
                [[(ItemIcon*)gs amountText] removeFromParent];
            }
        }
        [self addChild:[CollectableNode collectableWithPosition:[self collectableStartPos1] type:@""]];
        [self addChild:[CollectableNode collectableWithPosition:[self collectableStartPos2] type:@""]];
        [self addChild:[CollectableNode collectableWithPosition:[self collectableStartPos3] type:@""]];
        [self setupItemIconsWithItem:@"poweredplank" amount:_numberOfPoweredPlanksAvailiable];
        [self setupItemIconsWithItem:@"woodplank" amount:_numberOfWoodPlanksAvailiable];
        [self setupItemIconsWithItem:@"cannon" amount:_numberOfCannonsAvailiable];
        
        [self.ball.physicsBody setDynamic:NO];
    }
}



- (void) closeGame {
    _energyScore = 0;
    NSLog(@"Closing");
    
}


@end
