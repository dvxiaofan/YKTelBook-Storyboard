//
//  AddViewController.m
//  YKTelBook-Storyboard
//
//  Created by xiaofans on 16/6/22.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

#import "AddViewController.h"
#import "YKContactModel.h"

@interface AddViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addAction;
- (IBAction)backBtn:(UIBarButtonItem *)sender;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChang) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChang) name:UITextFieldTextDidChangeNotification object:self.phoneField];
}

- (void)textChang {
    //修改按钮的点击状态
    self.addBtn.enabled = (self.nameField.text.length && self.phoneField.text.length);
}
// 直接出现键盘行为
- (void)viewDidAppear:(BOOL)animated {
    // 小调用父类方法
    [super viewDidAppear:animated];
    // 呼出键盘
    [self.nameField becomeFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// 添加数据
- (IBAction)addAction {
    // 关闭当前视图控制器
    [self.navigationController popViewControllerAnimated:YES];
    // 代理传值
    if ([self.delegate respondsToSelector:@selector(addContact:didAddContact:)]) {
        YKContactModel *contactModel = [[YKContactModel alloc] init];
        contactModel.name = self.nameField.text;
        contactModel.phone = self.phoneField.text;
        [self.delegate addContact:self didAddContact:contactModel];
        
    }
}

- (IBAction)backBtn:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
