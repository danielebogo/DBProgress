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
    CALayer *bgLayer_, *progressLayer_;
    CALayer *maskLayer_;
    CGFloat lastHeightValue_;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.backgroundColor = [UIColor clearColor];
        
        lastHeightValue_ = 0;
        
        _animationDuration = .3;
        
        [self db_buildUI];
    }
    return self;
}

- (void)layoutSubviews
{
    bgLayer_.frame = self.bounds;
    progressLayer_.frame = self.bounds;
    maskLayer_.frame = self.bounds;
    maskLayer_.cornerRadius = CGRectGetMidX(self.bounds);
}

- (void)setProgress:(CGFloat)progress
{
    if (progress >= maxPercentage) {
        progress = maxPercentage;
    }
    
    CGFloat toValue = (progress/maxPercentage) * CGRectGetHeight(self.bounds);
    
    CABasicAnimation *grow = [CABasicAnimation animationWithKeyPath:@"bounds.size.height"];
    grow.fromValue = @(lastHeightValue_);
    grow.toValue = @(toValue);
    grow.duration = self.animationDuration;
    grow.fillMode = kCAFillModeForwards;
    grow.removedOnCompletion = NO;

    [progressLayer_ addAnimation:grow forKey:kDBGrowHeightAnimationKey];
    
    lastHeightValue_ = toValue;
}


#pragma mark - Private methods

- (void)db_buildUI
{
    bgLayer_ = [CALayer layer];
    bgLayer_.backgroundColor = [UIColor greenColor].CGColor;
    [self.layer addSublayer:bgLayer_];
    
    progressLayer_ = [CALayer layer];
    progressLayer_.backgroundColor = [UIColor blueColor].CGColor;
    progressLayer_.anchorPoint = (CGPoint){ 0.5, 1.0 };
    [self.layer addSublayer:progressLayer_];
    
    maskLayer_ = [CALayer layer];
    maskLayer_.backgroundColor = [UIColor whiteColor].CGColor;
    maskLayer_.cornerRadius = CGRectGetMidX(self.bounds);
    
    self.layer.mask = maskLayer_;
}

@end