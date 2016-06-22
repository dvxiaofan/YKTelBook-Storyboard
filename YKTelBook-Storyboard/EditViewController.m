//
//  EditViewController.m
//  YKTelBook-Storyboard
//
//  Created by xiaofans on 16/6/22.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

#import "EditViewController.h"
#import "YKContactModel.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)saveAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *edit;
- (IBAction)editAction:(UIBarButtonItem *)sender;



@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 显示锁点击那一行的联系人信息
    self.nameField.text = self.contactModel.name;
    self.phoneField.text = self.contactModel.phone;
    
    // 添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChang) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChang) name:UITextFieldTextDidChangeNotification object:self.phoneField];
}

- (void)textChang {
    //修改按钮的点击状态
    self.saveBtn.enabled = (self.nameField.text.length && self.phoneField.text.length);
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


// 保存
- (IBAction)saveAction:(id)sender {
    // 1.关闭当前页面
    [self.navigationController popViewControllerAnimated:YES];
    // 2.通知代理  先判断代理是否响应协议方法
    if ([self.delegate respondsToSelector:@selector(editViewController:didSaveContact:)]) {
        // 更新数据
        self.contactModel.name = self.nameField.text;
        self.contactModel.phone = self.phoneField.text;
        // 实现方法，将模型数据传入
        [self.delegate editViewController:self didSaveContact:self.contactModel];
    }
}
// 编辑按钮相应方法
- (IBAction)editAction:(UIBarButtonItem *)sender {
    // 如果一开始文本框是可以点击的，那点击后就变为不可点击
    if (self.nameField.enabled) {
        self.nameField.enabled = NO;
        self.phoneField.enabled = NO;
        [self.view endEditing:YES];
        self.saveBtn.hidden = YES;
        sender.title = @"编辑";
        //还原回原来的数据
        self.nameField.text = self.contactModel.name;
        self.phoneField.text = self.contactModel.phone;
    } else {
        self.nameField.enabled = YES;
        self.phoneField.enabled = YES;
        [self.view endEditing:YES];
        self.saveBtn.hidden = NO;
        sender.title = @"取消";
    }
}
@end
















