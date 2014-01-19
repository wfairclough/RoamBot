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
    
    BOOL icon1Enabled = false;
    BOOL icon2Enabled = false;
    BOOL icon3Enabled = false;
    
    int level = [[[GamePlayer sharedInstance] currentLevel] intValue];

    //TODO: hard coded until we have level select implemented properly with GamePlayer settings
    [self.level1Btn addTarget:self action:@selector(levelPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.level2Btn addTarget:self action:@selector(levelPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.level3Btn addTarget:self action:@selector(levelPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSString *btn1ImageName;
    NSString *btn2ImageName;
    NSString *btn3ImageName;
    
    int firstPicLevel = ((self.index * 3) + 1);
    int secondPicLevel = ((self.index * 3) + 2);
    int thirdPicLevel = ((self.index * 3) + 3);
    
    [self.level1Btn setTag:firstPicLevel];
    [self.level2Btn setTag:secondPicLevel];
    [self.level3Btn setTag:thirdPicLevel];
    
    
    int firstScore = [[GamePlayer sharedInstance] scoreForLevel:firstPicLevel];
    int secondScore = [[GamePlayer sharedInstance] scoreForLevel:secondPicLevel];
    int thirdScore = [[GamePlayer sharedInstance] scoreForLevel:thirdPicLevel];
    
    if (firstScore >= 1) {
        NSLog(@"Score > 1");
    }
    [self.level1Orb1 setEnabled:(firstScore >= 1)];
    [self.level1Orb2 setEnabled:(firstScore >= 2)];
    [self.level1Orb3 setEnabled:(firstScore >= 3)];
    
    [self.leve2Orb1 setEnabled:(secondScore >= 1)];
    [self.leve2Orb2 setEnabled:(secondScore >= 2)];
    [self.leve2Orb3 setEnabled:(secondScore >= 3)];
    
    [self.leve3Orb1 setEnabled:(thirdScore >= 1)];
    [self.leve3Orb2 setEnabled:(thirdScore >= 2)];
    [self.leve3Orb3 setEnabled:(thirdScore >= 3)];
    
    
    
    if(self.level1Btn.tag > level) {
        btn1ImageName = [NSString stringWithFormat:@"menu_button_%d_off", self.index];
        icon1Enabled = false;
    } else {
        btn1ImageName = [NSString stringWithFormat:@"menu_button_%d_%d", self.index, [self.level1Btn tag]];
        icon1Enabled = true;
    }
    
    
    if(self.level2Btn.tag > level) {
        btn2ImageName = [NSString stringWithFormat:@"menu_button_%d_off", self.index];
        icon2Enabled = false;
    } else {
        btn2ImageName = [NSString stringWithFormat:@"menu_button_%d_%d", self.index, [self.level2Btn tag]];
        icon2Enabled = true;
    }
    
    
    if(self.level3Btn.tag > level) {
        btn3ImageName = [NSString stringWithFormat:@"menu_button_%d_off", self.index];
        icon3Enabled = false;
    } else {
        btn3ImageName = [NSString stringWithFormat:@"menu_button_%d_%d", self.index, [self.level3Btn tag]];
        icon3Enabled = true;
    }

    [self.level1Btn setEnabled:icon1Enabled];
    [self.level2Btn setEnabled:icon2Enabled];
    [self.level3Btn setEnabled:icon3Enabled];
    
    [self.level1Btn setImage:[UIImage imageNamed:btn1ImageName] forState:UIControlStateNormal];
    [self.level2Btn setImage:[UIImage imageNamed:btn2ImageName] forState:UIControlStateNormal];
    [self.level3Btn setImage:[UIImage imageNamed:btn3ImageName] forState:UIControlStateNormal];
    
}

// Load SpriteKit View
- (IBAction)levelPressed:(UIButton *)sender {
    NSLog(@"Tag: %d", sender.tag);
    
    if(sender.isEnabled == TRUE) {
        NSString *pathEnabled = [[NSBundle mainBundle]pathForResource:@"Clip2" ofType:@"wav"];
        self.audio = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:pathEnabled] error:NULL];
        [self.audio play];
        
    }
    
    if (sender.isEnabled == FALSE) {
        NSString *pathDisabled = [[NSBundle mainBundle]pathForResource:@"Clip3" ofType:@"wav"];
        self.audio = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:pathDisabled] error:NULL];
        [self.audio play];
    }
    
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
