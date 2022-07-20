//
//  ManualAddViewController.h
//  WYA?
//
//  Created by Onwuosiuno Ikhioda on 7/8/22.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"


NS_ASSUME_NONNULL_BEGIN

@protocol ManualAddViewcontrollerDelegate


@end

@interface ManualAddViewController : UIViewController
@property (nonatomic, strong) PFUser *user;

+ (void) postPackage: ( UIImage * _Nullable )image withTracking: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;



@end

NS_ASSUME_NONNULL_END
