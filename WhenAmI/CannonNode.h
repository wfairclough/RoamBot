//
//  CanonNode.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-18.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "WorldItemNode.h"

@interface CannonNode : WorldItemNode

+ (id)canonWithPosition:(CGPoint)position rotation:(CGFloat)degrees;

- (void)fire;

@end
