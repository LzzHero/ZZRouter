//
//  ViewController.m
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/4.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import "ViewController.h"
#import "ZZRouter.h"

@interface ViewController ()

@end

@implementation ViewController

+ (void)load {
    RouterPath(@"main")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

 
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    ZZRouter.load(@"red",@{@"name":@"jack"});
    ZZRouter.load(@"red/blue/yellow");
}


@end
