//
//  ICViewController.m
//  ImagePlayerViewDemo
//
//  Created by 陈颜俊 on 14-6-6.
//  Copyright (c) 2014年 Chenyanjun. All rights reserved.
//

#import "ICViewController.h"

@interface ICViewController () <ImagePlayerViewDelegate>
@property (nonatomic, strong) NSArray *imageURLs;
@end

@implementation ICViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.imageURLs = @[
                       @"11.jpg",@"44.jpg",
                       @"33.jpg",@"22.jpg"];
    
     [self.imagePlayerView initWithCount:self.imageURLs.count delegate:self];
    
    // adjust pageControl position
    // 修改小圆钮位置
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    //梁思远，2014年12月09日09:51:32，修复定时器不销毁问题
    //修改前代码行开始
    //self.imagePlayerView.scrollInterval = 2.0f;
    //修改前代码行结束
    
    // hide pageControl or not
    self.imagePlayerView.hidePageControl = NO;
}

    //修改后代码行开始
-(void)viewWillAppear:(BOOL)animated{
   self.imagePlayerView.scrollInterval = 2.0f;
}
    //修改后代码行结束

    //梁思远，2014年12月09日09:53:19，离开界面需要手动销毁
-(void)viewWillDisappear:(BOOL)animated{
    [self.imagePlayerView invalidateMyTimer];
}
    //修改结束

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ImagePlayerViewDelegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
// recommend to use SDWebImage lib to load web image
//    [imageView setImageWithURL:[self.imageURLs objectAtIndex:index] placeholderImage:nil];

    if (index == 0) {
        imageView.image = [UIImage imageNamed:[self.imageURLs objectAtIndex:self.imageURLs.count - 1]];
    }else if (index == self.imageURLs.count + 1){
        imageView.image = [UIImage imageNamed:[self.imageURLs objectAtIndex:0]];
    }else{
        imageView.image = [UIImage imageNamed:[self.imageURLs objectAtIndex:index-1]];
    }
    
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NexrViewController * nv =[[NexrViewController alloc]init];
    [self presentViewController:nv animated:YES completion:nil];
    NSLog(@"did tap index = %d", (int)index);
}
@end
