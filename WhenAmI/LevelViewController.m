//
//  LevelViewController.m
//  WhenAmI
//
//  Created by Kat Butler on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "LevelViewController.h"
#import "GameScene.h"

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
    
    self.screenNumber.text = [NSString stringWithFormat:@"WORLD #%d", self.index];
    
    //TODO: hard coded until we have level select implemented properly with GamePlayer settings
    if(self.index != 1) {
//        [self.W1L1 setBackgroundColor:[UIColor darkGrayColor]];
    }
    
//    UIImageView *t = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"test"]];
//    [self.W1L1 setUserInteractionEnabled:YES];
    
    
//    SEL setErrorSelector = sel_registerName("setError:");
    
//    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(levelPressed:)];
//    
//    [self.W1L1 addGestureRecognizer:tapper];
    
    UIImage *bird = [UIImage imageNamed:@"hipwoodbird"];
    
    [self.birdButton setImage:bird forState:UIControlStateNormal]; //change state for highlighted
    [self.birdButton addTarget:self action:@selector(levelPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

// Load SpriteKit View
- (IBAction)levelPressed:(UIButton *)sender {
    // Configure the view.
    
//    sender.tag
    [self.delegate playLevel:-1];
    
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
