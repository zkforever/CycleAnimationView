//
//  CycleAnimationView.m
//  YCTestProj
//
//  Created by zk on 2017/2/21.
//  Copyright © 2017年 zk. All rights reserved.
//

#import "CycleAnimationView.h"

@interface CycleAnimationView()

@property (nonatomic,strong)CAShapeLayer *innerLayer;

@property (nonatomic,strong)CAShapeLayer *outLayer;

@property (nonatomic,strong)CAShapeLayer *pointLayer;

@property (nonatomic,assign) double angle;

@end


@implementation CycleAnimationView


- (id)initWithFrame:(CGRect)frame andOutR:(CGFloat)r
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initWithCustomRect:frame andOutR:r];
    }
    return self;
}


- (void)initWithCustomRect:(CGRect)rect andOutR:(CGFloat)r {
//    _angle = -M_PI_4;
    //外环跑道宽
    CGFloat outR = r;
    //内环跑道宽
    CGFloat innerR = r-2;
    
    _outLayer = [self shapLayerWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height) strokeColor:[UIColor redColor] lineWidth:outR];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rect.size.width, rect.size.height) cornerRadius:rect.size.width*0.5];
    _outLayer.path = path.CGPath;
    
    _innerLayer = [self shapLayerWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height) strokeColor:[UIColor blueColor] lineWidth:innerR];
    UIBezierPath *innerPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width*0.5, rect.size.height*0.5) radius:rect.size.width*0.5 startAngle:-M_PI_2 endAngle:_angle-M_PI_2 clockwise:NO];
    _innerLayer.path = innerPath.CGPath;

    
    //算出头的x和y
    float y = rect.size.height/2.f + rect.size.height/2.f*sin(_angle-M_PI/2) - innerR*0.5;
    float x = rect.size.width/2.f + rect.size.height/2.f*cos(_angle-M_PI/2) - innerR*0.5;
    _pointLayer = [self shapLayerWithFrame:CGRectMake(x, y, innerR, innerR) strokeColor:[UIColor greenColor] lineWidth:innerR];
    _pointLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, innerR, innerR) cornerRadius:innerR*0.5].CGPath;
    [self.layer addSublayer:_outLayer];
    [self.layer addSublayer:_innerLayer];
    [self.layer addSublayer:_pointLayer];
}

- (void)setOutColor:(UIColor *)outColor {
    _outColor = outColor;
    _outLayer.strokeColor = outColor.CGColor;
}

- (void)setInnerColor:(UIColor *)innerColor {
    _innerColor = innerColor;
    _innerLayer.strokeColor = innerColor.CGColor;
}


- (void)setPointColor:(UIColor *)pointColor {
    _pointColor = pointColor;
    _pointLayer.strokeColor = pointColor.CGColor;
}

- (void)setIsShowHead:(BOOL)isShowHead {
    _isShowHead = isShowHead;
    if (isShowHead) {
        _pointLayer.hidden = NO;
    }else {
        _pointLayer.hidden = YES;
    }
}


- (void)setScore:(double)score {
    if (score < 0 || score > 100) {
        return;
    }
    double anAngle = -1 * M_PI * score / 50.f;
    _isClockWise = YES;
    if (_isClockWise) {
        anAngle = M_PI * score / 50.f;
    }
    [self setAngle:anAngle];
}



- (void)setAngle:(double)angle {
    _angle = angle;
    CGRect rect = self.bounds;
    UIBezierPath *innerPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width*0.5, rect.size.height*0.5) radius:rect.size.width*0.5 startAngle:-M_PI_2 endAngle:_angle-M_PI_2 clockwise:_isClockWise];
    _innerLayer.path = innerPath.CGPath;
    //添加动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    [_innerLayer setStrokeEnd:1.0];
    [_innerLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    
    //头的动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 1;
    pathAnimation.repeatCount = 0;
    float radiuscale = 1;
    CGFloat origin_x = self.frame.size.width/2;
    CGFloat origin_y = self.frame.size.height/2;
    CGFloat radiusX = self.frame.size.width/2;
    float a = -M_PI / 2;
    float b = _angle - M_PI / 2;
    CGMutablePathRef path = CGPathCreateMutable();
    CGAffineTransform t = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformMakeTranslation(-origin_x, -origin_y),CGAffineTransformMakeScale(radiuscale, radiuscale)),
                                                  CGAffineTransformMakeTranslation(origin_x, origin_y));
    //最后一个参数，1是逆时针，0是顺时针
//    CGPathAddArc(path, &t, origin_x, origin_y, radiusX ,a , b, _isClockWise);
    CGPathAddArc(path, &t, origin_x, origin_y, radiusX ,a , b, !_isClockWise);

    pathAnimation.path = path;
    CGPathRelease(path);
    [_pointLayer addAnimation:pathAnimation forKey:@"movePoint"];

}



- (CAShapeLayer *)shapLayerWithFrame:(CGRect)frame strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth {
    //创建
    CAShapeLayer *caShapeLayer = [CAShapeLayer layer];
    caShapeLayer.frame = frame;
    caShapeLayer.fillColor = nil;
    caShapeLayer.lineJoin = kCALineJoinRound;
    caShapeLayer.lineCap = kCALineCapRound;
    caShapeLayer.lineWidth = lineWidth;
    caShapeLayer.strokeColor = strokeColor.CGColor;
    //返回
    return caShapeLayer;
}



@end

