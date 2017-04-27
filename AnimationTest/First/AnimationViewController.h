//
//  AnimationViewController.h
//  AnimationTest
//
//  Created by yeqiang on 2017/4/27.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, YQAnimationType) {
    AnimationTypeMove = 0,
    AnimationTypeShake = 1,
    AnimationTypeCircle = 2,
};
//http://wiki.jikexueyuan.com/project/objc/animation/12-1.html
@interface AnimationViewController : BaseViewController

@property (nonatomic, assign) YQAnimationType type;

@end
