//
//  ViewController.m
//  SwapDemo
//
//  Created by Meng Fan on 16/3/28.
//  Copyright © 2016年 Meng Fan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) NSArray *frameArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    CGRect rect1 = CGRectMake(375 - 120 - 30, (667- 250)/2 + 25, 120, 200);
    CGRect rect2 = CGRectMake((375 - 100)/2, (667 - 250/3 * 2)/2, 100, 250/3*2);
    CGRect rect3 = CGRectMake(30, (667 - 250)/2+25, 120, 200);
    CGRect rect4 = CGRectMake((375 - 150)/2, (667 - 250)/2, 150, 250);
    
    _frameArray = @[[NSValue valueWithCGRect:rect1],
                    [NSValue valueWithCGRect:rect2],
                    [NSValue valueWithCGRect:rect3],
                    [NSValue valueWithCGRect:rect4]];
    
    _btnArray = [NSMutableArray array];
    
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
    
    for (int i = 0; i < 4; i++) {
        UIButton *btn = _btnArray[i];
        NSValue *tmpValue = _frameArray[i];
        CGRect rect = [tmpValue CGRectValue];
        btn.frame = rect;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - swipeGesture
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

@end
