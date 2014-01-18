//
//  PlankNode.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "WorldItemNode.h"

@interface PlankNode : WorldItemNode
+ (id)plankWithPosition:(CGPoint)position rotation:(CGFloat)degrees power:(BOOL)isPowered;
@end
