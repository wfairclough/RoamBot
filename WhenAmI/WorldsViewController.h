//
//  WorldsViewController.h
//  WhenAmI
//
//  Created by Kat Butler on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorldsViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;

@end
