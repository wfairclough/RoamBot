//
//  Story.m
//  WhenAmI
//
//  Created by Kat Butler on 2014-01-19.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "Story.h"

@implementation Story

- (id) initWithSize:(CGSize)size {
    if(self = [super initWithColor:[UIColor blackColor] size:size]) {
        double delay1 = 4.0;
        double delay2 = 5.0;
        double delay3 = 6.0;
        double delay4 = 7.0;
        
        //set shit up
        [self setName:@"story"];
        [self setAnchorPoint:CGPointMake(0, 0)];
        
        
        SKSpriteNode *story1 = [[SKSpriteNode alloc] initWithImageNamed:@"story1"];
        [story1 setPosition:CGPointMake(160, 300)];
        
        [self addChild:story1];
        
        SKSpriteNode *text1 = [[SKSpriteNode alloc] initWithImageNamed:@"Text1"];
        [text1 setPosition:CGPointMake(160, 100)];
        
        [self addChild:text1];
        
        //STORY 2
        dispatch_time_t story2Delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay2 * NSEC_PER_SEC));
        dispatch_after(story2Delay, dispatch_get_main_queue(), ^(void){
            SKSpriteNode *story2 = [[SKSpriteNode alloc] initWithImageNamed:@"story2"];
            [story2 setPosition:CGPointMake(160, 300)];
            
            [self addChild:story2];
            [story1 removeFromParent];
            
            SKSpriteNode *text2 = [[SKSpriteNode alloc] initWithImageNamed:@"Text2"];
            [text2 setPosition:CGPointMake(160, 100)];
            
            [self addChild:text2];
            [text1 removeFromParent];
            
            //STORY 3
            dispatch_time_t story3Delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay4 * NSEC_PER_SEC));
            dispatch_after(story3Delay, dispatch_get_main_queue(), ^(void){
                SKSpriteNode *story3 = [[SKSpriteNode alloc] initWithImageNamed:@"story3"];
                [story3 setPosition:CGPointMake(160, 300)];
                
                [self addChild:story3];
                [story2 removeFromParent];
                
                SKSpriteNode *text3 = [[SKSpriteNode alloc] initWithImageNamed:@"Text3"];
                [text3 setPosition:CGPointMake(160, 100)];
                
                [self addChild:text3];
                [text2 removeFromParent];
                
                //STORY 4
                dispatch_time_t story4Delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay3 * NSEC_PER_SEC));
                dispatch_after(story4Delay, dispatch_get_main_queue(), ^(void){
                    SKSpriteNode *story4 = [[SKSpriteNode alloc] initWithImageNamed:@"story4"];
                    [story4 setPosition:CGPointMake(160, 300)];
                    
                    [self addChild:story4];
                    [story3 removeFromParent];
                    
                    SKSpriteNode *text4 = [[SKSpriteNode alloc] initWithImageNamed:@"Text4"];
                    [text4 setPosition:CGPointMake(160, 100)];
                    
                    [self addChild:text4];
                    [text3 removeFromParent];
                    
                    //STORY 5
                    dispatch_time_t story5Delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay4 * NSEC_PER_SEC));
                    dispatch_after(story5Delay, dispatch_get_main_queue(), ^(void){
                        SKSpriteNode *story5 = [[SKSpriteNode alloc] initWithImageNamed:@"story5"];
                        [story5 setPosition:CGPointMake(160, 300)];
                        
                        [self addChild:story5];
                        [story4 removeFromParent];
                        
                        SKSpriteNode *text5 = [[SKSpriteNode alloc] initWithImageNamed:@"Text5"];
                        [text5 setPosition:CGPointMake(160, 100)];
                        
                        [self addChild:text5];
                        [text4 removeFromParent];
                        
                        //STORY 6
                        dispatch_time_t story6Delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay4 * NSEC_PER_SEC));
                        dispatch_after(story6Delay, dispatch_get_main_queue(), ^(void){
                            SKSpriteNode *story6 = [[SKSpriteNode alloc] initWithImageNamed:@"story6"];
                            [story6 setPosition:CGPointMake(160, 300)];
                            
                            [self addChild:story6];
                            [story5 removeFromParent];
                            
                            SKSpriteNode *text6 = [[SKSpriteNode alloc] initWithImageNamed:@"Text6"];
                            [text6 setPosition:CGPointMake(160, 100)];
                            
                            [self addChild:text6];
                            [text5 removeFromParent];
                        });

                    });
                });
            });
        });
        

    }
    
    return self;
}


@end
