//
//  LevelViewController.h
//  WhenAmI
//
//  Created by Kat Butler on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorldsViewController.h"
#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface LevelViewController : UIViewController

@property (nonatomic, weak) id <GameLoaderDelegate> delegate;

@property (assign, nonatomic) NSInteger index;
//@property (strong, nonatomic) IBOutlet UILabel *screenNumber;

@property (weak, nonatomic) IBOutlet UIButton *level1Btn;
@property (weak, nonatomic) IBOutlet UIButton *level2Btn;
@property (weak, nonatomic) IBOutlet UIButton *level3Btn;


@property (weak, nonatomic) IBOutlet UIButton *level1Orb1;
@property (weak, nonatomic) IBOutlet UIButton *level1Orb2;
@property (weak, nonatomic) IBOutlet UIButton *level1Orb3;
@property (weak, nonatomic) IBOutlet UIButton *leve2Orb1;
@property (weak, nonatomic) IBOutlet UIButton *leve2Orb2;
@property (weak, nonatomic) IBOutlet UIButton *leve2Orb3;
@property (weak, nonatomic) IBOutlet UIButton *leve3Orb1;
@property (weak, nonatomic) IBOutlet UIButton *leve3Orb2;
@property (weak, nonatomic) IBOutlet UIButton *leve3Orb3;


@property(nonatomic) AVAudioPlayer *audio;

@end
