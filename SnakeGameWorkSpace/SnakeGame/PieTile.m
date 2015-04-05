//
//  PieTile.m
//  SnakeGame
//
//  Created by mo jun on 4/5/15.
//  Copyright (c) 2015 kimoworks. All rights reserved.
//

#import "PieTile.h"
#import "SGGlobalState.h"

@implementation PieTile

- (id)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        self.frame = CGRectMake(-1000, -1000, GSTATE.blockSize, GSTATE.blockSize);
    }
    return self;
}

- (void)setPosition:(SGPosition)position{
    _position = position;
    self.center = CGPointMake((0.5 + position.x) * GSTATE.blockSize, (0.5 + position.y) * GSTATE.blockSize);
}

@end
