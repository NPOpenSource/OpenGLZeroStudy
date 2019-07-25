//
//  GLBaseViewController.h
//  OpenGLZeroStudyDemo(5)-图形变换
//
//  Created by glodon on 2019/7/24.
//  Copyright © 2019 glodon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "OpenGLUtilsHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface GLBaseViewController : GLKViewController
@property (nonatomic ,strong) EAGLContext * eagcontext;
@property (nonatomic ,assign) GLuint  program;
@property (nonatomic ,strong) Shader * shader ;
@property (nonatomic ,strong) Vertex * vertex ;

-(void)loadVertex;
-(void)createShade;
@end

NS_ASSUME_NONNULL_END
