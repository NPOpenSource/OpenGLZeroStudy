//
//  VertexDimViewController.h
//  OpenGLZeroStudyDemo(2)
//
//  Created by glodon on 2019/7/11.
//  Copyright © 2019 glodon. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "OpenGLUtilsHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface VertexDimViewController : GLKViewController
@property (nonatomic ,strong) EAGLContext * eagcontext;
@property (nonatomic ,assign) GLuint  program;
@property (nonatomic ,strong) Shader * shader ;
@property (nonatomic ,assign) GLint vertexcolor;
@property (nonatomic ,strong) Vertex * vertex ;
@end

NS_ASSUME_NONNULL_END
