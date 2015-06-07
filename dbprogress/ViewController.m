//
//  ViewController.m
//  dbprogress
//
//  Created by Daniele Bogo on 07/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "ViewController.h"
#import "DBProgressView.h"

@interface ViewController ()

@end

@implementation ViewController {
    DBProgressView *progressView_;
    NSArray *items_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    items_ = @[ @"0", @"50.0", @"100.0", @"14.0", @"35.0", @"67.0" ];
    
    progressView_ = [DBProgressView new];
    progressView_.progress = 0.0;
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)db_segmentedAction:(UISegmentedControl *)control
{
    progressView_.progress = [items_[control.selectedSegmentIndex] floatValue];
}


@end