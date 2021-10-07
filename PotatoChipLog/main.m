//
//  main.m
//  PotatoChipLog
//
//  Created by Elisa Silva on 06/10/21.
//

#import <Foundation/Foundation.h>
#import "UHRRender.h"

int main(int argc, const char * argv[]) {
    if(argc < 3) {
        fprintf(stderr, "%s\n", "ERR: Pass source folder and target folder path");
        return EXIT_FAILURE;
    }
    
    @autoreleasepool {
        UHRRender *render = [[UHRRender alloc] init];
        
        // Load Modules
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSArray<NSString *> *files = [fileManager contentsOfDirectoryAtPath:@"bin" error:nil];
        for(NSString *item in files) {
            NSString *path = [NSString stringWithFormat:@"%@/%@", @"bin", item];
            BOOL directory;
            if([fileManager fileExistsAtPath:path isDirectory:&directory]) {
                if(!directory && [item hasSuffix:@".dylib"]) {
                    [render addModuleAt:path];
                }
            }
        }
        
        [render renderPagesAt:[NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding]
                           to:[NSString stringWithCString:argv[2] encoding:NSUTF8StringEncoding]];
    }
    return 0;
}
