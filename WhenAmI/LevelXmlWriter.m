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
    
    self.xmlContent = @"<?xml version=\"1.0\"?>\n<level value='1'>\n\t<world type='rome'>\n";
    
    NSLog(@"%@\nStart XML Tag", self.fileName);
}


- (void) addXmlTagWithGameNode:(GameSpriteNode *)node {
    
    self.xmlContent = [NSString stringWithFormat:@"%@\t\t%@\n", self.xmlContent, [node gameNodeXml]];
}


- (void) endXml {

    NSLog(@"End XML Tag");
    
    self.xmlContent = [NSString stringWithFormat:@"%@%@", self.xmlContent, @"\t</world>\n</level>\n"];
    
    NSError* error = nil;
    
    [self.xmlContent writeToFile:self.fileName
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
