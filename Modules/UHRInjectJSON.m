// Written by Elisa Silva, 2021-09-02
#import "UHRRender.h"

NSString *dynamicParserHandler(UHRRender * r, id object) {
    NSDictionary<NSString *, id> *dictionary = object;
    NSString *path = [dictionary valueForKey:@"s"];
    if(path == nil) return @"Invalid Inject";
    
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    
    id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    return [r recursiveRenderOf:obj];
}

NSString *dynamicParserRegister(void) {
    return @"InjectJSON";
}

NSUInteger dynamicParserVersion(void) {
    return 1;
}
