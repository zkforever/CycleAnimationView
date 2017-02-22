//
//  CycleAnimationView.h
//  YCTestProj
//
//  Created by zk on 2017/2/21.
//  Copyright © 2017年 zk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleAnimationView : UIView

@property (nonatomic,strong) UIColor *outColor;

@property (nonatomic,strong) UIColor *innerColor;

@property (nonatomic,strong) UIColor *pointColor;

//0-100分，100为一个圈
@property (nonatomic,assign) double score;


- (id)initWithFrame:(CGRect)frame andOutR:(CGFloat)r;

@end
