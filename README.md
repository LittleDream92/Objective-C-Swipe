# swapDemo
这个demo实现的是多张图片轻扫，动画，类似于天猫活动的头视图，中间图片大，两边图片小的效果。

效果图
![这里写图片描述](http://img.blog.csdn.net/20170104105814481?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvZmFueGlhb21lbmc5Mg==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)


本demo选取固定的位置rect。
首先，初始化控件的位置，存储成Array列表：

```
CGRect rect1 = CGRectMake(375 - 120 - 30, (667- 250)/2 + 25, 120, 200);
CGRect rect2 = CGRectMake((375 - 100)/2, (667 - 250/3 * 2)/2, 100, 250/3*2);
CGRect rect3 = CGRectMake(30, (667 - 250)/2+25, 120, 200);
CGRect rect4 = CGRectMake((375 - 150)/2, (667 - 250)/2, 150, 250);

_frameArray = @[[NSValue valueWithCGRect:rect1],
[NSValue valueWithCGRect:rect2],
[NSValue valueWithCGRect:rect3],
[NSValue valueWithCGRect:rect4]];
```

然后初始化原始控件，并且添加swipe手势，因为控件可以点击，我选择button控件：

```
for (int i = 0; i < 4; i++) {
UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
btn.backgroundColor = [UIColor colorWithRed:(arc4random()%99/99.0) green:(arc4random()%99/99.0) blue:(arc4random()%99/99.0) alpha:0.4];
[_btnArray addObject:btn];
[self.view addSubview:btn];

//添加手势
UISwipeGestureRecognizer *swipeGesture_right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
swipeGesture_right.direction = UISwipeGestureRecognizerDirectionRight;
[btn addGestureRecognizer:swipeGesture_right];

UISwipeGestureRecognizer *swipeGesture_Left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
swipeGesture_Left.direction = UISwipeGestureRecognizerDirectionLeft;
[btn addGestureRecognizer:swipeGesture_Left];
}
```
接着给button控件分别设置位置：

```
for (int i = 0; i < 4; i++) {
UIButton *btn = _btnArray[i];
NSValue *tmpValue = _frameArray[i];
CGRect rect = [tmpValue CGRectValue];
btn.frame = rect;
}
```

最后，触发Swipe手势，button控件动画触发新的frame：

```
- (void)swipeGesture:(id)sender
{
UISwipeGestureRecognizer *swipe = sender;

if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
//
UIButton *btn = _btnArray[0];
[_btnArray removeObjectAtIndex:0];
[_btnArray addObject:btn];

}else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
//
UIButton *btn = _btnArray[3];
[_btnArray removeObjectAtIndex:3];

NSMutableArray *array = [NSMutableArray array];
[array addObject:btn];
[array addObjectsFromArray:_btnArray];
_btnArray = array;

}

for (int i = 0; i < 4; i++) {
UIButton *btn = _btnArray[i];
NSValue *tmpValue = _frameArray[i];
CGRect rect = [tmpValue CGRectValue];

if (i == 3) {
[self.view bringSubviewToFront:btn];
}

[UIView animateWithDuration:0.4 animations:^{
btn.frame = rect;
}];
}
}
```
每一个button可以添加自己的target方法，点击就可以触发相对应的操作了。
