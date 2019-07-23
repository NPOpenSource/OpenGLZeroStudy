//
//  Texture.h
//  OpenGLUtils
//
//  Created by glodon on 2019/7/17.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface TextureUnit : NSObject

-(void)setImage:(UIImage *)image IntoTextureUnit:(GLenum)textureUnit andConfigTextureUnit:(nullable  void(^)(void))configTextureUnitBlock ;
-(void)bindtextureUnitLocationAndShaderUniformSamplerLocation:(GLint) uniformSamplerLocation;
-(void)setPixels: (float*) pixels pixelsWidth:(GLsizei)width pixelsHeight:(GLsizei)height IntoTextureUnit:(GLenum)textureUnit andConfigTextureUnit:(nullable void(^)(void))configTextureUnitBlock PixelFormat:(GLint)internalformat;
@end

NS_ASSUME_NONNULL_END
