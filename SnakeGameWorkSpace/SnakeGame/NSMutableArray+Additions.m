//
//  NSMutableArray+Additions.m
//  SnakeGame
//
//  Created by mo jun on 4/5/15.
//  Copyright (c) 2015 kimoworks. All rights reserved.
//

#import "NSMutableArray+Additions.h"

@implementation NSMutableArray (Additions)

- (id)pop{
    id tmpObject = self.lastObject;
    [self removeLastObject];
    return tmpObject;
}

- (void)push:(id)object{
    [self addObject:object];
}

@end
