// Written by Elisa Silva, 2021-09-06
#import "UHRRender.h"

NSString *dynamicParserHandler(UHRRender * r, id object) {
    NSDictionary<NSString *, id> *dictionary = object;
    NSString *folder = [dictionary valueForKey:@"p"];
    
    NSMutableArray *logs = [[NSMutableArray alloc] init];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray<NSString *> *contents = [fileManager contentsOfDirectoryAtPath:folder error:nil];
    for(NSString *item in contents) {
        NSString *path = [NSString stringWithFormat:@"%@/%@", folder, item];
        BOOL directory;
        if([fileManager fileExistsAtPath:path isDirectory:&directory]) {
            if(!directory && [item hasSuffix:@".json"]) {
                NSData *data = [fileManager contentsAtPath:path];
                
                id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                [logs addObjectsFromArray:object];
            }
        }
    }
   
    [logs sortUsingComparator:^(id o1, id o2) {
        return [[o1 valueForKey:@"date"] compare: [o2 valueForKey:@"date"]];
    }];
    
    NSMutableArray *elements = [[NSMutableArray alloc] init];
    NSUInteger totalMinutes = 0;
    
    [elements addObject:[[NSMutableDictionary alloc] init]];
    
    for (NSDictionary *entry in logs) {
        totalMinutes += [(NSNumber *)[entry valueForKey:@"time"] unsignedIntValue];
        [elements addObject:@{
            @"t":@"blockquote",
            @"i":[@[
                @{
                    @"t":@"h4",
                    @"i":[NSString stringWithFormat:@"%@ (%@min) [%@]", entry[@"date"], entry[@"time"], entry[@"topic"]]
                }] arrayByAddingObjectsFromArray:entry[@"content"]]
        }];
    }
    
    [elements[0] setValue:@"h3" forKey:@"t"];
    [elements[0] setValue:[NSString stringWithFormat:@"Minutos trabalhados %lu/28800 (%lu%%)", totalMinutes, totalMinutes/288] forKey:@"i"];
    
    return [r recursiveRenderOf:elements];
    
}

NSString *dynamicParserRegister(void) {
    return @"RenderLog";
}

NSUInteger dynamicParserVersion(void) {
    return 1;
}
