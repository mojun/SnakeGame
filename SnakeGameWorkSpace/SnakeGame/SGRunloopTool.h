//
//  SGRunloopTool.h
//  SnakeGame
//
//  Created by mo jun on 4/5/15.
//  Copyright (c) 2015 kimoworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGRunloopTool : NSObject

/*
 *  @brief 多线程任务管工具
 *
 *  @param taskBlock 任务block 如果返回YES 说明任务完成执行completion，如果为NO继续完成该任务
 *  @param (void (^)(BOOL success))completion success=YES 任务完成，success=NO 任务被用户取消
 */

- (void)startTask:(BOOL (^)(void))taskBlock
  completionBlock:(void (^)(BOOL success))completion;

/*  @brief 取消任务
 */
- (void)stop;

@end
