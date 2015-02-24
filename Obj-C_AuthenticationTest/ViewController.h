//
//  ViewController.h
//  Obj-C_AuthenticationTest
//
//  Created by 麻生 拓弥 on 2015/02/24.
//  Copyright (c) 2015年 麻生 拓弥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController : UIViewController

- (IBAction)authenticationBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

