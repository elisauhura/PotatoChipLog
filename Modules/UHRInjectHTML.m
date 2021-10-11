//
//  UHRInjectHTML.m
//  UHRRenderModuleInjectUMD
//
//  Created by Elisa Silva on 11/10/21.
//  Copyright © 2021 Uhura. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UHRRender.h"

NSString *dynamicParserHandler(UHRRender * r, id object) {
    NSDictionary<NSString *, id> *dictionary = object;
    NSString *path = [dictionary valueForKey:@"s"];
    if(path == nil) return @"Invalid Inject";
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    if(data == nil) {
        return @"<p>Error reading file</p>";
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

NSString *dynamicParserRegister(void) {
    return @"InjectHTML";
}

NSUInteger dynamicParserVersion(void) {
    return 1;
}
