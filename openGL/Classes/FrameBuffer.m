//
//  FrameBuffer.m
//  OpenGLBase
//
//  Created by glodon on 2019/8/28.
//

#import "FrameBuffer.h"

@interface FrameBuffer()
@property (nonatomic, assign) GLuint fbo;
@end

@implementation FrameBuffer

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _customInit];
    }
    return self;
}

-(void)_customInit{
    [self _createFrameBuffer];
}

-(void)bindOffScreenBuffer{
     glBindFramebuffer(GL_FRAMEBUFFER, self.fbo);
}

-(void)bindOffScreenBufferAndSettingBlock:(void(^)(FrameBuffer * frameBuffer))frameBufferSettingBlock{
    glBindFramebuffer(GL_FRAMEBUFFER, self.fbo);
    if (frameBufferSettingBlock) {
        frameBufferSettingBlock(self);
    }
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
}

-(BOOL)check{
    if(glCheckFramebufferStatus(GL_FRAMEBUFFER) == GL_FRAMEBUFFER_COMPLETE){
        NSLog(@"[framebuffer]:ok");
        return YES;
    }
    NSLog(@"[framebuffer]:error");
    return NO;
}

-(void)bindColorAttachmentInTexture:(GLuint) texture{
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, texture, 0);
}

-(void)bingDepthAttachmentInRenderBuffer:(GLint)renderBuffer{
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, renderBuffer);

}

#pragma mark  - private
-(void)_createFrameBuffer{
    glGenFramebuffers(1, &_fbo);
}

-(void)_deleteFrameBuffer{
    glDeleteFramebuffers(1, &_fbo);
}


- (void)dealloc
{
    [self _deleteFrameBuffer];
}
@end
