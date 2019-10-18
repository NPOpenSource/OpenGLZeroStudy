//
//  FrameBuffer.h
//  OpenGLBase
//
//  Created by glodon on 2019/8/28.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface FrameBuffer : NSObject

#pragma mark  - step
//1
-(void)bindOffScreenBufferAndSettingBlock:(void(^)(FrameBuffer * frameBuffer))frameBufferSettingBlock;
//2 必须绑定颜色buffer
-(void)bindColorAttachmentInTexture:(GLuint) texture;
//2 绑定深度组件在buffer中
-(void)bindDepthAttachmentInTexture:(GLuint) texture;
//2 绑定深度渲染  用渲染buffer
-(void)bingDepthAttachmentInRenderBuffer:(GLint)renderBuffer;
//3
-(BOOL)check;

///使用该buffer时候调用
-(void)bindOffScreenBuffer;
@end

NS_ASSUME_NONNULL_END
