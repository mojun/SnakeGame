//
//  GameScene.m
//  SnakeGame
//
//  Created by mo jun on 4/5/15.
//  Copyright (c) 2015 kimoworks. All rights reserved.
//

#import "GameScene.h"
#import "SGGlobalState.h"
#import "SGRunloopTool.h"
#import "SGPosition.h"
#import "NSMutableArray+Additions.h"
#import "SnakeTile.h"
#import "PieTile.h"
#import "Snake.h"

@implementation GameScene {
    NSTimer *_timer;
    
    /// 指向所有的SnakeTile
    __weak NSMutableArray *_tilesArray;
    
    PieTile *_pie;
    
    SGRunloopTool *_tool;
    
    Snake *_snake;
    
    IBOutlet UIButton *startButton;
    
    IBOutlet UIButton *restartButton;
    
    IBOutlet UIButton *pauseButton;
    
    NSInteger _pieNumber;
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self initialize];
}

- (void)initialize{
    
    _pieNumber = 0;
    
    startButton.enabled = YES;
    
    restartButton.enabled = NO;
    
    pauseButton.enabled = NO;
    
    GSTATE.level = 2;
    
}

/// 开始游戏
- (IBAction)startGame:(id)sender{
    
    _pieNumber = 0;
    
    startButton.enabled = NO;
    
    restartButton.enabled = NO;
    
    pauseButton.enabled = YES;
    
    _snake = [[Snake alloc]initWithParentView:self];
    
    _tilesArray = _snake.tiles;
    
    GSTATE.currentDirection = (MoveDirection)ABS((arc4random()) % 4);
    
    [self generatePieAtAvailablePosition];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:GSTATE.interval target:self selector:@selector(update:) userInfo:nil repeats:YES];
    
}

/// 重新开始游戏
- (IBAction)restartGame:(id)sender{
    
    _pieNumber = 0;
    
    startButton.enabled = NO;
    
    restartButton.enabled = NO;
    
    pauseButton.enabled = YES;
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    for (UIView *snakeTile in _tilesArray) {
        [snakeTile removeFromSuperview];
    }
    
    _snake = [[Snake alloc]initWithParentView:self];
    
    _tilesArray = _snake.tiles;
    
    GSTATE.currentDirection = (MoveDirection)ABS((arc4random()) % 4);
    
    [self generatePieAtAvailablePosition];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:GSTATE.interval target:self selector:@selector(update:) userInfo:nil repeats:YES];

}

/// 暂停游戏
- (IBAction)pauseGame:(UIButton *)sender{
    
    if (sender.tag == 0) {
        _timer.fireDate = [NSDate distantFuture];
        sender.tag = 1;
        [sender setTitle:@"Go" forState:UIControlStateNormal];
    } else {
        _timer.fireDate = [NSDate date];
        sender.tag = 0;
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    SnakeTile *headTile = _tilesArray.firstObject;
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    if (GSTATE.currentDirection == MoveDirectionTop || GSTATE.currentDirection == MoveDirectionBottom) {
        GSTATE.currentDirection = location.x < headTile.center.x ? MoveDirectionLeft : MoveDirectionRight;
    } else {
        GSTATE.currentDirection = location.y < headTile.center.y ? MoveDirectionTop : MoveDirectionBottom;
    }
    
}

- (void)update:(NSTimer *)timer{
    
    [_snake move:GSTATE.currentDirection];
    
    /// 检查是否吃到了食物
    if ([self collisionTestWithPie]) {
        
        _pieNumber++;
        
        if (_pieNumber >= [GSTATE pieToPassTheGame]) {
            [self gamePass];
        }
        
        [_snake eat];
        
        [self generatePieAtAvailablePosition];
        
    }
    
    /// 检查是否碰撞到了自己或者墙体
    if ([self collisionTestWithSnakeSelf] || [self collisionTestWithWall]) {
        /// 跪了
        [self gameOver];
    }
}

/// 过关了
- (void)gamePass{
    [_timer invalidate];
    _timer = nil;
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Game Passed" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
    [alert show];
}

/// 跪了
- (void)gameOver{
    
    [_timer invalidate];
    _timer = nil;
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Game Over" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
    [alert show];
    
}

// 是否吃到了食物
- (BOOL)collisionTestWithPie{
    
    SGPosition piePosition = [self pie].position;
    for (SnakeTile *tmpTile in _tilesArray) {
        if (tmpTile.position.x == piePosition.x && tmpTile.position.y == piePosition.y) {
            return YES;
        }
    }
    return NO;
    
}

/// 是否与自己碰撞
- (BOOL)collisionTestWithSnakeSelf{
    
    SnakeTile *headTile = _tilesArray.firstObject;
    for (SnakeTile *tmpTile in _tilesArray) {
        if (tmpTile != headTile &&
            tmpTile.position.x == headTile.position.x &&
            tmpTile.position.y == headTile.position.y)
        {
            return YES;
        }
    }
    
    return NO;
    
}

/// 是否与墙碰撞
- (BOOL)collisionTestWithWall{
    
    for (SnakeTile *tmpTile in _tilesArray) {
        if (tmpTile.position.x >= 0 &&
            tmpTile.position.x < GSTATE.tileWidth &&
            tmpTile.position.y >= 0 &&
            tmpTile.position.y < GSTATE.tileHeight)
        {
            return NO;
        }
    }
    
    return YES;
    
}

- (PieTile *)pie{
    if (_pie == nil) {
        _pie = [PieTile new];
        [self addSubview:_pie];
    }
    return _pie;
}

- (void)generatePieAtAvailablePosition{
    
    _tool = [SGRunloopTool new];
    
    [_tool startTask:^BOOL{
        SGPosition piePosition = SGPositionMake(arc4random() % GSTATE.tileWidth, arc4random() % GSTATE.tileHeight);
        
        //检查随机位置是否合法
        BOOL result = YES;
        for (SnakeTile *tmpTile in _tilesArray) {
            if (tmpTile.position.x == piePosition.x && tmpTile.position.y == piePosition.y) {
                result = NO;
            }
        }
        
        if (result) {
            [self pie].position = piePosition;
        }
        
        return YES;
    } completionBlock:nil];
    
}


#pragma mark -- 绘制网格
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [[UIColor blackColor]setStroke];
    
    // 横向线
    CGFloat blockSize = GSTATE.blockSize;
    for (int i=0; i<=GSTATE.tileHeight; i++) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        bezierPath.lineWidth = 1;
        [bezierPath moveToPoint:CGPointMake(0, i * blockSize)];
        [bezierPath addLineToPoint:CGPointMake(GSTATE.tileWidth * blockSize, i * blockSize)];
        [bezierPath stroke];
    }
    
    // 纵向
    for (int i=0; i<=GSTATE.tileWidth; i++) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        bezierPath.lineWidth = 1;
        [bezierPath moveToPoint:CGPointMake(i * blockSize, 0)];
        [bezierPath addLineToPoint:CGPointMake(i * blockSize, GSTATE.tileHeight * blockSize)];
        [bezierPath stroke];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"index: %d", buttonIndex);
    if (buttonIndex == 0) {
        startButton.enabled = NO;
        restartButton.enabled = YES;
        pauseButton.enabled = NO;
    } else if (buttonIndex == 1) {
        [self restartGame:nil];
    }
}


@end
