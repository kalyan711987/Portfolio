//
//  Appinfoview.m
//  Portfolio
//
//  Created by Innoppl technologies on 26/03/13.
//  Copyright (c) 2013 Innoppl technologies. All rights reserved.
//

#import "Appinfoview.h"

@interface Appinfoview ()

@end

@implementation Appinfoview

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title=@"App Information";
    //self.navigationController.navigationBar.tintColor =[UIColor brownColor];
    [self.view setBackgroundColor:[UIColor colorWithRed:67.0/256.0 green:158/256.0 blue:185.0/256.0 alpha:1.0] ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
