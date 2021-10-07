// Written by Elisa Silva, 2021-09-02
#import "UHRRender.h"

NSString *dynamicParserHandler(UHRRender * r, id object) {
    NSDictionary<NSString *, id> *dictionary = object;
    NSString *path = [dictionary valueForKey:@"s"];
    if(path == nil) return @"Invalid Inject";
    return [NSString stringWithFormat:@"<style>\n%@\n</style>", [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil]];
    
}

NSString *dynamicParserRegister(void) {
    return @"InjectCSS";
}

NSUInteger dynamicParserVersion(void) {
    return 1;
}
