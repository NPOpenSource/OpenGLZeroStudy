//
//  TextureBaseViewController.m
//  OpenGLZeroStudyDemo(4)
//
//  Created by glodon on 2019/7/23.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "TextureBaseViewController.h"

@interface TextureBaseViewController ()

@end

@implementation TextureBaseViewController

-(NSArray *)buttonTitles{
    return @[@[@"GL_REPEAT",@"RepeatViewController"],@[@"GL_MIRRORED_REPEAT",@"MIRROREDREPEATViewController"],@[@"GL_CLAMP_TO_EDGE",@"CLAMPTOEDGEViewController"]];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
