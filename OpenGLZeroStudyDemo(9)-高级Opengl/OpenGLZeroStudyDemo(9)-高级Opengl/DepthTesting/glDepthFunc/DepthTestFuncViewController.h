//
//  DepthTestFuncViewController.h
//  OpenGLZeroStudyDemo(9)-高级Opengl
//
//  Created by glodon on 2019/8/20.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DepthTestFuncViewController : GLBaseViewController
@property (nonatomic ,strong) void(^glDrawConfig)(void) ;
@property (nonatomic ,strong) void(^glDrawMaskBeginConfig)(void) ;
@property (nonatomic ,strong) void(^glDrawMaskEndConfig)(void) ;

@end

NS_ASSUME_NONNULL_END
