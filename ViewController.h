//
//  ViewController.h
//  Portfolio
//
//  Created by Innoppl technologies on 26/03/13.
//  Copyright (c) 2013 Innoppl technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import <StoreKit/StoreKit.h>
@interface ViewController : UIViewController<SKStoreProductViewControllerDelegate,UIScrollViewDelegate>{
    
    
    NSOperationQueue *queue;

    NSMutableArray *appurls_array;
}

@end
