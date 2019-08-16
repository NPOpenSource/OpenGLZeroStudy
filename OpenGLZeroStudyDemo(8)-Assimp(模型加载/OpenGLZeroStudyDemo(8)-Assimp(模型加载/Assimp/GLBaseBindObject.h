//
//  GLBaseBindObject.h
//  OpenGLZeroStudyDemo(6)-粒子效果
//
//  Created by glodon on 2019/7/29.
//  Copyright © 2019 glodon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>



#define uniformsMaxCount 100

NS_ASSUME_NONNULL_BEGIN

@interface GLBaseBindObject : NSObject
{
    @public
     GLint uniforms[uniformsMaxCount];
}

-(void)BindAttribLocation:(GLuint) program;
-(void)setUniformLocation:(GLuint)program;
-(NSString *)getShaderName;



@end

NS_ASSUME_NONNULL_END
