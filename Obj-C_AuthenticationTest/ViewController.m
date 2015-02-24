//
//  ViewController.m
//  Obj-C_AuthenticationTest
//
//  Created by 麻生 拓弥 on 2015/02/24.
//  Copyright (c) 2015年 麻生 拓弥. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _resultLabel.text = @"";
}

- (IBAction)authenticationBtn:(id)sender {
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Authentication"
                                                                   message:@"Please choose Touch ID or Passcode."
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 選択肢を今回は 3 つ
    [alert addAction:[UIAlertAction actionWithTitle:@"Touch ID"
                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // Touch ID が選択された場合下記関数へ
        [self touchid_func];
                                                  
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Passcode"
                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // PASSCODE が選択された場合下記関数へ
        [self passcode_func];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Cancel ボタンが押されたときは今回は特になし
    }]];
    
    // ActionSheet を表示させる
    [self presentViewController:alert animated:YES completion:nil];

}

// ActionSheet で Touch ID を選択した場合に呼ばれる
-(void)touchid_func {
    
    // Apple Developer のコードをほぼそのまま移植
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Authentication Test (Touch ID)";
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    _resultLabel.text = @"SUCCESS";
                                } else {
                                    _resultLabel.text = @"FAILED";
                                }
                            }];
    } else {
        // Touch ID が使えないとき(非搭載など)
        _resultLabel.text = @"Your device doesn't support Touch ID.";
    }
}

// ActionSheet で Passcode を選択した場合に呼ばれる
-(void)passcode_func {
    
    // あとで比較関数に渡せるように宣言
    __block UITextField *loginid = [[UITextField alloc] init];
    __block UITextField *pass = [[UITextField alloc] init];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Authentication Test"
                                                                   message:@"Please input your login ID and password."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Login"
                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    
        // Login ボタンが押されたとき比較関数に ID と パスワードを NSString 形式で渡す
        [self compare_func:loginid.text second:pass.text];
                                                  
    }]];
    
    // Alert にテキストフィールドを表示(Login)
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
       
        // 用意したテキストフィールドに代入
        loginid = textField;
        
        // 最初に薄く表示されてるやつ
        textField.placeholder = @"Your ID";
        
    }];
    
    // Alert にテキストフィールドを表示(Password)
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        // 用意したテキストフィールドに代入
        pass = textField;
        
        // 最初に薄く表示されてるやつ
        textField.placeholder = @"Your Password";
        
    }];
    
    // Alert を表示する
    [self presentViewController:alert animated:YES completion:nil];
}

// 比較関数(引数は NSString 形式で 2 つ)
-(void)compare_func:(NSString *)login second:(NSString *)passwd {
    
    // 認証の正解書いておく。普通はこんなとこに書かないけど・・・
    NSString *correct_loginid = @"milanista";
    NSString *correct_passwd = @"milan";
    
    // 引数と正解を比較してあってれば SUCCESS を表示させる
    if ([login isEqualToString:correct_loginid] && [passwd isEqualToString:correct_passwd]) {
        
        _resultLabel.text = @"SUCCESS";
        
    } else {
        
        _resultLabel.text = @"FAILED";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
