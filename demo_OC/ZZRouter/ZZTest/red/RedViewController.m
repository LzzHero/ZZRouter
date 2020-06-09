//
//  RedViewController.m
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/8.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import "RedViewController.h"
#import "ZZRouter.h"

@interface RedViewController ()

@end

@implementation RedViewController

+ (void)load {
    RouterPath(@"red")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ZZRouter.load(@"blue");
}

@end
