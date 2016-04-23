## 不设置 setImageEdgeInsets & setTitleEdgeInsets 

```
2016-04-23 09:55:55.707 resizableImage[3684:147388] topBgImage.resizingMode=0, topBgImage.capInsets={0, 0, 0, 0}.
2016-04-23 09:55:55.729 resizableImage[3684:147388] _cmd = testLeftRoundedButton
2016-04-23 09:55:55.729 resizableImage[3684:147388] _leftAgreeButton.frame = {{28, 587}, {159.5, 40}}

2016-04-23 09:55:55.731 resizableImage[3684:147388] _leftAgreeButton.imageView.frame = {{52.5, 8}, {24, 24}}
2016-04-23 09:55:55.733 resizableImage[3684:147388] _leftAgreeButton.imageView.leftMargin = 52.500000

2016-04-23 09:55:55.731 resizableImage[3684:147388] _leftAgreeButton.titleLabel.frame = {{77, 11}, {30, 18}}
2016-04-23 09:55:55.733 resizableImage[3684:147388] _leftAgreeButton.titleLabel.rightMargin = 52.500000

// imageView与titleLabel默认间隔0.5pt（1pixel），然后整体居中。
2016-04-23 09:55:55.735 resizableImage[3684:147388] margin[imageView,titleLabel] = 0.500000
```

## 设置 setImageEdgeInsets

```
2016-04-23 09:50:28.912 resizableImage[3536:140151] topBgImage.resizingMode=0, topBgImage.capInsets={0, 0, 0, 0}.
2016-04-23 09:50:28.932 resizableImage[3536:140151] _cmd1 = testLeftRoundedButton
2016-04-23 09:50:28.932 resizableImage[3536:140151] _leftAgreeButton.frame = {{28, 587}, {159.5, 40}}

// imageView.origin.x 左移4pt
2016-04-23 09:50:28.935 resizableImage[3536:140151] _leftAgreeButton.imageView.frame = {{48.5, 8}, {24, 24}}
2016-04-23 09:50:28.937 resizableImage[3536:140151] _leftAgreeButton.imageView.leftMargin = 48.500000

// titleLabel.frame 不变
2016-04-23 09:50:28.935 resizableImage[3536:140151] _leftAgreeButton.titleLabel.frame = {{77, 11}, {30, 18}}
2016-04-23 09:50:28.937 resizableImage[3536:140151] _leftAgreeButton.titleLabel.rightMargin = 52.500000

// imageView右侧与titleLabel间隔4pt（扣除默认的0.5pt）。
2016-04-23 09:50:28.939 resizableImage[3536:140151] margin[imageView,titleLabel] = 4.500000
```

## 设置 setTitleEdgeInsets 

```
2016-04-23 09:52:28.594 resizableImage[3583:142597] topBgImage.resizingMode=0, topBgImage.capInsets={0, 0, 0, 0}.
2016-04-23 09:52:28.616 resizableImage[3583:142597] _cmd2 = testLeftRoundedButton
2016-04-23 09:52:28.616 resizableImage[3583:142597] _leftAgreeButton.frame = {{28, 587}, {159.5, 40}}

// imageView.frame 不变
2016-04-23 09:52:28.618 resizableImage[3583:142597] _leftAgreeButton.imageView.frame = {{52.5, 8}, {24, 24}}
2016-04-23 09:52:28.620 resizableImage[3583:142597] _leftAgreeButton.imageView.leftMargin = 52.500000

// titleLabel.origin.x 右移4pt
2016-04-23 09:52:28.618 resizableImage[3583:142597] _leftAgreeButton.titleLabel.frame = {{81, 11}, {30, 18}}
2016-04-23 09:52:28.621 resizableImage[3583:142597] _leftAgreeButton.titleLabel.rightMargin = 48.500000

// titleLabel左侧与imageView间隔4pt（扣除默认的0.5pt）。
2016-04-23 09:52:28.623 resizableImage[3583:142597] margin[imageView,titleLabel] = 4.500000
```

## 设置 setImageEdgeInsets & setTitleEdgeInsets 

```
2016-04-23 09:58:11.586 resizableImage[3741:149905] topBgImage.resizingMode=0, topBgImage.capInsets={0, 0, 0, 0}.
2016-04-23 09:58:11.608 resizableImage[3741:149905] _cmd3 = testLeftRoundedButton
2016-04-23 09:58:11.608 resizableImage[3741:149905] _leftAgreeButton.frame = {{28, 587}, {159.5, 40}}

// imageView.origin.x 左移4pt
2016-04-23 09:58:11.610 resizableImage[3741:149905] _leftAgreeButton.imageView.frame = {{48.5, 8}, {24, 24}}
2016-04-23 09:58:11.613 resizableImage[3741:149905] _leftAgreeButton.imageView.leftMargin = 48.500000

// titleLabel.origin.x 右移4pt
2016-04-23 09:58:11.610 resizableImage[3741:149905] _leftAgreeButton.titleLabel.frame = {{81, 11}, {30, 18}}
2016-04-23 09:58:11.613 resizableImage[3741:149905] _leftAgreeButton.titleLabel.rightMargin = 48.500000

// imageView右侧与titleLabel左侧间隔8pt（扣除默认的0.5pt）。
2016-04-23 09:58:11.615 resizableImage[3741:149905] margin[imageView,titleLabel] = 8.500000
```

![LeftRoundedButton-setEdgeInsets](LeftRoundedButton-setEdgeInsets.png)

## 左文字右图标
### 标题左移至图标位置

```
// test41：标题只设置左边距为负图标宽度（24pt），实际左移半图标
[_rightAgainstButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -rightBtnImageWidth, 0, 0)];
```

```
// test42：标题只设置右边距为图标宽度（24pt），实际左移半图标
[_rightAgainstButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, rightBtnImageWidth)];
```

```
// test43：test41+test42，标题实际左移整个图标宽度
[_rightAgainstButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -rightBtnImageWidth, 0, rightBtnImageWidth)];
```

### 图标右移至标题位置

```
// 图标设置左边距为按钮标题宽度，右边距为负按钮标题宽度，实际右移整个按钮标题宽度
[_rightAgainstButton setImageEdgeInsets:UIEdgeInsetsMake(0, rightBtnTitleWidth, 0, -rightBtnTitleWidth)];
```

### 标题再左移4pt，图标再右移4pt

```
// test44：基于test43，标题继续左移4pt
[_rightAgainstButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -rightBtnImageWidth-4, 0, rightBtnImageWidth+4)];

// 图标继续右移4pt，最终左侧标题和右侧图标间距8pt
[_rightAgainstButton setImageEdgeInsets:UIEdgeInsetsMake(0, rightBtnTitleWidth+4, 0, -rightBtnTitleWidth-4)];
```

