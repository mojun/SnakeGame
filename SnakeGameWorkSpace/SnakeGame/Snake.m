//
//  Snake.m
//  SnakeGame
//
//  Created by mo jun on 4/5/15.
//  Copyright (c) 2015 kimoworks. All rights reserved.
//

#import "Snake.h"
#import "SnakeTile.h"
#import "NSMutableArray+Additions.h"
#import "SGRunloopTool.h"

@implementation Snake{
    
    __weak UIView *_parentView;
    
    SGRunloopTool *_tool;
    
    MoveDirection _direction;
    
}

- (id)initWithParentView:(UIView *)view{
    if (self = [super init]) {
        
        _parentView = view;
        
        self.tiles = [NSMutableArray array];
        
        SnakeTile *tile = [SnakeTile new];
        tile.position = SGPositionMake(5, 5);
        [self.tiles push:tile];
        [_parentView addSubview:tile];
        
    }
    return self;
}

- (void)eat{
    
    SnakeTile *lastTile = [self.tiles lastObject];
    SnakeTile *newTile = [SnakeTile new];
    [self.tiles push:newTile];
    [_parentView addSubview:newTile];
    
    _tool = [SGRunloopTool new];
    if (self.tiles.count <= 1) {
        [_tool startTask:^BOOL{
            SGPosition newPosition = lastTile.position;
            if (_direction == MoveDirectionLeft) {
                switch (arc4random() % 3) {
                    case 0:
                        newPosition.x += 1;
                        break;
                    case 1:
                        newPosition.y += 1;
                        break;
                    case 2:
                        newPosition.y -= 1;
                        break;
                    default:
                        break;
                }
            } else if (_direction == MoveDirectionRight) {
                switch (arc4random() % 3) {
                    case 0:
                        newPosition.x -= 1;
                        break;
                    case 1:
                        newPosition.y += 1;
                        break;
                    case 2:
                        newPosition.y -= 1;
                        break;
                    default:
                        break;
                }
            } else if (_direction == MoveDirectionTop) {
                switch (arc4random() % 3) {
                    case 0:
                        newPosition.x += 1;
                        break;
                    case 1:
                        newPosition.x -= 1;
                        break;
                    case 2:
                        newPosition.y += 1;
                        break;
                    default:
                        break;
                }
            } else {
                switch (arc4random() % 3) {
                    case 0:
                        newPosition.x += 1;
                        break;
                    case 1:
                        newPosition.x -= 1;
                        break;
                    case 2:
                        newPosition.y -= 1;
                        break;
                    default:
                        break;
                }
            }
            
            BOOL result = YES;
            for (SnakeTile *tmpTile in self.tiles) {
                if ((tmpTile.position.x == newPosition.x && tmpTile.position.y == newPosition.y) ||
                    newPosition.x < 0 || newPosition.y < 0 || newPosition.x > GSTATE.tileWidth - 1 || newPosition.y > GSTATE.tileHeight) {
                    result = NO;
                }
            }
            
            if (result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    newTile.position = newPosition;
                });
            }
            
            return result;
        } completionBlock:nil];
    } else {
        [_tool startTask:^BOOL{
            SGPosition newPosition = lastTile.position;
            
            switch (arc4random() % 4) {
                case 0:
                    newPosition.x += 1;
                    break;
                case 1:
                    newPosition.x -= 1;
                    break;
                case 2:
                    newPosition.y += 1;
                    break;
                case 3:
                    newPosition.y -= 1;
                    break;
                default:
                    break;
            }
            
            BOOL result = YES;
            for (SnakeTile *tmpTile in self.tiles) {
                if ((tmpTile.position.x == newPosition.x && tmpTile.position.y == newPosition.y) ||
                    newPosition.x < 0 || newPosition.y < 0 || newPosition.x > GSTATE.tileWidth - 1 || newPosition.y > GSTATE.tileHeight) {
                    result = NO;
                }
            }
            
            if (result) {
                newTile.position = newPosition;
            }
            
            return result;
        } completionBlock:nil];
    }
}

- (void)move:(MoveDirection)direction{
    _direction = direction;
    SnakeTile *lastTile = [self.tiles lastObject];
    SnakeTile *firstTile = [self.tiles firstObject];
    [self.tiles removeLastObject];
    [self.tiles insertObject:lastTile atIndex:0];
    switch (direction) {
        case MoveDirectionLeft:
            lastTile.position = SGPositionMake(firstTile.position.x - 1, firstTile.position.y);
            break;
        case MoveDirectionRight:
            lastTile.position = SGPositionMake(firstTile.position.x + 1, firstTile.position.y);
            break;
        case MoveDirectionBottom:
            lastTile.position = SGPositionMake(firstTile.position.x, firstTile.position.y + 1);
            break;
        case MoveDirectionTop:
            lastTile.position = SGPositionMake(firstTile.position.x, firstTile.position.y - 1);
            break;
        default:
            break;
    }
}

@end
