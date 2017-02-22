# CycleAnimationView
可模拟进度条的动画View，用CASharpLayer实现
用法： 
        CycleAnimationView *animationView = [[CycleAnimationView alloc] initWithFrame:CGRectMake((width+10) * i+10, 100, width, width) andOutR:6];<br>
        animationView.outColor = [UIColor blueColor];<br>
        animationView.innerColor = [UIColor redColor];<br>
        animationView.pointColor = [UIColor redColor];<br>
        animationView.score = rand()%100;<br>
