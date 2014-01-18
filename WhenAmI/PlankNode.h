//
//  PlankNode.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "WorldItemNode.h"

@interface PlankNode : WorldItemNode

@property BOOL isPowered;
@property (nonatomic, strong) NSString *theme;

+ (id)plankWithPosition:(CGPoint)position allowInteraction:(BOOL)isInteractable rotation:(CGFloat)degrees power:(BOOL)isPowered theme:(NSString*)levelStyle;
@end
