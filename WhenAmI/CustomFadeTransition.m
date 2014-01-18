//
//  CustomFadeTransition.m
//  WhenAmI
//
//  Created by Kat Butler on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "CustomFadeTransition.h"

@implementation CustomFadeTransition

- (void)perform
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionFade;
    
    [[[[[self sourceViewController] view] window] layer] addAnimation:transition
                                                               forKey:kCATransitionFade];
    
    [[self sourceViewController]
     presentViewController:[self destinationViewController]
     animated:NO completion:NULL];
}

@end
