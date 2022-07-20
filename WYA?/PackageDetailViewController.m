//
//  PackageDetailViewController.m
//  WYA?
//
//  Created by Onwuosiuno Ikhioda on 7/11/22.
//

#import "PackageDetailViewController.h"
#import "PackageCell.h"
#import "PackagesViewController.h"

@interface PackageDetailViewController ()

@end

@implementation PackageDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.carrier.text = self.arrayOfPackages[@"carrier"];
    self.deliveryDate.text = self.arrayOfPackages[@"est_delivery_date"];
    self.deliveryMessage.text = self.arrayOfPackages[@"message"];
    self.status.text = self.arrayOfPackages[@"status"];
    self.trackingNumber.text = self.arrayOfPackages[@"tracking_code"];
    
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
