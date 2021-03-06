//
//  LoadingViewController.m
//  LionsRoar
//
//  Created by Matt Dahl on 5/3/13.
//  Copyright (c) 2013 mattdahl. All rights reserved.
//

#import "LoadingViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation LoadingViewController

@synthesize actvityIndicatorView, loadingLabel, delegate, loadingTask;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id<LoadingViewControllerDelegate>)delegateOrNil task:(bool(^)(void))task { // init with a task, then when task is done call the didFinishLoading method
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setDelegate:delegateOrNil];
        [self setLoadingTask:task];
        
        // Adds view to the delegate's window
        [UIApplication.sharedApplication.delegate.window addSubview:self.view];
        [delegate loadingViewControllerDidStartLoading:self];
        
        if ([self isTaskCompleted])
            [delegate loadingViewControllerDidFinishLoading:self];
        
        [self.view setFrame:CGRectMake(80, 150, 160, 150)];
        
        t = [NSTimer scheduledTimerWithTimeInterval:[delegate taskCheckTimeInterval]
                                             target:self selector:@selector(updateLoadingStatus)
                                           userInfo:nil
                                            repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:t
                                     forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.cornerRadius = 5;
    self.view.layer.masksToBounds = YES;
    if ([delegate shouldLoadingViewControllerAnimate:self]) {
        [actvityIndicatorView startAnimating];  
    }
    [self.view setFrame:CGRectMake(80, 150, 160, 150)];
}

- (BOOL)isTaskCompleted {
    return loadingTask();
}

- (void)updateLoadingStatus {
    if ([self isTaskCompleted]) {
        [delegate loadingViewControllerDidFinishLoading:self];
        [t invalidate];
        t = nil;
        [self.view removeFromSuperview]; // Removes the view
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
