# CycleAnimationView
可模拟进度条的动画View，用CASharpLayer实现
用法： 
        CycleAnimationView *animationView = [[CycleAnimationView alloc] initWithFrame:CGRectMake((width+10) * i+10, 100, width, width) andOutR:6];
        animationView.outColor = [UIColor blueColor];
        animationView.innerColor = [UIColor redColor];
        animationView.pointColor = [UIColor redColor];
        animationView.score = rand()%100;
