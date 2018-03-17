//
//  YHDraftViewController.m
//  ILMARE
//
//  Created by yh_swjtu on 17/7/24.
//  Copyright © 2017年 yh_swjtu. All rights reserved.
//

#import "YHDraftViewController.h"
#import "YHTempObjUtil.h"
#import "YHEditTempObj.h"
#import "YHStatusEditViewController.h"

@interface YHDraftViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation YHDraftViewController

- (NSMutableArray *) array{
    if (!_array){
        _array = [YHTempObjUtil tempMutableArray];
    }
    return _array;
}

- (UITableView *) tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setBackgroundColor:[UIColor colorWithRed:239 / 255.0 green:239 / 255.0  blue:244 / 255.0 alpha:1]];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    }
    return _tableView;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"YHDraftIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    YHEditTempObj *obj = self.array[indexPath.row];
    [cell.textLabel setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:17]];
    if (obj.content.length > 10){
        [cell.textLabel setText:[NSString stringWithFormat:@"%@...", [obj.content substringToIndex:10]]];
    }else{
        [cell.textLabel setText:obj.content];
    }
    cell.detailTextLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:15];
    [cell.detailTextLabel setText:[obj.time_stamp dateString]];
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tableView];
    self.title = @"草稿箱";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editTemp)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void) editTemp{
    [self.tableView setEditing:!self.tableView.editing];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YHEditTempObj *obj = self.array[indexPath.row];
    YHStatusEditViewController *con = [[YHStatusEditViewController alloc] initWithDraft:obj.content flag:1];
    [self presentViewController:con animated:YES completion:nil];
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.array removeObjectAtIndex:indexPath.row];
    [YHTempObjUtil writeArrayToFile:self.array];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
