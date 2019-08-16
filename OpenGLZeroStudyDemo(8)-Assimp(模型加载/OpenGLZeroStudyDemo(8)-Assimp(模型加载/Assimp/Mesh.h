//
//  Mesh.h
//  OpenGLZeroStudyDemo(8)-Assimp(模型加载
//
//  Created by glodon on 2019/8/16.
//  Copyright © 2019 glodon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssimpBindObject.h"
NS_ASSUME_NONNULL_BEGIN

@interface Mesh : NSObject
@property (nonatomic ,strong) NSMutableArray * vertices ;
@property (nonatomic ,strong) NSMutableArray * indices ;
@property (nonatomic ,strong) NSMutableArray * textures ;
-(void)parse;
-(void)draw:(AssimpBindObject * )bindObject;
@end

NS_ASSUME_NONNULL_END
