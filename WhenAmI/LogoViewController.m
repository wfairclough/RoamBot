//
//  ViewController.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "LogoViewController.h"
#import "GameScene.h"
#import "GameSounds.h"

@implementation LogoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (kDavMode == NO) {
        
        double delayInSeconds = 2.0;
        double delayInSeconds2 = 7.5;
        
        [self.logoImageView setHidden:YES];
        
        // chickenwaffle Logo
        dispatch_time_t logoDelay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(logoDelay, dispatch_get_main_queue(), ^(void){
            [self.logoImageView setHidden:NO];
            [self.chickenTextImageView setHidden:YES];
            [self.waffleTextImageView setHidden:YES];
            [self.imageView setHidden:YES];
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern"]]];
            [[GameSounds sharedInstance] playMenuMusic];
        });
        
        // Game Logo
        dispatch_time_t gameLogoDelay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds2 * NSEC_PER_SEC));
        dispatch_after(gameLogoDelay, dispatch_get_main_queue(), ^(void){
            [self performSegueWithIdentifier:@"LogoToWorldTransition" sender:self];
        });
    } else {
        // Configure the view.
        SKView* skView = [[SKView alloc] initWithFrame:self.view.frame];
        self.view = skView;
//        SKView * skView = (SKView *)self.view;
        skView.showsFPS = kDavMode;
        skView.showsNodeCount = kDavMode;
        
        // Create and configure the scene.
        SKScene * scene = [GameScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
    }
    
}



- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

/**
 * Use this to get rid of the status bar.
 */
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
