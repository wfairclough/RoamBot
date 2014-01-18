//
//  LevelXmlWriter.m
//  WhenAmI
//
//  Created by Will Fairclough on 2014-01-17.
//  Copyright (c) 2014 Chicken Waffle. All rights reserved.
//

#import "LevelXmlWriter.h"

@implementation LevelXmlWriter

- (void) startXmlWithLevel:(int)level {
    //make a file name to write the data to using the documents directory:
    self.fileName = [NSString stringWithFormat:@"%@/level_%02d.xml", [self documentDirectory], level];
    
    [self.xmlContent appendString:@"<?xml version=\"1.0\"?>"];
    [self.xmlContent appendString:@"\t<level value='1'>"];
    [self.xmlContent appendString:@"\t\t<world type='rome'>"];
    
    NSLog(@"%@\nStart XML Tag", self.fileName);
}


- (void) addXmlTagWithGameNode:(GameSpriteNode *)node {
    
    [self.xmlContent appendString:[NSString stringWithFormat:@"\t%@", node.xmlTag]];
    
    NSLog(@"ADD: %@", node.xmlTag);
}


- (void) endXml {

    NSLog(@"End XML Tag");
    
    [self.xmlContent appendString:@"\t\t</world>"];
    [self.xmlContent appendString:@"\t</level>"];
    
    NSError* error = nil;
    
    NSString* content = [NSString stringWithFormat:@"%@", self.xmlContent];
    [content writeToFile:self.fileName
              atomically:YES
                encoding:NSUTF8StringEncoding
                   error:&error];
    
    if (error != nil) {
        NSLog(@"ERROR: %@", error);
    }
}

-(NSString *)documentDirectory{
    [NSFileManager defaultManager];
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

@end
