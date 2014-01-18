//
//  WorldsViewController.h
//  WhenAmI
//
//  Created by Kat Butler on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GameLoaderDelegate <NSObject>
@required
- (void) playLevel:(int)level;

@end

@interface WorldsViewController : UIViewController <UIPageViewControllerDataSource, GameLoaderDelegate>

@property (strong, nonatomic) UIPageViewController *pageController;

@end
