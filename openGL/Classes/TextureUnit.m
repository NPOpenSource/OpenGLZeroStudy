//
//  Texture.m
//  OpenGLUtils
//
//  Created by glodon on 2019/7/17.
//

#import "TextureUnit.h"

@interface TextureUnit ()
@property (nonatomic, assign) GLuint textureBuffer;
@property (nonatomic ,assign) int textureUnitLocation ;
@end

@implementation TextureUnit
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _customInit];
    }
    return self;
}
-(void)_customInit{
    self.textureUnitLocation = -1;
    glGenTextures(1, &_textureBuffer);
}

#pragma mark  - public
-(void)setPixels: (float*) pixels pixelsWidth:(GLsizei)width pixelsHeight:(GLsizei)height IntoTextureUnit:(GLenum)textureUnit andConfigTextureUnit:(nullable void(^)(void))configTextureUnitBlock PixelFormat:(GLint)internalformat{
    glActiveTexture(textureUnit);
    self.textureUnitLocation = [self _getTextureBindLocationForTexture:textureUnit];
    glBindTexture(GL_TEXTURE_2D,  _textureBuffer);
     glTexImage2D(GL_TEXTURE_2D, 0, internalformat , width, height, 0, internalformat, GL_FLOAT, pixels);
    if (configTextureUnitBlock) {
        configTextureUnitBlock();
    }else{
      [self _textureBaseConfig];
    }
}

-(void)setImage:(UIImage *)image IntoTextureUnit:(GLenum)textureUnit andConfigTextureUnit:(nullable void(^)(void))configTextureUnitBlock  {
    [self setImage:image IntoTextureUnit:textureUnit andConfigTextureUnit:configTextureUnitBlock PixelFormat:GL_RGBA];
}
-(void)setImage:(UIImage *)image IntoTextureUnit:(GLenum)textureUnit andConfigTextureUnit:(void(^)(void))configTextureUnitBlock  PixelFormat:(GLint)internalformat{
    glActiveTexture(textureUnit);
    self.textureUnitLocation = [self _getTextureBindLocationForTexture:textureUnit];
    glBindTexture(GL_TEXTURE_2D,  _textureBuffer);
 
    GLubyte *imageData = [self _getImageData:image];
    glTexImage2D(GL_TEXTURE_2D, 0, internalformat , image.size.width, image.size.height, 0, internalformat, GL_UNSIGNED_BYTE, imageData);
    free(imageData);
    if (configTextureUnitBlock) {
        configTextureUnitBlock();
    }else{
        [self _textureBaseConfig];
    }
}

-(void)bindtextureUnitLocationAndShaderUniformSamplerLocation:(GLint) uniformSamplerLocation {
    if (self.textureUnitLocation == -1) {
        NSLog(@"没有设置纹理单元或者设置纹理单元错误");
        return;
    }
    glUniform1i(uniformSamplerLocation, self.textureUnitLocation);
}

#pragma mark  - private
-(int)_getTextureBindLocationForTexture:(GLenum)texture{
    int textureLocation = texture-GL_TEXTURE0;
    if (textureLocation>=0 && textureLocation <32) {
        return textureLocation;
    }
    NSLog(@"超出纹理单元");
    return -1;
}
-(void)_textureBaseConfig{
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST_MIPMAP_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
}

- (void*)_getImageData:(UIImage*)image{
    CGImageRef imageRef = [image CGImage];
    size_t imageWidth = CGImageGetWidth(imageRef);
    size_t imageHeight = CGImageGetHeight(imageRef);
    GLubyte *imageData = (GLubyte *)malloc(imageWidth*imageHeight*4);
    memset(imageData, 0,imageWidth *imageHeight*4);
    CGContextRef imageContextRef = CGBitmapContextCreate(imageData, imageWidth, imageHeight, 8, imageWidth*4, CGImageGetColorSpace(imageRef), kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(imageContextRef, 0, imageHeight);
    CGContextScaleCTM(imageContextRef, 1.0, -1.0);
    CGContextDrawImage(imageContextRef, CGRectMake(0.0, 0.0, (CGFloat)imageWidth, (CGFloat)imageHeight), imageRef);
    CGContextRelease(imageContextRef);
    return  imageData;
}

@end
