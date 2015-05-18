//
//  ViewController.m
//  SnakeGame
//
//  Created by mo jun on 4/5/15.
//  Copyright (c) 2015 kimoworks. All rights reserved.
//

#import "ViewController.h"
#import "GameScene.h"

@interface ViewController (){
    IBOutlet GameScene *_gameScene;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"issue 2");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
