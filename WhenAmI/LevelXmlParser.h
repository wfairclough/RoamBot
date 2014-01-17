//
//  LevelXmlParser.h
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - Level Delegate for Setup within the GameScene

@protocol LevelSetupDelegate <NSObject>
@optional
- (void) setupLevelNumber:(NSInteger)levelNum;
- (void) setupWorldType:(NSString*)worldType;

- (void) setupPlankWithXPosition:(float)x yPosition:(float)y rotationAngle:(float)roation  powered:(BOOL)powered;
- (void) setupBallWithXPosition:(float)x yPosition:(float)y;

@end


#pragma mark - LevelXmlParser Interface

@interface LevelXmlParser : NSXMLParser <NSXMLParserDelegate>

@property (nonatomic, weak) id <LevelSetupDelegate> setupDelegate;

@end
