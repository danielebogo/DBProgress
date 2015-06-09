//
//  MultiProgressTableViewController.m
//  dbprogress
//
//  Created by Daniele Bogo on 09/06/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "MultiProgressTableViewController.h"
#import "DBProgressView.h"

@interface ProgressCell : UITableViewCell

- (void)setProgress:(CGFloat)progress;

@end

@implementation ProgressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        DBProgressView *progressView = [DBProgressView new];
        progressView.tag = 200;
        progressView.animationDuration = .35;
        progressView.progressAnimationDidStart = ^{
            NSLog(@"Animation di start");
        };
        progressView.progressAnimationDidFinish = ^(BOOL finish, CGFloat progress){
            NSLog(@"Animation did stop %f", progress);
        };
        [self.contentView addSubview:progressView];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(progressView);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[progressView(90)]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[progressView(90)]"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:views]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:progressView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1.0
                                                                      constant:0]];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    DBProgressView *progressView = (DBProgressView *)[self.contentView viewWithTag:200];
    [progressView setProgress:progress animated:NO];
}

@end



@interface MultiProgressTableViewController ()

@end

@implementation MultiProgressTableViewController {
    NSArray *items_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    items_ = @[ @"0", @"50.0", @"100.0", @"14.0", @"35.0", @"67.0", @"85", @"15" ];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return items_.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"UITableViewCellIdentifier";
    ProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[ProgressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    [cell.contentView layoutIfNeeded];
    [cell setProgress:[items_[indexPath.row] floatValue]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0;
}

@end
