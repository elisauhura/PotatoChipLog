// Written by Elisa Silva, 2021-09-01
#pragma once

#import <Foundation/Foundation.h>

typedef void * (^Pair) (BOOL);

@interface UHRRender: NSObject

@property NSString *skeletonExtension;
@property NSMutableDictionary<NSString *, Pair> *symbols;
@property NSSet<NSString *> *selfClosingTags;

- (void)addModuleAt:(NSString *)path;
- (void)renderPagesAt:(NSString *)folder to:(NSString *)renderedFolder;
- (NSString *)recursiveRenderOf:(id)object;
- (void)dealloc;

@end

typedef NSString *DynamicParserHandler(UHRRender * r, id object);
typedef NSString *DynamicParserRegister(void);
typedef NSUInteger DynamicParserVersion(void);
