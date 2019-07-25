//
//  os_cube.h
//  OpenGLES_004
//
//  Created by xu jie on 16/8/6.
//  Copyright © 2016年 xujie. All rights reserved.
//

#ifndef os_cube_h
#define os_cube_h
static const GLfloat cubeVertices[] =
{
    0.5, 0.5, 0.5,
    -0.5, 0.5, 0.5,
    -0.5,-0.5, 0.5,
    0.5,-0.5, 0.5,
    
    0.5, 0.5, 0,
    -0.5, 0.5, 0,
    -0.5,-0.5,0,
    0.5,-0.5,0,
    //1
};
static const GLfloat cubeColors[] = {
    1.0, 0, 0.0,
    1.0, 0, 0.0,
    1.0, 0, 0.0,
    1.0, 0, 0.0,
    0.0, 1.0, 0,
    0.0, 1.0, 0,
    0.0, 1.0, 0,
    0.0, 1.0, 0,
  
};
//2
static const GLuint tfan1[12 * 3] =
{
    0,2,1,
    0,2,3,
    0,7,4,
    0,7,3,
    0,5,4,
    0,5,1,
    
    6,1,5,
    6,1,2,
    6,3,2,
    6,3,7,
    6,4,5,
    6,4,7  
};


#endif /* os_cube_h */
