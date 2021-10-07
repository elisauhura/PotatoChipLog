// Written by Elisa Silva, 2021-09-01
#import "UHRRender.h"

NSString *dynamicParserHandler(UHRRender * r, id object) {
    NSDictionary<NSString *, id> *dictionary = object;
    id ordered = [dictionary valueForKey:@"o"];
    
    NSMutableArray *listContent = [[NSMutableArray alloc] init];
    for(id item in [dictionary valueForKey:@"items"]) {
        [listContent addObject:@{
            @"t":@"li",
            @"i":item
        }];
    }
    
    return [r recursiveRenderOf:@{
        @"t":(ordered==nil?@"ul":@"ol"),
        @"i":listContent
    }];
}

NSString *dynamicParserRegister(void) {
    return @"list";
}

NSUInteger dynamicParserVersion(void) {
    return 1;
}
