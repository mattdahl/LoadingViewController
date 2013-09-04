LoadingViewController
=====================

iOS class that elegantly handles presentation and dismissal of a loading screen for a given task.

##Usage
LoadingViewController is super-easy to use.

First, instantiate a LoadingViewController object in the controller that you want manage the loading object.

```objective-c
LoadingViewController *loadingViewController = [[LoadingViewController alloc] initWithNibName:@"LoadingViewController"
                                                                                       bundle:nil
                                                                                     delegate:self
                                                                                         task:^bool(void) {}];
```
                                                                  
Where `^(void) {}` is some block to be executed as a "checking task". That is to say, the LoadingViewController will
periodically run this this block to check if the "task" is completed. Structure the block so that it returns `YES` when
your desired task is complete, and `NO` when it is not yet complete.

Note that the `delegate` parameter is set to `self` - this means that `self` must implement the
LoadingViewControllerDelegate protocol.

That's it! Simply instantiating the LoadingViewController means that it will now *automatically* handle its own
presentation and dismissal.

###Delegate Methods

Want more control over the loading object? Implement these delegate methods in a non-trivial fashion:

- **(float)taskCheckTimeInterval**: In seconds, the interval for checking task completion. A shorter interval is more
  accurate, but more expensive.
- **(BOOL)shouldLoadingViewControllerAnimate**: Indicates whether or not the loading wheel should spin.
- **(void)loadingViewControllerDidStartLoading**: Message sent when the controller starts loading. This message is
  *always* sent.
- **(void)loadingViewControllerDidFinishLoading**: Message sent when the controller finishes loading. This message is
  *always* sent.
