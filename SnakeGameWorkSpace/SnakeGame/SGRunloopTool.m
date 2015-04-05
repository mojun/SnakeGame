//
//  SGRunloopTool.m
//  SnakeGame
//
//  Created by mo jun on 4/5/15.
//  Copyright (c) 2015 kimoworks. All rights reserved.
//

#import "SGRunloopTool.h"

@implementation SGRunloopTool{
    BOOL isRunning;
}

- (void)startTask:(BOOL (^)(void))taskBlock
  completionBlock:(void (^)(BOOL success))completion{
    if (!taskBlock) {
        return;
    }
    
    isRunning = YES;
    while (!taskBlock() && isRunning) {
        [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    if (completion) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(isRunning);
        });
    }
}

- (void)stop{
    isRunning = NO;
}

@end
