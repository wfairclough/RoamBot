//
//  LevelXmlWriter.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameSpriteNode.h"


@interface LevelXmlWriter : NSObject

@property (nonatomic, strong) NSString *xmlContent;
@property (nonatomic, strong) NSString *fileName;

- (void) startXmlWithLevel:(int)level;
- (void) addXmlTagWithGameNode:(GameSpriteNode *)node;
- (void) endXml;

@end
