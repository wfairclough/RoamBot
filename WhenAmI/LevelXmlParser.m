//
//  LevelXmlParser.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "LevelXmlParser.h"


#define kLevelTag @"level"
#define kWorldTag @"world"
#define kValueAttribute @"value"
#define kTypeAttribute @"type"
#define kXAttribute @"x"
#define kYAttribute @"y"
#define kRotationAttribute @"rotation"
#define kPoweredAttribute @"powered"

#define kBallTag @"ball"
#define kPlankTag @"plank"
#define kWallTag @"wall"


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
        if ([self.setupDelegate respondsToSelector:@selector (setupWorldType:)]) {
            [self.setupDelegate setupWorldType:[attributeDict valueForKey:kTypeAttribute]];
        }
        
    } else if ([elementName isEqualToString:kBallTag]){
        float x = [[attributeDict valueForKey:kXAttribute] floatValue];
        float y = [[attributeDict valueForKey:kYAttribute] floatValue];
        
        if ([self.setupDelegate respondsToSelector:@selector (setupBallWithXPosition:yPosition:)]) {
            [self.setupDelegate setupBallWithXPosition:x yPosition:y];
        }
        
    } else if ([elementName isEqualToString:kPlankTag]){
        float x = [[attributeDict valueForKey:kXAttribute] floatValue];
        float y = [[attributeDict valueForKey:kYAttribute] floatValue];
        float rotation = [[attributeDict valueForKey:kRotationAttribute] floatValue];
        BOOL powered = [[attributeDict valueForKey:kPoweredAttribute] boolValue];
        
        if ([self.setupDelegate respondsToSelector:@selector (setupPlankWithXPosition:yPosition:rotationAngle:powered:)]) {
            [self.setupDelegate setupPlankWithXPosition:x yPosition:y rotationAngle:rotation powered:powered];
        }
        
    } else if ([elementName isEqualToString:kWallTag]){
        float x = [[attributeDict valueForKey:kXAttribute] floatValue];
        float y = [[attributeDict valueForKey:kYAttribute] floatValue];
        int type = [[attributeDict valueForKey:kTypeAttribute] floatValue];
        float rotation = [[attributeDict valueForKey:kRotationAttribute] floatValue];
        
        if ([self.setupDelegate respondsToSelector:@selector (setupWallWithXPosition:yPosition:rotationAngle:type:)]) {
            [self.setupDelegate setupWallWithXPosition:x yPosition:y rotationAngle:rotation type:type];
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
