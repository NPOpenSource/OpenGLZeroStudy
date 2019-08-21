//
//  DepthTestManagerViewController.m
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "DepthTestManagerViewController.h"

@interface DepthTestManagerViewController ()
@property (nonatomic ,strong) UIViewController * tapVc;
@end

@implementation DepthTestManagerViewController

-(NSArray *)buttonTitles{
    return @[@[@"关闭深度测试",@"DepthTestColseViewController"],
  @[@"开启深度测试",@"DepthTestOpenViewController"],@[@"未开启深度测试",@"DepthTestMaskCloseDTViewController"],@[@"开启深度测试没设置mask",@"DepthTestMaskOpenDTViewController"],@[@"glDepthMask(false)",@"DepthTestCloseMaskOpenDTViewController"],@[@"GL_ALWAYS",@"DepthTestAlwaysViewController"],@[@"GL_NEVER",@"DepthTestFuncNeverViewController"],@[@"GL_LESS",@"DepthTestFuncLessViewController"],@[@"GL_EQUAL",@"DepthTestFuncEqualViewController"],@[@"GL_LEQUAL",@"DepthTestLequalViewController"],@[@"GL_GREATER",@"DepthTestGreaterViewController"],@[@"GL_NOTEQUAL",@"DepthTestNotequalViewController"],@[@"GL_GEQUAL",@"DepthTestGequalViewController"],@[@"深度可视化",@"DepthTestViewController"]];
}

-(UIButton *)buttonCreate{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor redColor]];
    return button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray * array = [self buttonTitles];
    for (int i =0; i<array.count; i++) {
        UIButton * bt = [self buttonCreate];
        bt.tag = i;
        [bt setTitle:array[i][0] forState:UIControlStateNormal];
        [self.view addSubview:bt];
        bt.titleLabel.font =[UIFont systemFontOfSize:12];
        bt.titleLabel.numberOfLines = 0;
        bt.frame = CGRectMake(0+i%3*110, 110+i/3*60, 100, 50);
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


