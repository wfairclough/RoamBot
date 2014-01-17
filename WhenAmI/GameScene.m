//
//  MyScene.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
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
}

- (void)handlePan:(UIPanGestureRecognizer*)sender {
    NSLog(@"Pan");
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
