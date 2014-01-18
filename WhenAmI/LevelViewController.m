//
//  LevelViewController.m
//  WhenAmI
//
//  Created by Kat Butler on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "LevelViewController.h"
#import "GameScene.h"
#import "GamePlayer.h"


@interface LevelViewController ()


@end

@implementation LevelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    int level = [[[GamePlayer sharedInstance] currentLevel] intValue];
    
    //TODO: hard coded until we have level select implemented properly with GamePlayer settings
    [self.level1Btn addTarget:self action:@selector(levelPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.level2Btn addTarget:self action:@selector(levelPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.level3Btn addTarget:self action:@selector(levelPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.level1Btn setTag:((self.index * 3) + 1)];
    [self.level2Btn setTag:((self.index * 3) + 2)];
    [self.level3Btn setTag:((self.index * 3) + 3)];
    
    
    NSString *btn1ImageName = [NSString stringWithFormat:@"menu_button_%d_%d", self.index, [self.level1Btn tag]];
    NSString *btn2ImageName = [NSString stringWithFormat:@"menu_button_%d_%d", self.index, [self.level2Btn tag]];
    NSString *btn3ImageName = [NSString stringWithFormat:@"menu_button_%d_%d", self.index, [self.level3Btn tag]];
    
    [self.level1Btn setImage:[UIImage imageNamed:btn1ImageName] forState:UIControlStateNormal];
    [self.level2Btn setImage:[UIImage imageNamed:btn2ImageName] forState:UIControlStateNormal];
    [self.level3Btn setImage:[UIImage imageNamed:btn3ImageName] forState:UIControlStateNormal];
    
    
//    [self.birdButton setImage:bird forState:UIControlStateNormal]; //change state for highlighted
    
    
}

// Load SpriteKit View
- (IBAction)levelPressed:(UIButton *)sender {
    NSLog(@"Tag: %d", sender.tag);
    [[GamePlayer sharedInstance] setSelectedLevel:[NSNumber numberWithInteger:sender.tag]];
    [self.delegate playLevel:[sender tag]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * Use this to get rid of the status bar.
 */
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
