//
//  ManualAddViewController.m
//  WYA?
//
//  Created by Onwuosiuno Ikhioda on 7/8/22.
//

#import "ManualAddViewController.h"
#import "Parse/Parse.h"


@interface ManualAddViewController () 
@property (strong, nonatomic) NSMutableDictionary *arrayOfPackages;
@property (weak, nonatomic) IBOutlet UITextField *trackingNumber;

@end

@implementation ManualAddViewController






- (IBAction)enterTracking:(id)sender {
    PFObject *manualEntry = [PFObject objectWithClassName:@"Package"];
    NSURL *url = [NSURL URLWithString:@"https://api.easypost.com/v2/trackers"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:@"Basic RVpBSzQ1ZjM5ZjY3NDA1YjRmNzg4ZmVmZDVjY2I5NjEyNDdlMHppZWZtZXA0NnNrd3hFQTJvazlFdw==" forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"];
    
    NSDictionary *trackerBody = [NSDictionary dictionaryWithObjectsAndKeys:self.trackingNumber.text, @"tracking_code", nil];
    NSDictionary *requestBodyDict = [NSDictionary dictionaryWithObjectsAndKeys:trackerBody, @"tracker", nil];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestBodyDict options:kNilOptions error:nil];
    [request setHTTPBody:postData];
    // call
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"test57 %@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSLog(@"Data of tracking: %@", dataDictionary);
               
               manualEntry[@"trackingNumber"] = self.trackingNumber.text;
               manualEntry[@"carrier"] = dataDictionary[@"carrier"];
               manualEntry[@"deliveryDate"] = dataDictionary[@"est_delivery_date"];
               manualEntry[@"status"] = dataDictionary[@"status"];
//               manualEntry[@"deliveryMessage"] = dataDictionary[@"message"];
               [self dismissViewControllerAnimated:YES completion:nil];


               
               
               // TODO: Set object data with dictionary data
               
               [manualEntry saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                   if (succeeded) {
                       NSLog(@"worked");
                   }else {
                       NSLog(@"Error: %@", error.localizedDescription);
                       NSLog(@"didn't worked");

                   }
               }];
           }
    }];
    
    [task resume];
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
