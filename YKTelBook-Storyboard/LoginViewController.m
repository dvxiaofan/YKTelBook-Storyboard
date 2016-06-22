//
//  LoginViewController.m
//  YKTelBook-Storyboard
//
//  Created by xiaofans on 16/6/22.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD+MJ.h"

//宏定义关键字
#define UserNameKey @"name"
#define PwdKey @"pwd"
#define RemPwdKey @"rem_pwd"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UISwitch *remSwitch;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginAction;
- (IBAction)closeKeyboard;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加观察者 要观察文本框是否有内容
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChang) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChang) name:UITextFieldTextDidChangeNotification object:self.pwdField];
    
    // 数据存储，读取上次配置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];// 单例
    self.nameField.text = [defaults valueForKey:UserNameKey];
    self.pwdField.text = [defaults valueForKey:PwdKey];
    self.remSwitch.on = [defaults boolForKey:RemPwdKey];
    // 判断是否为保存密码状态 如果是，数据就应该自动从系统中读取
    if (self.remSwitch.isOn) {
        self.pwdField.text = [defaults valueForKey:PwdKey];
        self.loginBtn.enabled = YES;
    }
    
}

- (void)textChang {
    //修改按钮的点击状态
    /*
    if (self.nameField.text.length && self.pwdField.text.length) {
        self.loginBtn.enabled = YES;
    } else {
        self.loginBtn.enabled = NO;
    }
     */
    // 等价于
    self.loginBtn.enabled = (self.nameField.text.length && self.pwdField.text.length);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation  跳转之前执行准备工作

/**
 *  一般在这里给下一个控制器传值
    这个sender 是当初performSegueWithIdentifier 方法传入的sender
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //1.取得目标控制器
    UIViewController *contactVC = segue.destinationViewController;
    // 2.设置标题（传值）
    contactVC.title = [NSString stringWithFormat:@"%@的联系人",self.nameField.text];
}

//登陆
- (IBAction)loginAction {
    if (![self.nameField.text isEqualToString:@"test"]) {
        [MBProgressHUD showError:@"账号不存在"];
        return;
    }
    if (![self.pwdField.text isEqualToString:@"123456"]) {
        [MBProgressHUD showError:@"密码错误"];
        return;
    }
    // 显示蒙版 （遮盖）
    [MBProgressHUD showMessage:@"努力加载中"];
    // 模拟2秒跳转， 以后要发送的是网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 移除遮盖
        [MBProgressHUD hideHUD];
        // 实现手动登陆功能 根据标示符跳转
        [self performSegueWithIdentifier:@"LoginToContact" sender:nil];
    });
    // 实现数据存储
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.nameField.text forKey:UserNameKey];
    [defaults setObject:self.pwdField.text forKey:PwdKey];
    [defaults setBool:self.remSwitch.isOn forKey:RemPwdKey];
    // 设置同步，很重要, 因为只有同步，保存的数据才是最新
    [defaults synchronize];
}
// 关闭键盘
- (IBAction)closeKeyboard {
    
}
@end


















