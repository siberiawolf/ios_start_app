//
//  GTVideoViewController.m
//  SampleApp
//
//  Created by mac on 2020/5/2.
//  Copyright © 2020 siberiawolf. All rights reserved.
//

#import "GTVideoViewController.h"
#import "GTVideoCoverView.h"
#import "GTVideoToolbar.h"

@interface GTVideoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation GTVideoViewController

- (instancetype) init{
    self = [super init];
    if(self){
        self.tabBarItem.title = @"视频";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/video_selected@2x.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width / 16 * 9 + GTVideoToolbarHeight); // 16:9宽度视频
    
    // 创建一个CollectionView需要的两个条件
    // 1. 需要制定一个大小
    // 2. 需要创建一个collectionViewLayout
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    // 禁止系统自动计算statsBar高度，因为老系统中没有这个属性
    collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; // ios 11之后添加的属性
    
    // 同样需要指定delegate和dataSource
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    // 必须注册一个Cell
    [collectionView registerClass: [GTVideoCoverView class] forCellWithReuseIdentifier:@"GTVideCoverView"];
    
    [self.view addSubview:collectionView];
}

// 返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

// 返回cell的样式
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 从系统复用回收池中取cell
    // 如果系统中没有创建过cell，系统会自动的，根据注册的id创建一个
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GTVideCoverView" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];  // 指定单个cell背景色
    // 这里没有指定cell的大小，系统默认大小为50*50
    
    if ([cell isKindOfClass:[ GTVideoCoverView class]]) {
        [((GTVideoCoverView *) cell) layoutWithVideoCoverUrl:@"icon.bundle/videoCover@2x.png" videoUrl:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
    }
    
    return cell;
}

// 根据indexPath定制化item的Size大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.item % 3 ==0 ){
//        return CGSizeMake(self.view.frame.size.width, 100);
//    }else{
//        return CGSizeMake((self.view.frame.size.width - 10) /2, 300);
//    }
//}


@end
