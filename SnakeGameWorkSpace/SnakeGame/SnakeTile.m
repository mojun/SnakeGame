//
//  SnakeTile.m
//  SnakeGame
//
//  Created by mo jun on 4/5/15.
//  Copyright (c) 2015 kimoworks. All rights reserved.
//

#import "SnakeTile.h"
#import "SGGlobalState.h"

@implementation SnakeTile

- (id)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor greenColor];
        self.frame = CGRectMake(-1000, -1000, GSTATE.blockSize, GSTATE.blockSize);
    }
    return self;
}

- (void)setPosition:(SGPosition)position{
    _position = position;
    self.center = CGPointMake((0.5 + position.x) * GSTATE.blockSize, (0.5 + position.y) * GSTATE.blockSize);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
