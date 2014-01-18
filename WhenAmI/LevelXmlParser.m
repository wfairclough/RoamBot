//
//  LevelXmlParser.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "LevelXmlParser.h"
#import "LevelXmlConstants.h"

#pragma mark - Private Methods

@interface LevelXmlParser()
@property (nonatomic, strong) NSMutableString* currentStringValue;
@end


#pragma mark - Level XML Parser Implementation

@implementation LevelXmlParser


- (id)initWithData:(NSData *)data
{
    self = [super initWithData:data];
    if (self) {
        self.delegate = self;
    }
    
    return self;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:kLevelTag]){
        if ([self.setupDelegate respondsToSelector:@selector (setupLevelNumber:)]) {
            [self.setupDelegate setupLevelNumber:[[attributeDict valueForKey:kValueAttribute] integerValue]];
        }
        
        
    } else if ([elementName isEqualToString:kWorldTag]){
        self.worldTheme = [attributeDict valueForKey:kThemeAttribute];
        if ([self.setupDelegate respondsToSelector:@selector (setupWorldType:)]) {
            [self.setupDelegate setupWorldType:self.worldTheme];
        }
        
    } else if ([elementName isEqualToString:kBallTag]){
        float x = [[attributeDict valueForKey:kXAttribute] floatValue];
        float y = [[attributeDict valueForKey:kYAttribute] floatValue];
        bool isInteractable = [[attributeDict valueForKey:kInteractable] boolValue];
        
        if ([self.setupDelegate respondsToSelector:@selector (setupBallWithXPosition:yPosition:allowInteraction:)]) {
            [self.setupDelegate setupBallWithXPosition:x yPosition:y allowInteraction:isInteractable];
        }
        
    } else if ([elementName isEqualToString:kPlankTag]){
        float x = [[attributeDict valueForKey:kXAttribute] floatValue];
        float y = [[attributeDict valueForKey:kYAttribute] floatValue];
        bool isInteractable = [[attributeDict valueForKey:kInteractable] boolValue];
        float rotation = [[attributeDict valueForKey:kRotationAttribute] floatValue];
        BOOL powered = [[attributeDict valueForKey:kPoweredAttribute] boolValue];
        NSString* theme = ([attributeDict valueForKey:kThemeAttribute] == nil) ? self.worldTheme : [attributeDict valueForKey:kThemeAttribute];
        
        if ([self.setupDelegate respondsToSelector:@selector (setupPlankWithXPosition:yPosition:allowInteraction:rotationAngle:powered:theme:)]) {
            [self.setupDelegate setupPlankWithXPosition:x yPosition:y allowInteraction:isInteractable rotationAngle:rotation powered:powered theme:theme];
        }
        
    } else if ([elementName isEqualToString:kWallTag]){
        float x = [[attributeDict valueForKey:kXAttribute] floatValue];
        float y = [[attributeDict valueForKey:kYAttribute] floatValue];
        bool isInteractable = [[attributeDict valueForKey:kInteractable] boolValue];
        float rotation = [[attributeDict valueForKey:kRotationAttribute] floatValue];
        NSString* theme = ([attributeDict valueForKey:kThemeAttribute] == nil) ? self.worldTheme : [attributeDict valueForKey:kThemeAttribute];
        NSString *imageSize = [attributeDict valueForKey:kImageSize];
        
        if ([self.setupDelegate respondsToSelector:@selector (setupWallWithPosition:yPosition:allowInteraction:rotation:theme:imageSize:)]) {
            [self.setupDelegate setupWallWithPosition:x yPosition:y allowInteraction:isInteractable rotation:rotation theme:theme imageSize:imageSize];
        }
    } else if ([elementName isEqualToString:kCannonTag]){
        float x = [[attributeDict valueForKey:kXAttribute] floatValue];
        float y = [[attributeDict valueForKey:kYAttribute] floatValue];
        float rotation = [[attributeDict valueForKey:kRotationAttribute] floatValue];
        
        if ([self.setupDelegate respondsToSelector:@selector (setupCanonWithXPosition:yPosition:rotationAngle:)]) {
            [self.setupDelegate setupCanonWithXPosition:x yPosition:y rotationAngle:rotation];
        }
        
    } else if ([elementName isEqualToString:kGoalTag]){
        float x = [[attributeDict valueForKey:kXAttribute] floatValue];
        float y = [[attributeDict valueForKey:kYAttribute] floatValue];
        float rotation = [[attributeDict valueForKey:kRotationAttribute] floatValue];
        NSString* theme = ([attributeDict valueForKey:kThemeAttribute] == nil) ? self.worldTheme : [attributeDict valueForKey:kThemeAttribute];
        

        if ([self.setupDelegate respondsToSelector:@selector (setupGoalWithXPosition:yPosition:rotationAngle:theme:)]) {
            [self.setupDelegate setupGoalWithXPosition:x yPosition:y rotationAngle:rotation theme:theme];
        }
    } else if ([elementName isEqualToString:kCollectableTag]){
        float x = [[attributeDict valueForKey:kXAttribute] floatValue];
        float y = [[attributeDict valueForKey:kYAttribute] floatValue];
        NSString* type = [attributeDict valueForKey:kTypeAttribute];
        
        
        if ([self.setupDelegate respondsToSelector:@selector (setupCollectableWithXPosition:yPosition:type:)]) {
            [self.setupDelegate setupCollectableWithXPosition:x yPosition:y type:type];
        }
    }



    [self.currentStringValue setString:@""];
}



-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:kLevelTag]){
        [self.currentStringValue setString:@""];
        return;
    } else if([elementName isEqualToString:kWorldTag]) {
        //        [NSString stringWithString:self.currentStringValue];
        [self.currentStringValue setString:@""];
        return;
    }
}




- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (!self.currentStringValue){
        self.currentStringValue = [[NSMutableString alloc] initWithCapacity:200];
    }
    [self.currentStringValue appendString:string];
}

@end
