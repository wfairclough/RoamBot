//
//  LevelViewController.m
//  WhenAmI
//
//  Created by Kat Butler on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "LevelViewController.h"

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
    
//    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clouds2"]];
//    [self.view addSubview:backgroundImage];
//    [self.view sendSubviewToBack:backgroundImage];
}

- (void)viewWillAppear:(BOOL)animated {
    self.screenNumber.text = [NSString stringWithFormat:@"WORLD #%d", self.index];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
