//
//  RenderBuffer.m
//  OpenGLBase
//
//  Created by glodon on 2019/8/28.
//

#import "RenderBuffer.h"

@interface RenderBuffer ()


@end

@implementation RenderBuffer
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _customInit];
    }
    return self;
}

-(void)_customInit{
    [self _createRenderBuffer];
}
-(void)bindRenderBuffer:(void(^)(RenderBuffer * buffer))renderBufferSettingBlock;{
    glBindRenderbuffer(GL_RENDERBUFFER, self.rbo);
    if (renderBufferSettingBlock) {
        renderBufferSettingBlock(self);
    }
    glBindRenderbuffer(GL_RENDERBUFFER,0);
}

-(void)setRenderStorageWithInternalformat:(GLenum) internalformat{
    CGFloat scale = UIScreen.mainScreen.scale;
    GLsizei fbo_width = [UIScreen mainScreen].bounds.size.width*scale;
    GLsizei fbo_height =  [UIScreen mainScreen].bounds.size.height*scale;
    glRenderbufferStorage(GL_RENDERBUFFER, internalformat, fbo_width, fbo_height);

}



#pragma mark  - private
-(void)_createRenderBuffer{
    glGenRenderbuffers(1, &_rbo);
}

-(void)_deleteRenderBuffer{
    glDeleteRenderbuffers(1, &_rbo);
}


- (void)dealloc
{
    [self _deleteRenderBuffer];
}
@end
