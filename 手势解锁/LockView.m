//
//  LockView.m
//  手势解锁
//
//  Created by 李洋 on 2018/7/17.
//  Copyright © 2018年 com.appTest.app. All rights reserved.
//

#import "LockView.h"

@interface LockView ()
{}
@property (nonatomic,strong) NSMutableArray *selectBtnArray;
@property (nonatomic,assign) CGPoint lastPoint;
@end

@implementation LockView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectBtnArray = [[NSMutableArray alloc] init];
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    CGFloat btnWidth = 30;
    CGFloat space = (self.frame.size.width - 30 * 3)/4;
    for (int i = 0; i < 9; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.userInteractionEnabled = NO;
        [button setImage:[UIImage imageNamed:@"gesture_circle_nor"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"gesture_circle_pre"] forState:UIControlStateSelected];
        button.frame = CGRectMake(space + i%3*(btnWidth + space), space + i/3*(btnWidth + space), btnWidth, btnWidth);
        [self addSubview:button];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    UIButton * button = [self contentPointWithPoint:point];
    if (button && button.selected == NO) {
        button.selected = YES;
        [self.selectBtnArray addObject:button];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    self.lastPoint = point;
    UIButton * button = [self contentPointWithPoint:point];
    if (button && button.selected == NO) {
        button.selected = YES;
        [self.selectBtnArray addObject:button];
        
    }
    // 触发重绘
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UIButton * btn in self.subviews) {
        btn.selected = NO;
    }
    [self.selectBtnArray removeAllObjects];
    [self setNeedsDisplay];
}

// 判断一个点是否在某个范围内
- (UIButton *)contentPointWithPoint:(CGPoint)point
{
    for (UIButton * btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    return nil;
}


- (void)drawRect:(CGRect)rect {
    if (self.selectBtnArray.count) {
        UIBezierPath * path = [UIBezierPath bezierPath];
        for (int i = 0; i < self.selectBtnArray.count; ++i) {
            UIButton * btn = self.selectBtnArray[i];
            if (i == 0) {
                [path moveToPoint:btn.center];
            }else
            {
                [path addLineToPoint:btn.center];
            }
        }
        
        [path addLineToPoint:self.lastPoint];
        
        [path setLineWidth:5];
        [[UIColor redColor] set];
        [path setLineJoinStyle:kCGLineJoinRound];
        
        [path stroke];
        
    }
}

@end
