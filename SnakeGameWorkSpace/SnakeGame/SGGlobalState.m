//
//  SGGlobalState.m
//  SnakeGame
//
//  Created by mo jun on 4/5/15.
//  Copyright (c) 2015 kimoworks. All rights reserved.
//

#import "SGGlobalState.h"

@implementation SGGlobalState

+ (instancetype)state{
    static SGGlobalState *state = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        state = [[SGGlobalState alloc]init];
    });
    return state;
}

- (id)init{
    if (self = [super init]) {
        
        self.blockSize = 20;
        
        self.interval = 1;
        
        self.tileHeight = 10;
        
        self.tileWidth = 10;
        
        self.level = 1;
        
    }
    return self;
}

- (NSInteger)pieToPassTheGame{
    switch (self.level) {
        case 1:
            return 10;
        case 2:
            return 20;
        case 3:
            return 30;
        default:
            break;
    }
    return 10;
}

@end
