//
//  GTNewsViewController.m
//  SampleApp
//
//  Created by mac on 2020/4/27.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTNewsViewController.h"
#import "GTNormalTableViewCell.h"
#import "GTDeleteCellView.h"
#import "GTListLoader.h"
#import "GTListItem.h"
#import "GTMediator.h"

@interface GTNewsViewController ()<UITableViewDataSource, UITableViewDelegate, GTNormalTableViewCellDelegate>
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) NSArray *dataArray;    // 提高性能，使用NSArray，即不可变数组
@property (nonatomic, strong, readwrite) GTListLoader *listLoader;
@end

@implementation GTNewsViewController

#pragma mark - lefe cycle

// 重载UIViewController初始化函数
- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds]; // 创建一个UITablecView，大小与整个ViewController大小一致

    _tableView.dataSource = self;
    _tableView.delegate = self;

    // 创建列表加载数据
    self.listLoader = [[GTListLoader alloc] init];
    __weak typeof (self) wself = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<GTListItem *> *_Nonnull dataArray) {
        __strong typeof (wself) strongSelf = wself;
        strongSelf.dataArray = dataArray; // 将请求回的数组，赋值给当前数组
        [strongSelf.tableView reloadData]; // 刷新列表
    }];

    [self.view addSubview:_tableView];

//    UIView *view = [[UIView alloc] init]; // 向内存申请分配地址，然后创建一个UIView
//    view.backgroundColor = [UIColor redColor];  // 背景色是红色
//    view.frame = CGRectMake(100, 100, 100, 100);    // 宽高是100，距离屏幕也分别是100
//
//    [self.view addSubview:view];    // 添加视图到根视图

    /*  注释掉UINavigatorController
    // view2 这个视图是后入栈的，所以这个视图会在前面的视图上面展示
    TestView *view2 = [[TestView alloc] init]; // 向内存申请分配地址，然后创建一个UIView
    view2.backgroundColor = [UIColor greenColor];  // 背景色是红色
    view2.frame = CGRectMake(150, 150, 100, 100);    // 宽高是100，距离屏幕也分别是100

    [self.view addSubview:view2];    // 添加视图到根视图

    // 建立一个手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushController)];
    // 给视图view2添加建立的手势
    [view2 addGestureRecognizer:tapGesture];*/
}

#pragma mark - UITableViewDelegate

// 返回整个UITableView的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;    // 根据数组个数创建
}

// 设置UITableViewCell 单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 在屏幕中展示的Cell其实保持的数量比较少
    GTNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"]; // 通过系统Cell回收池中，根据 id 标识进行判断，然后复用Cell
    if (!cell) {
        cell = [[GTNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];// 系统默认提供了四种内置的TableViewCell样式

        cell.delegate = self; // 使用自定义声明的delegate
    }

    [cell layoutTableViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row]];

    return cell;
}

// 指定tableViewCell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

// 继承了父类的delegate
// 证明UITableView继承了UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewDidiScroll");
}

// 点击Cell之后的事件函数
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GTListItem *item = [self.dataArray objectAtIndex:indexPath.row];
//     方式一： Target Action
//    __kindof UIViewController *detailController = [GTMediator detailViewControllerWithUrl:item.articleUrl];
//    detailController.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
//     ？？？列表点击后的动画效果还不是很顺滑？？？
//     backgroundColor这个属性系统默认是nil 不设置其实展示的是UIWindow的颜色。
//    detailController.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController pushViewController:detailController animated:YES];
    
//    方式二：URL Scheme
//    [GTMediator openUrl:@"detail://" params:@{@"url":item.articleUrl,@"controller":self.navigationController}];
    
//    方式三：protocol class
    Class cls = [GTMediator classForProtol:@protocol(GTDetailViewControllerProtocol)];
    [self.navigationController pushViewController:[[cls alloc] detailViewControllerWithUrl:item.articleUrl] animated:YES];
    

    // 文章已点击，设置为true，用文章id设置为key
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:item.uniqueKey];
}

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton {
//    GTDeleteCellView *deleteView = [[GTDeleteCellView alloc] initWithFrame:self.view.bounds];

//    // 将deleteCellView 的坐标转换到window的坐标中。
//    CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];
//
//    //处理循环引用
//    __weak typeof (self) wself = self;
//
//    [deleteView showDeleteViewFromPoint:rect.origin clicBlock:^{
//        __strong typeof (wself) strongSelf = wself;
//
//        // 删除最后一个
//        [strongSelf.dataArray removeLastObject];
//
//        // 根据table的indexPath 删除tableView
//        // 使用系统自动添加的动画效果
//        [strongSelf.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableViewCell]] withRowAnimation: UITableViewRowAnimationAutomatic];
//
//    }];
}

/*
// push一个NavigationController
- (void)pushController{

    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.navigationItem.title = @"内容";
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"右侧标题" style:UIBarButtonItemStylePlain target:self action:nil];


    [self.navigationController pushViewController:viewController animated:YES];
}*/

@end
