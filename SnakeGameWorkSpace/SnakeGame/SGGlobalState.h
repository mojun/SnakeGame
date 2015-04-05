//
//  SGGlobalState.h
//  SnakeGame
//
//  Created by mo jun on 4/5/15.
//  Copyright (c) 2015 kimoworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define GSTATE [SGGlobalState state]
#define Settings [NSUserDefaults standardUserDefaults]

typedef NS_ENUM(NSInteger, MoveDirection) {
    MoveDirectionTop = 0,
    MoveDirectionBottom,
    MoveDirectionLeft,
    MoveDirectionRight
};

@interface SGGlobalState : NSObject

/// 每一节蛇身的大小 正方形
@property (nonatomic, assign) CGFloat blockSize;

/// 刷新动画时间间隔
@property (nonatomic, assign) NSTimeInterval interval;

/// 蛇当前运动的方向
@property (nonatomic, assign) MoveDirection currentDirection;

/// 地图宽度 默认10
@property (nonatomic, assign) NSInteger tileWidth;

/// 地图高度 默认10
@property (nonatomic, assign) NSInteger tileHeight;

/// 关卡
@property (nonatomic, assign) NSInteger level;

- (NSInteger)pieToPassTheGame;

+ (instancetype)state;

@end
