//
//  MenuScene.m
//  WhenAmI
//
//  Created by Kat Butler on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "MenuScene.h"

@implementation MenuScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    UITapGestureRecognizer *oneFingerTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOneFingerTap:)];
    [self.view addGestureRecognizer:oneFingerTapGestureRecognizer];

    
}

#pragma mark - Gesture Handling

- (void)handleOneFingerTap:(UITapGestureRecognizer*)sender {
    NSLog(@"1 Finger");
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end