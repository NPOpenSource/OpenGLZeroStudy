//
//  RenderBuffer.h
//  OpenGLBase
//
//  Created by glodon on 2019/8/28.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface RenderBuffer : NSObject
@property (nonatomic, assign) GLuint rbo;
//1
-(void)bindRenderBuffer:(void(^)(RenderBuffer * buffer))renderBufferSettingBlock;
//2
-(void)setRenderStorageWithInternalformat:(GLenum) internalformat;

@end

NS_ASSUME_NONNULL_END
