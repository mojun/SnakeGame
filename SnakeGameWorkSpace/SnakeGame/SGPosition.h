//
//  SGPosition.h
//  SnakeGame
//
//  Created by mo jun on 4/5/15.
//  Copyright (c) 2015 kimoworks. All rights reserved.
//

#ifndef SnakeGame_SGPosition_h
#define SnakeGame_SGPosition_h

typedef struct Position{
    NSInteger x;
    NSInteger y;
} SGPosition;

CG_INLINE SGPosition SGPositionMake(NSInteger x, NSInteger y)
{
    SGPosition position;
    position.x = x;
    position.y = y;
    return position;
}

#endif
