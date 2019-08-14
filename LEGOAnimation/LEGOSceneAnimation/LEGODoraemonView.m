


//
//  LEGOSceneView.m
//  LEGOAnimation
//
//  Created by 杨庆人 on 2019/8/13.
//  Copyright © 2019年 杨庆人. All rights reserved.
//

#import "LEGODoraemonView.h"
#import <SceneKit/SceneKit.h>
#import <SSZipArchive/SSZipArchive.h>

#define filePath [NSString stringWithFormat:@"%@/model",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]]

@interface LEGODoraemonView ()
@property (nonatomic, strong) SCNNode *node;
@property (nonatomic, strong) SCNView *scnView;
@property (nonatomic, assign) CGPoint currPoint;

@end
@implementation LEGODoraemonView

- (instancetype)init {
    if (self = [super init]) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@%@",filePath,@"/doraemon.stl"]]) {
            [self setSceneView];
        }
        else {
            [self downLoadModelCompletion:^{
                [self setSceneView];
            }];
        }
    }
    return self;
}

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

- (void)setSceneView {
    [self addSubview:self.scnView];
    [self.scnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    SCNScene *scnScene = [SCNScene sceneWithURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@%@",filePath,@"/doraemon.stl"]] options:nil error:nil];
    SCNNode *node = scnScene.rootNode.childNodes.firstObject;
    node.geometry.firstMaterial.multiply.contents = [UIImage imageNamed:@"image_xxx"];
    node.geometry.firstMaterial.diffuse.contents = [UIImage imageNamed:@"image_xxx"];

//    node.transform = SCNMatrix4MakeScale(0.97, 0.97, 0.97);
    node.geometry.firstMaterial.lightingModelName = SCNLightingModelBlinn;
    //    node.geometry.firstMaterial.shininess = 0.3;
//    node.geometry.firstMaterial.locksAmbientWithDiffuse = NO;
//    node.geometry.firstMaterial.ambient.contents = UIColor.blackColor;
    node.geometry.firstMaterial.specular.contents = [UIColor colorWithRed:200.f/255.f green:200/255.f blue:200/255.f alpha:1.f];
//    node.position = SCNVector3Make(0, 0, 0);
    
    self.scnView.scene = scnScene;
    
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeOmni;
    lightNode.light.color = [UIColor whiteColor];
    if (@available(iOS 10.0, *)) {
        lightNode.light.intensity = 750.0f;
    }
    lightNode.position = SCNVector3Make(0, 0, 100.0f);
    [scnScene.rootNode addChildNode:lightNode];
    
    self.backgroundColor = [UIColor yellowColor];
    
//    [node runAction:[SCNAction repeatActionForever:[SCNAction rotateByX:0 y:2 z:0 duration:1]]];
    
}

- (void)setStartPoint:(CGPoint)startPoint {
    _startPoint = startPoint;
    SCNNode *node = self.scnView.scene.rootNode.childNodes.firstObject;
    _currPoint = CGPointMake(node.rotation.w, 0);
}

- (void)setupRotate:(CGPoint)point {
    SCNNode *node = self.scnView.scene.rootNode.childNodes.firstObject;
    CGPoint changePoint = CGPointMake(point.x - self.startPoint.x, point.y - self.startPoint.y);
    NSLog(@"changePoint=%@",[NSValue valueWithCGPoint:changePoint]);
    node.rotation = SCNVector4Make(0, 1, 0, self.currPoint.x + changePoint.x / LEGOScreenWidth * M_PI * 2);
}

- (void)downLoadModelCompletion:(void (^)(void))completion {
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"doraemon" ofType:@"zip"];
    NSString *toDestination = filePath;
    [SSZipArchive unzipFileAtPath:modelPath toDestination:toDestination progressHandler:^(NSString *entry, unz_file_info zipInfo, long entryNumber, long total) {
        NSLog(@"解压 zip %@",entry);
    } completionHandler:^(NSString *path, BOOL succeeded, NSError *error) {
        if (succeeded) {
            !completion ? :completion();
        }
        else {
            NSLog(@"解压失败");
        }
    }];
}



@end
