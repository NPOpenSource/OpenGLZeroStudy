//
//  DefaultViewController.h
//  OpenGLZeroStudyDemo(15)-高级Opengl-高级数据和高级glsl
//
//  Created by glodon on 2019/9/12.
//  Copyright © 2019 glodon. All rights reserved.
//

#import "GLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DefaultViewController : GLBaseViewController
@property (nonatomic ,strong) Vertex * vertexPostion ;
@property (nonatomic ,strong) Vertex * vertexTexture ;
@property (nonatomic ,strong) TextureUnit * textureUnit0 ;

-(GLKMatrix4)getMVP;
@end

NS_ASSUME_NONNULL_END
