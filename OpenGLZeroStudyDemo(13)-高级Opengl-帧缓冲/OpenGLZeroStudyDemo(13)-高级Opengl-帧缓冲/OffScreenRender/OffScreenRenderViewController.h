//
//  DepthTestViewController.h
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseViewController.h"
#import "FrameBufferBindObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface OffScreenRenderViewController : GLBaseViewController
@property (nonatomic ,strong) Shader * frameShader ;
@property (nonatomic ,strong) FrameBufferBindObject * frameBufferBinder ;
@end

NS_ASSUME_NONNULL_END
