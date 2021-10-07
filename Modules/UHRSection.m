// Written by Elisa Silva, 2021-09-02
#import "UHRRender.h"

NSString *dynamicParserHandler(UHRRender * r, id object) {
    NSDictionary<NSString *, id> *dictionary = object;
    NSString *name = [dictionary valueForKey:@"name"];
    NSString *level = [dictionary valueForKey:@"level"];
    BOOL scrollY = [dictionary valueForKey:@"scroll-y"] ? YES : NO;
    
    id inner = [dictionary valueForKey:@"i"];
    if(name == nil) name = @"Unamed section";
    if(level == nil) level = @"h2";
    
    NSString *uuid = [NSString stringWithFormat:@"_%@", [[NSUUID UUID] UUIDString]];
    
    return [r recursiveRenderOf: @{
        @"t":@"section",
        @"id":uuid,
        @"i":@[
            @{
                @"t":level,
                @"i":name
            },
            @{
                @"t":@"button",
                @"i":@"esconder",
                @"onclick": [NSString stringWithFormat:@"if(document.querySelector('#%@ > div').style.display === 'none') { document.querySelector('#%@ > div').style.display = ''; document.querySelector('#%@ > button').innerHTML='esconder'; } else { document.querySelector('#%@ > div').style.display = 'none'; document.querySelector('#%@ > button').innerHTML='expandir'; }", uuid, uuid, uuid, uuid, uuid]
            },
            @{
                @"t":@"div",
                @"i":inner,
                @"style": scrollY ? @"overflow-y: scroll;" : @""
            }
        ]
    }];
}

NSString *dynamicParserRegister(void) {
    return @"section";
}

NSUInteger dynamicParserVersion(void) {
    return 1;
}
