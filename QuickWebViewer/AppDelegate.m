//
//  AppDelegate.m
//  QuickWebViewer
//
//  Created by Elisa Silva on 20/10/21.
//  Copyright © 2021 Uhura. All rights reserved.
//

#import "AppDelegate.h"
#import <WebKit/WebKit.h>

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;
@property (weak) IBOutlet WKWebView *webView;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0);
    dispatch_async(backgroundQueue, ^void{
        char file[512];
        char *ref = file + 0;
        while(1) {
            fgets(file, 512, stdin);
            if(strlen(file) < 5) {
                dispatch_sync(dispatch_get_main_queue(), ^void{
                    [[NSApplication sharedApplication] terminate:nil];
                });
            }
            dispatch_sync(dispatch_get_main_queue(), ^void{
                NSString *path = [[NSString stringWithCString:ref
                                                     encoding:NSUTF8StringEncoding]
                                  stringByTrimmingCharactersInSet:NSCharacterSet.newlineCharacterSet];
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", path]];
                [self.webView loadFileURL:url allowingReadAccessToURL:[url URLByDeletingLastPathComponent]];
                NSLog(@"Loaded file: %@", path);
            });
        }
    });
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}


@end
