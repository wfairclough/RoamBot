//
//  LevelCompleteDialog.m
//  WhenAmI
//
//  Created by Kat Butler on 2014-01-19.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "LevelCompleteDialog.h"

@implementation LevelCompleteDialog

- (id) initWithSize:(CGSize)size {
    if(self = [super initWithColor:[UIColor clearColor] size:size]) {
        //set shit up
        [self setName:@"loadCompleteDialog"];
        [self setAnchorPoint:CGPointMake(0, 0)];
        
        SKSpriteNode *levelCompleteText = [[SKSpriteNode alloc] initWithImageNamed:@"levelcompletetext"];
        [levelCompleteText setPosition:CGPointMake(size.width/2 - 20, (size.height/2) + 100)];
        
        SKSpriteNode *highscoreText = [[SKSpriteNode alloc] initWithImageNamed:@"highscore"];
        [highscoreText setName:@"highscoreNode"];
        [highscoreText setHidden:YES];
        [highscoreText setPosition:CGPointMake(size.width/2 + 100, (size.height/2) + 130)];
        
        SKSpriteNode *nextButton = [[SKSpriteNode alloc] initWithImageNamed:@"nextbutton"];
        [nextButton setName:@"nextButton"];
        [nextButton setPosition:CGPointMake(size.width/2, (size.height/2) - 50)];
        
        SKSpriteNode *refreshButton = [[SKSpriteNode alloc] initWithImageNamed:@"reload"];
        [refreshButton setName:@"refreshButton"];
        [refreshButton setPosition:CGPointMake((size.width/2) + 50, (size.height/2) + 50)];
        
        
        SKSpriteNode *closeButton = [[SKSpriteNode alloc] initWithImageNamed:@"close"];
        [closeButton setName:@"closeButton"];
        [closeButton setPosition:CGPointMake((size.width/2) - 50, (size.height/2) + 50)];
        
        [self addChild:highscoreText];
        [self addChild:levelCompleteText];
        [self addChild:nextButton];
        [self addChild:refreshButton];
        [self addChild:closeButton];
    }
    
    return self;
}

- (void) setHighscoreOn:(BOOL)value {
    [[self childNodeWithName:@"highscoreNode"] setHidden:!value];
}

@end
