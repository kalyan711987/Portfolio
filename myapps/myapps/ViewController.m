//
//  ViewController.m
//  myapps
//
//  Created by Innoppl technologies on 27/03/13.
//  Copyright (c) 2013 Innoppl technologies. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 320, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"che lives!" size:14.0];
    label.shadowColor = [UIColor redColor];
    label.textAlignment=UIControlContentVerticalAlignmentCenter;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = NSLocalizedString(@"Application's by Kalyan", @"");
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label=nil;
    //NSLog(@"font %@",[UIFont familyNames]);
    
    [self.view setBackgroundColor:[UIColor colorWithRed:67.0/256.0 green:158/256.0 blue:185.0/256.0 alpha:1.0] ];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
    appurls_array=[[NSMutableArray alloc]init];
    NSArray *appid_array=[[NSArray alloc]initWithObjects:@"549475580",@"561978046",@"537969858", nil];
    
 //------------- Showing images with animation ----------------//
    UIImageView* topapp1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 300, 150)];
    
    topapp1.animationImages = [NSArray arrayWithObjects:
                               [UIImage imageNamed:@"pic1.png"],
                               [UIImage imageNamed:@"iphone61.png"], nil]; //etc
    topapp1.animationDuration = 3.0f * [topapp1.animationImages count];
    topapp1.animationRepeatCount = 0;
    [topapp1 startAnimating];
    [self.view addSubview:topapp1];
//---------- Passing appids to fetch app information from itune store-------------//
    for (NSString *str in appid_array) {
        
        
        [self loadingApps:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",str]];
        
    }

//-----------label declaration ------------//
    UILabel *clicklbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, 320, 30)];
    clicklbl.backgroundColor = [UIColor clearColor];
    //clicklbl.font = [UIFont fontWithName:@"che lives!" size:10.0];
    clicklbl.shadowColor = [UIColor blackColor];
    clicklbl.textAlignment=UIControlContentVerticalAlignmentCenter;
    clicklbl.textAlignment = NSTextAlignmentCenter;
    clicklbl.text = @"Click on the images to view app details";
    clicklbl.textColor = [UIColor whiteColor];
    [self.view addSubview:clicklbl];
    clicklbl=nil;
}

//-----------Displaying the apps in scrollview------------//
-(void)loadviews{
    
    
    UIScrollView *subscrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,220,320,220)];
    subscrollview.scrollEnabled=YES;
    subscrollview.pagingEnabled=YES;
   // subscrollview.delegate=self;
    subscrollview.showsHorizontalScrollIndicator=NO;
    //[subscrollview setBackgroundColor:[UIColor clearColor]];
    [subscrollview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    float n=0.0;
    int i=0;
    for (NSDictionary *dt in appurls_array)
    {
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(4+n,5, 100,120)];
        //  NSString *arr=[[[RequestDict objectForKey:@"results"] objectAtIndex:0] valueForKey:@"artworkUrl512"];
        // image.image=[UIImage imageNamed:@"cliq.png"];
        
        NSString *mystring=[[NSString alloc]initWithString:[[[dt objectForKey:@"results"] objectAtIndex:0] valueForKey:@"artworkUrl100"]] ;
        // NSLog(@"urllllllll %@",[[[dt objectForKey:@"results"] objectAtIndex:0] valueForKey:@"trackId"]);
        [image setImageWithURL:[NSURL URLWithString:mystring]];
        
        [subscrollview addSubview:image];
        UIButton *button_image=[UIButton buttonWithType:UIButtonTypeCustom];
        button_image.frame=CGRectMake(2+n, 5, 100,120);
        [button_image addTarget:self action:@selector(openAppStore:) forControlEvents:UIControlEventTouchUpInside];
        [button_image setTag:[[[[dt objectForKey:@"results"] objectAtIndex:0] valueForKey:@"trackId"] integerValue]];
        [subscrollview addSubview:button_image];
        NSString *name=[[NSString alloc]initWithString:[[[dt objectForKey:@"results"] objectAtIndex:0] valueForKey:@"trackName"]] ;
        UILabel *appname=[[UILabel alloc]initWithFrame:CGRectMake(0+n,140,100,30)];
        appname.text=name;
        [appname setBackgroundColor:[UIColor clearColor]];
        //appname.textColor=[UIColor blackColor];
        appname.textColor = [UIColor whiteColor];
        appname.font=[UIFont systemFontOfSize:18];
        appname.textAlignment=NSTextAlignmentCenter;
        [subscrollview addSubview:appname];
        
        n+=image.frame.size.width+5;
        i++;
        
        
    }
    [self.view addSubview:subscrollview];
    [subscrollview setContentSize:CGSizeMake([appurls_array count]*145,150)];
}

#pragma mark---------------Fetching app details by using afnetwork lib

-(void)loadingApps:(NSString*)appid{
    
    NSURL *url1 = [NSURL URLWithString:appid];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url1];
    [httpClient defaultValueForHeader:@"Accept"];
    //[client setParameterEncoding:AFJSONParameterEncoding];
    NSURLRequest *request = [httpClient requestWithMethod:@"POST" path:appid parameters:nil];
    AFHTTPRequestOperation *operation;
    
    operation= [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [operation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation *operation,
       id responseObject) {
         NSError *jsonError = nil;
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:0 error:&jsonError];
         
         NSLog(@"response: %@",dic);
         if ([[dic objectForKey:@"resultCount"] isEqual:0] ) {
             
             
         }else
         {
             [appurls_array addObject:dic];
             
         }
         if (appurls_array.count ==3) {
             
             [self loadviews];
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"error: %@", [operation error]);
         UIAlertView *alerts =[[UIAlertView alloc]initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alerts show];
     }];
    
    //call start on your request operation
    [operation start];
    
}

-(void)openAppStore:(UIButton*)appid{
    alert= [[UIAlertView alloc] initWithTitle:@"Loading....." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] ;
    [alert show];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    activityIndicator.center = CGPointMake( 140,  65);
    [activityIndicator startAnimating];
    [alert addSubview:activityIndicator];
   
    NSString *ids=[NSString stringWithFormat:@"%d",appid.tag];
    SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
    // Configure View Controller
    [storeProductViewController setDelegate:self];
    [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier :ids} completionBlock:^(BOOL result, NSError *error) {
        [alert dismissWithClickedButtonIndex:0 animated:YES];

        if (error) {
            NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
            UIAlertView *alerts =[[UIAlertView alloc]initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alerts show];
        } else {
            // Present Store Product View Controller
            [self presentViewController:storeProductViewController animated:YES completion:nil];
        }
    }];
}

//Dismissing the storeview controller
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
