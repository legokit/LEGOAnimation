//
//  LEGOSceneView.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/13.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGOSceneView.h"
#import <SceneKit/SceneKit.h>

@interface LEGOSceneView ()
@property (nonatomic, strong) SCNNode *node;
@property (nonatomic, strong) SCNView *scnView;
@end
@implementation LEGOSceneView

- (SCNView *)scnView {
    if (!_scnView) {
        _scnView = [[SCNView alloc]init];
        _scnView.backgroundColor = UIColor.clearColor;
        _scnView.allowsCameraControl = NO;
        _scnView.autoenablesDefaultLighting = NO;
        _scnView.antialiasingMode = SCNAntialiasingModeMultisampling4X;
    }
    return _scnView;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setSceneView];
    }
    return self;
}

- (void)setSceneView {
    [self addSubview:self.scnView];
    [self.scnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    SCNScene *scene = [SCNScene scene];
    scene.physicsWorld.gravity = SCNVector3Make(0, -30, 0);

    self.scnView.scene = scene;
    
    SCNBox *box = [SCNBox boxWithWidth:1 height:2 length:3 chamferRadius:0];
    SCNNode *geoNode = [SCNNode nodeWithGeometry:box];

    box.firstMaterial.multiply.contents = @[[UIImage imageNamed:@"image_111"],[UIImage imageNamed:@"image_222"],[UIImage imageNamed:@"image_111"],[UIImage imageNamed:@"image_222"],[UIImage imageNamed:@"image_111"],[UIImage imageNamed:@"image_222"]];
    box.firstMaterial.diffuse.contents = [UIImage imageNamed:@"image_111"];
    box.firstMaterial.multiply.intensity = 0.5;
    box.firstMaterial.lightingModelName =  SCNLightingModelBlinn;

    geoNode.geometry.firstMaterial.lightingModelName =  SCNLightingModelBlinn;
    geoNode.geometry.firstMaterial.specular.contents = [UIColor colorWithRed:200.f/255.f green:200/255.f blue:200/255.f alpha:1.f];

    geoNode.position = SCNVector3Make(0, 6, -20);
    [self.scnView.scene.rootNode addChildNode:geoNode];
//    [geoNode runAction:[SCNAction repeatActionForever:[SCNAction rotateByX:0 y:2 z:0 duration:1]]];
    [self addLight];
    
//    SCNTorus *torus = [SCNTorus torusWithRingRadius:4 pipeRadius:1];
//    SCNNode *geoNode = [SCNNode nodeWithGeometry:torus];
//
//    torus.firstMaterial.multiply.contents = @"pic5.ipg";
//    torus.firstMaterial.diffuse.contents=@"pic5.ipg";
//    torus.firstMaterial.multiply.intensity = 0.5;
//    torus.firstMaterial.lightingModelName =  SCNLightingModelConstant;
//    geoNode.position = SCNVector3Make(0, 2, -20);
//    [self.scnView.scene.rootNode addChildNode:geoNode];
//    [geoNode runAction:[SCNAction repeatActionForever:[SCNAction rotateByX:0 y:2 z:0 duration:1]]];
//    [self addLight];
    
    geoNode.camera = [SCNCamera camera];
    geoNode.camera.zFar = 200.f;
    geoNode.camera.zNear = .1f;
    //        _scnNode.camera.projectionDirection = SCNCameraProjectionDirectionHorizontal;
    geoNode.position = SCNVector3Make(0, 5, 20);
    
    self.backgroundColor = [UIColor yellowColor];
}

- (void)addLight{
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeOmni;
    lightNode.light.color = [UIColor whiteColor];
    if (@available(iOS 10.0, *)) {
        lightNode.light.intensity = 750.0f;
    }
    lightNode.position = SCNVector3Make(0, 0, 100.0f);
    [self.scnView.scene.rootNode addChildNode:lightNode];
}

@end
