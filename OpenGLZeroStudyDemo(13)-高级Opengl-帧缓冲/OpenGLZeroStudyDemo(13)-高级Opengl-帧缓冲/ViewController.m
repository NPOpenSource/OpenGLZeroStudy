//
//  ViewController.m
//  OpenGLZeroStudyDemo(13)-高级Opengl-帧缓冲
//
//  Created by glodon on 2019/8/28.
//  Copyright © 2019 openSource. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic ,strong) UIViewController * tapVc;
@end

@implementation ViewController

-(NSArray *)buttonTitles{
    return @[@[@"离屏渲染",@"OffScreenRenderViewController"],@[@"默认渲染方式",@"DefaultRenderViewController"],@[@"效果反向",@"OppositionOffScreenRenderViewController"],@[@"灰度",@"GrayscaleOffScreenRenderViewController"],@[@"核效果",@"KernelSharpenViewController"],@[@"核效果模糊",@"KernelBlurViewController"],@[@"和效果边缘检测",@"KernelEdgeDetectionViewController"]];
}

-(UIButton *)buttonCreate{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor redColor]];
    return button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * array = [self buttonTitles];
    for (int i =0; i<array.count; i++) {
        UIButton * bt = [self buttonCreate];
        bt.tag = i;
        [bt setTitle:array[i][0] forState:UIControlStateNormal];
        [self.view addSubview:bt];
        bt.titleLabel.font =[UIFont systemFontOfSize:12];
        bt.frame = CGRectMake(0+i%3*100, 100+i/3*60, 80, 50);
    }
    
}
-(void)tap:(UIButton *)button{
    NSArray * vcArr = [self buttonTitles][button.tag];
    UIViewController * vc =[[NSClassFromString(vcArr[1]) alloc]init];
    UINavigationController * nv = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nv animated:YES completion:^{
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =  CGRectMake(0, 0, 100, 64);
        UIBarButtonItem *myBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
        vc.navigationItem.rightBarButtonItem = myBtn;
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    }];
    self.tapVc = nv;
}

-(void)back{
    [self.tapVc  dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

@end

