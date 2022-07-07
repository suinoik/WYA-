//
//  PackagesViewController.m
//  WYA?
//
//  Created by Onwuosiuno Ikhioda on 7/7/22.
//

#import "PackagesViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"



@interface PackagesViewController ()

@end

@implementation PackagesViewController
- (IBAction)logoutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        SceneDelegate *mySceneDelegate = (SceneDelegate * ) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
            mySceneDelegate.window.rootViewController = loginViewController;
        
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
