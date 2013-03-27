//
//  ViewController.h
//  myapps
//
//  Created by Innoppl technologies on 27/03/13.
//  Copyright (c) 2013 Innoppl technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import <StoreKit/StoreKit.h>
@interface ViewController : UIViewController<SKStoreProductViewControllerDelegate>{
    
    NSMutableArray *appurls_array;
    UIAlertView *alert;
}

@end
