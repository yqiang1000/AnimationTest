//
//  AnimationViewController.m
//  AnimationTest
//
//  Created by yeqiang on 2017/4/27.
//  Copyright © 2017年 yeqiang. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *btnStart;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setType:(YQAnimationType)type {
    _type = type;
    [self setUI:_type];
}

- (void)setUI:(YQAnimationType)type {
    self.baseView = self.imageView;
    [self.view addSubview:self.baseView];
    [self.view addSubview:self.btnStart];
    if (type == AnimationTypeMove) {
        [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(10);
            make.centerY.equalTo(self.view.mas_centerY);
        }];
    } else if (type == AnimationTypeShake) {
        [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY);
        }];
    } else if (type == AnimationTypeCircle) {
        [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY);
        }];
    }
    
    
    [self.btnStart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

- (void)moveAnimation {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.fromValue = @(self.baseView.center.x);
    animation.toValue = @(self.baseView.center.x+kScreenWidth);
    animation.duration = 3;
    [self.baseView.layer addAnimation:animation forKey:@"basic"];
}

- (void)shakeAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.4;
    animation.additive = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.baseView.layer addAnimation:animation forKey:@"shake"];
}

- (void)circleAnimation {
//    CGRect boundingRect = CGRectMake(0, 0, self.baseView.center.x, self.baseView.center.y);
//    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
//    orbit.keyPath = @"position";
//    
//    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
//    orbit.duration = 4;
//    orbit.additive = YES;
//    orbit.repeatCount = HUGE_VALF;
//    orbit.calculationMode = kCAAnimationPaced;
//    orbit.rotationMode = kCAAnimationRotateAuto;
//    orbit.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [self.baseView.layer addAnimation:orbit forKey:@"orbit"];
    
    CABasicAnimation *zPosition = [CABasicAnimation animation];
    zPosition.keyPath = @"zPosition";
    zPosition.fromValue = @-1;
    zPosition.toValue = @1;
    zPosition.duration = 1.2;
    
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.values = @[ @0, @0.14, @0 ];
    rotation.duration = 1.2;
    rotation.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    
    CAKeyframeAnimation *position = [CAKeyframeAnimation animation];
    position.keyPath = @"position";
    position.values = @[
                        [NSValue valueWithCGPoint:CGPointZero],
                        [NSValue valueWithCGPoint:CGPointMake(110, -20)],
                        [NSValue valueWithCGPoint:CGPointZero]
                        ];
    position.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    position.additive = YES;
    position.duration = 1.2;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[ zPosition, rotation, position ];
    group.duration = 1.2;
    group.beginTime = 0.5;
    
    [self.baseView.layer addAnimation:group forKey:@"shuffle"];
    
    self.baseView.layer.zPosition = 1;
}

- (void)animationActionStartOrPause:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        if (_type == AnimationTypeMove) {
            [self moveAnimation];
        } else if (_type == AnimationTypeShake) {
            [self shakeAnimation];
        } else if (_type == AnimationTypeCircle) {
            [self circleAnimation];
        }
    } else {
        [self.baseView.layer removeAllAnimations];
    }
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"180"]];
    }
    return _imageView;
}

- (UIButton *)btnStart {
    if (!_btnStart) {
        _btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnStart setTitle:@"开始" forState:UIControlStateNormal];
        [_btnStart setTitle:@"暂停" forState:UIControlStateHighlighted];
        [_btnStart setTitle:@"暂停" forState:UIControlStateSelected];
        _btnStart.backgroundColor = [UIColor orangeColor];
        [_btnStart addTarget:self action:@selector(animationActionStartOrPause:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnStart;
}

@end
