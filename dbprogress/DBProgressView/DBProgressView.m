//
//  DBProgressView.m
//  dbprogress
//
//  Created by Daniele Bogo on 07/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "DBProgressView.h"

static CGFloat maxPercentage = 100.0;
static NSString *const kDBGrowHeightAnimationKey = @"kDBGrowHeightAnimationKey";


@implementation DBProgressView {
    CALayer *progressLayer_, *borderLayer_;
    CALayer *maskLayer_;
    CGFloat lastHeightValue_;
    BOOL setProgressForAnimation_;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        lastHeightValue_ = 0.0;
        setProgressForAnimation_ = NO;
        
        _animationDuration = .3;
        _borderWidth = 2.0;
        _borderColor = [UIColor blueColor];
        _progressColor = [UIColor greenColor];
        
        [self db_buildUI];
        
        self.progress = 0;
    }
    return self;
}

- (void)layoutSubviews
{
    progressLayer_.frame = self.bounds;
    borderLayer_.frame = self.bounds;
    borderLayer_.cornerRadius = CGRectGetMidX(self.bounds);
    maskLayer_.frame = self.bounds;
    maskLayer_.cornerRadius = borderLayer_.cornerRadius;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    [self setProgress:progress animated:NO];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    borderLayer_.borderWidth = borderWidth;
}


#pragma mark - Public methods

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    if (progress >= maxPercentage) {
        progress = maxPercentage;
    }
    
    setProgressForAnimation_ = animated;
    
    CGFloat toValue = (progress/maxPercentage) * CGRectGetHeight(self.bounds);
    
    CABasicAnimation *grow = [CABasicAnimation animationWithKeyPath:@"bounds.size.height"];
    grow.fromValue = @(lastHeightValue_);
    grow.toValue = @(toValue);
    grow.duration = setProgressForAnimation_ ? self.animationDuration : 0.1;
    grow.fillMode = kCAFillModeForwards;
    grow.removedOnCompletion = NO;
    grow.delegate = self;
    grow.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [progressLayer_ addAnimation:grow forKey:kDBGrowHeightAnimationKey];
    
    lastHeightValue_ = toValue;
}

#pragma mark - Private methods

- (void)db_buildUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    progressLayer_ = [CALayer layer];
    progressLayer_.backgroundColor = _progressColor.CGColor;
    progressLayer_.anchorPoint = (CGPoint){ 0.5, 1.0 };
    [self.layer addSublayer:progressLayer_];
    
    borderLayer_ = [CALayer layer];
    borderLayer_.borderWidth = _borderWidth;
    borderLayer_.borderColor = _borderColor.CGColor;
    borderLayer_.cornerRadius = CGRectGetMidX(self.bounds);
    [self.layer addSublayer:borderLayer_];
    
    maskLayer_ = [CALayer layer];
    maskLayer_.backgroundColor = [UIColor blackColor].CGColor;
    maskLayer_.cornerRadius = borderLayer_.cornerRadius;
    
    self.layer.mask = maskLayer_;
}


#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim
{
    if (self.progressAnimationDidStart && setProgressForAnimation_) {
        self.progressAnimationDidStart();
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.progressAnimationDidFinish && setProgressForAnimation_) {
        self.progressAnimationDidFinish(flag, _progress);
    }
}

@end