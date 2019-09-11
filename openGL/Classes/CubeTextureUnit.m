//
//  CubeTextureUnit.m
//  OpenGLBase
//
//  Created by glodon on 2019/8/30.
//

#import "CubeTextureUnit.h"

@interface CubeTextureUnit ()

@end

@implementation CubeTextureUnit
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _customInit];
    }
    return self;
}

-(void)_customInit{
    [self _createCubeTextureBuffer];
}

-(void)bindCubeTexture{
    glBindTexture(GL_TEXTURE_CUBE_MAP, self.textureID);
}

-(void)bindCubeTextureInImageArray:(NSArray *)imageArr{
    if (imageArr.count!=6) {
        NSLog(@"[cubeTexture]: image 数量错误");
        return;
    }
    [self bindCubeTexture];
    for (unsigned int i = 0; i < imageArr.count; i++)
    {
        UIImage * image = imageArr[i];
        GLubyte *imageData = [self _getImageData:imageArr[i]];
        glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_X+i, 0, GL_RGBA , image.size.width, image.size.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
    }
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
}


#pragma mark  - private
-(void)_createCubeTextureBuffer{
    glGenTextures(1, &_textureID);
}

-(void)_deleteCubeTextureBuffer{
    glDeleteTextures(1, &_textureID);
}

- (void*)_getImageData:(UIImage*)image{
    CGImageRef imageRef = [image CGImage];
    size_t imageWidth = CGImageGetWidth(imageRef);
    size_t imageHeight = CGImageGetHeight(imageRef);
    GLubyte *imageData = (GLubyte *)malloc(imageWidth*imageHeight*4);
    memset(imageData, 0,imageWidth *imageHeight*4);
    CGContextRef imageContextRef = CGBitmapContextCreate(imageData, imageWidth, imageHeight, 8, imageWidth*4, CGImageGetColorSpace(imageRef), kCGImageAlphaPremultipliedLast);
//    CGContextTranslateCTM(imageContextRef, 0, imageHeight);
//    CGContextScaleCTM(imageContextRef, 1.0, -1.0);
    CGContextDrawImage(imageContextRef, CGRectMake(0.0, 0.0, (CGFloat)imageWidth, (CGFloat)imageHeight), imageRef);
    CGContextRelease(imageContextRef);
    return  imageData;
}


- (void)dealloc
{
    [self _deleteCubeTextureBuffer];
}
@end
