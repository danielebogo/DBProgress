//
//  SingleProgressViewController.m
//  dbprogress
//
//  Created by Daniele Bogo on 08/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "SingleProgressViewController.h"
#import "DBProgressView.h"

@interface SingleProgressViewController ()

@end

@implementation SingleProgressViewController {
    DBProgressView *progressView_;
    NSArray *items_;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    items_ = @[ @"0", @"50.0", @"100.0", @"14.0", @"35.0", @"67.0" ];

    progressView_ = [DBProgressView new];
    progressView_.animationDuration = .35;
    progressView_.progressAnimationDidStart = ^{
        NSLog(@"Animation di start");
    };
    progressView_.progressAnimationDidFinish = ^(BOOL finish, CGFloat progress){
        NSLog(@"Animation did stop %f", progress);
    };
    [self.view addSubview:progressView_];

    UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithItems:items_];
    segmented.translatesAutoresizingMaskIntoConstraints = NO;
    segmented.selectedSegmentIndex = 0;
    [segmented addTarget:self action:@selector(db_segmentedAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmented];

    NSDictionary *views = NSDictionaryOfVariableBindings(progressView_, segmented);

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:progressView_ attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[progressView_(200)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[segmented]-25-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[progressView_(200)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[segmented(50)]-25-|" options:0 metrics:nil views:views]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)db_segmentedAction:(UISegmentedControl *)control
{
    [progressView_ setProgress:[items_[control.selectedSegmentIndex] floatValue] animated:YES];
}

@end