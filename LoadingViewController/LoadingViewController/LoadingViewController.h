//
//  LoadingViewController.h
//  LionsRoar
//
//  Created by Matt Dahl on 5/3/13.
//  Copyright (c) 2013 mattdahl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoadingViewControllerDelegate;

@interface LoadingViewController : UIViewController {
    NSTimer *t;
}

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *actvityIndicatorView;
@property (nonatomic, strong) IBOutlet UILabel *loadingLabel;
@property (nonatomic, weak) NSObject <LoadingViewControllerDelegate> *delegate;
@property (nonatomic, strong) bool(^loadingTask)(void);

/*
 * Inits a LoadingViewController with a task; the LoadingViewController then automatically handles its own presentation, animation, and dismissal
 * The delegate must conform to the LoadingViewControllerDelegate protocol
 * The task must be a block that return a bool indicating whether or not the task has successfully completed; when the task block returns YES, the LoadingViewController is dismissed
*/
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
             delegate:(id<LoadingViewControllerDelegate>)delegateOrNil
                 task:(bool(^)(void))task;
/*- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
             delegate:(id<LoadingViewControllerDelegate>)delegateOrNil
                 task:(NSInvocation)task; */

// Examples tasks could be checking if data has loaded from an API, checking if a view has finished loading, etc.

@end

@protocol LoadingViewControllerDelegate <NSObject>

@required

@property (nonatomic, strong) LoadingViewController *loadingViewController;

- (float)taskCheckTimeInterval; // In seconds
- (BOOL)shouldLoadingViewControllerAnimate:(LoadingViewController *)loadingViewController;
- (void)loadingViewControllerDidStartLoading:(LoadingViewController *)loadingViewController;
- (void)loadingViewControllerDidFinishLoading:(LoadingViewController *)loadingViewController;

@end