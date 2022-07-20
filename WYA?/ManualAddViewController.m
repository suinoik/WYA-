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


- (void) createTracker {
    NSURL *url = [NSURL URLWithString:@"https://api.easypost.com/v2/trackers"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:@"Basic RVpUSzQ1ZjM5ZjY3NDA1YjRmNzg4ZmVmZDVjY2I5NjEyNDdlY0lGeTZrNENONU9qcWxrM2dBaXFuQQ==" forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"];
    
    NSDictionary *trackerBody = [NSDictionary dictionaryWithObjectsAndKeys:@"EZ1000000001", @"tracking_code", @"USPS", @"carrier", nil];
    NSDictionary *requestBodyDict = [NSDictionary dictionaryWithObjectsAndKeys:trackerBody, @"tracker", nil];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestBodyDict options:kNilOptions error:nil];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"test1 %@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               self.arrayOfPackages = (NSMutableDictionary *) dataDictionary;
               NSLog(@"test2 %@", dataDictionary);
               NSLog(@"actually returned something %@", self.arrayOfPackages);
           }

       }];
    
    [task resume];
}



- (IBAction)enterTracking:(id)sender {
    PFObject *manualEntry = [PFObject objectWithClassName:@"Package"];
    manualEntry[@"trackingNumber"] = self.trackingNumber.text;
    [manualEntry saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"worked");
        }else {
            NSLog(@"didn't worked");

        }
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
