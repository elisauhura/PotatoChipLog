// Written by Elisa Silva, 2021-09-06
#import "UHRRender.h"

NSString *dynamicParserHandler(UHRRender * r, id object) {
    NSDictionary<NSString *, id> *dictionary = object;
    NSString *path = [dictionary valueForKey:@"s"];
    if(path == nil) return @"Invalid Inject";
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for(NSDictionary *dic in obj) {
        NSMutableArray *inner = [[NSMutableArray alloc] init];
        
        [inner addObject:@{
            @"t":@"td",
            @"i":[dic valueForKey:@"n"]
        }];
        
        [inner addObject:@{
            @"t":@"td",
            @"i":[dic valueForKey:@"s"]
        }];
        
        for(NSNumber *n in [dic valueForKey:@"c"]) {
            [inner addObject:@{
                @"t":@"td",
                @"i":[[n stringValue] compare: @"0"] == NSOrderedSame ? @"" : [n stringValue],
                @"class":[NSString stringWithFormat:@"_%@", [n stringValue]]
            }];
        }
        
        [arr addObject:@{
            @"t":@"tr",
            @"i":inner
        }];
    }
    
    NSDictionary *template = @{
        @"t":@"table",
        @"i":@[
            @{
                @"t":@"thead",
                @"i":@[
                    @{
                        @"t":@"tr",
                        @"i":@"<td rowspan=\"2\">Tarefa</td><td rowspan=\"2\">Status</td><td colspan=\"13\">Mês</td>"
                    },
                    @{
                        @"t":@"tr",
                        @"i":@"<td>jan</td><td>fev</td><td>mar</td><td>abr</td><td>mai</td><td>jun</td><td>jul</td><td>ago</td><td>set</td><td>out</td><td>nov</td><td>dez</td>"
                    }
                ]
            },
            @{
                @"t":@"tbody",
                @"i":[r recursiveRenderOf:arr]
            }
        ]
    };
    
    
    
    return [r recursiveRenderOf:template];
    
}

NSString *dynamicParserRegister(void) {
    return @"cronograma";
}

NSUInteger dynamicParserVersion(void) {
    return 1;
}
