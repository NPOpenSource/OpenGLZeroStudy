//
//  ViewController.m
//  OpenGLZeroStudyDemo(1)
//
//  Created by glodon on 2019/7/9.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"


@interface ViewController ()
@property (nonatomic ,strong)  FirstViewController * first  ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}
-(void)tap{
    FirstViewController * vc =  [[FirstViewController alloc]init];
    [self presentViewController:vc animated:YES completion:^{
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =  CGRectMake(0, 0, 100, 64);
        [vc.view addSubview:button];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"返回" forState:UIControlStateNormal];
    }];
    self.first = vc;
}

-(void)back{
    [self.first  dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}



@end
