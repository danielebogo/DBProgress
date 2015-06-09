//
//  DBProgressView.h
//  dbprogress
//
//  Created by Daniele Bogo on 07/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DBProgressView : UIView

/**
 *  The percentage progress value
 */
@property (nonatomic, assign) CGFloat progress;

/**
 *  The duration of the animation
 */
@property (nonatomic, assign) CGFloat animationDuration;

/**
 *  The width of the border
 */
@property (nonatomic, assign) CGFloat borderWidth;

/**
 *  The color of the border
 */
@property (nonatomic, strong) UIColor *borderColor;

/**
 *  The progress background color
 */
@property (nonatomic, strong) UIColor *progressColor;

/**
 *  Block invoked when animation did start
 */
@property (nonatomic, copy) void(^progressAnimationDidStart)();

/**
 *  Block invoked when animation is finished
 */
@property (nonatomic, copy) void(^progressAnimationDidFinish)(BOOL finish, CGFloat progress);

/**
 *  Set progress value with animation
 *
 *  @param progress progress value
 *  @param animated animate the progress bar
 */
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end