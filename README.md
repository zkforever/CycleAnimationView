# CycleAnimationView
可模拟进度条的动画View，用CASharpLayer实现
用法： <br>
        CGFloat width = 100;<br>
        CycleAnimationView *animationView = [[CycleAnimationView alloc] initWithFrame:CGRectMake(10, 100, width, width) andOutR:6];<br>
        animationView.outColor = [UIColor blueColor];<br>
        animationView.innerColor = [UIColor redColor];<br>
        animationView.pointColor = [UIColor redColor];<br>
        animationView.score = rand()%100;<br>
