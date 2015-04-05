//
//  Snake.h
//  SnakeGame
//
//  Created by mo jun on 4/5/15.
//  Copyright (c) 2015 kimoworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGGlobalState.h"

@interface Snake : NSObject

@property (nonatomic, strong) NSMutableArray *tiles;

- (id)initWithParentView:(UIView *)view;

- (void)eat;

- (void)move:(MoveDirection)direction;

@end
