//
//  YellowViewController.m
//  ZZRouter
//
//  Created by Li,Zizhao on 2020/6/8.
//  Copyright © 2020 Li,Zizhao. All rights reserved.
//

#import "YellowViewController.h"
#import "ZZRouter.h"

@interface YellowViewController ()

@end

@implementation YellowViewController

+ (void)load {
    RouterPath(@"yellow")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    ZZRouter.load(@"zz_replace/red");
}

@end
