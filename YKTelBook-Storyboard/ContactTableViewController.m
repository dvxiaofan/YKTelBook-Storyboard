//
//  ContactTableViewController.m
//  YKTelBook-Storyboard
//
//  Created by xiaofans on 16/6/22.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

#import "ContactTableViewController.h"
#import "YKContactModel.h"
#import "AddViewController.h"
#import "EditViewController.h"


#define ContactFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tellbook.data"]

@interface ContactTableViewController ()<AddViewControllerDelegate,EditViewControllerDelegate>
- (IBAction)backAction:(id)sender;

@property (strong, nonatomic) NSMutableArray *contactArr;
@end

@implementation ContactTableViewController

- (NSMutableArray *)contactArr {
    if (!_contactArr) {
        // 解码获得数组
        _contactArr = [NSKeyedUnarchiver unarchiveObjectWithFile:ContactFilePath];
        if (_contactArr == nil) {
            _contactArr = [NSMutableArray array];
        }
    }
    return _contactArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 调用自定义清除多余单元格线条方法 
    [self clearExtraLine:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.contactArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    YKContactModel *contactModel = self.contactArr[indexPath.row];
    cell.textLabel.text = contactModel.name;
    cell.detailTextLabel.text = contactModel.phone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - AddViewController代理方法

- (void)addContact:(AddViewController *)addVC didAddContact:(YKContactModel *)contact {
    [self.contactArr addObject:contact];
    [self.tableView reloadData];
    [NSKeyedArchiver archiveRootObject:self.contactArr toFile:ContactFilePath];
}

# pragma mark - 自定义去掉单元格中多余的先

- (void)clearExtraLine:(UITableView *)tableView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}

#pragma mark - Navigation 设置代理对象

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id vc = segue.destinationViewController;
    if ([vc isKindOfClass:[AddViewController class]]) {
        AddViewController *addVC = vc;
        addVC.delegate = self;
    } else {
        EditViewController *editVC = vc;
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        editVC.contactModel = self.contactArr[path.row];
        editVC.delegate = self;
    }
}

#pragma mark - EditVC delegate 

- (void)editViewController:(EditViewController *)editVC didSaveContact:(YKContactModel *)model {
    [self.tableView reloadData];
    [NSKeyedArchiver archiveRootObject:self.contactArr toFile:ContactFilePath];
}

#pragma mark - UITableView delegate 实现滑动删除功能

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.contactArr removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [NSKeyedArchiver archiveRootObject:self.contactArr toFile:ContactFilePath];
    }
}

#pragma mark - 注销按钮

- (IBAction)backAction:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"真的要注销吗？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:NO];
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
}
@end














