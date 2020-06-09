//
//  BlueViewController.m
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/8.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import "BlueViewController.h"
#import "ZZRouter.h"

@interface BlueViewController ()

@end

@implementation BlueViewController

+ (void)load {
    RouterPath(@"blue")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ZZRouter.load(@"yellow");
}


@end
