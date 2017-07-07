//
//  ViewController.m
//  NavigationHeadImageScale
//
//  Created by jiangmm on 2017/7/7.
//  Copyright © 2017年 jchvip.rch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIImageView *headImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    UIView *titleView = [[UIView alloc] init];
    self.navigationItem.titleView = titleView;
    [titleView addSubview:self.headImage];
    self.headImage.center = CGPointMake(titleView.center.x, 0);

}
#pragma mark - UITableViewDelegate,UITableViewDataSource -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"第%@行",@(indexPath.row)];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    CGFloat scale = 1.0f;
    //放大
    if (offsetY < 0) {
        // 允许下拉放大的最大距离为300
        // 1.5是放大的最大倍数，当达到最大时，大小为：1.5 * 70 = 105
        // 这个值可以自由调整
        scale = MIN(1.5, 1 - offsetY / 300);
    }else if (offsetY > 0){
        // 缩小
        // 允许向上超过导航条缩小的最大距离为300
        // 为了防止缩小过度，给一个最小值为0.45，其中0.45 = 31.5 / 70.0，表示
        // 头像最小是31.5像素
        scale = MAX(0.45, 1 - offsetY / 300);
    
    }
    self.headImage.transform = CGAffineTransformMakeScale(scale, scale);
    CGRect frame = self.headImage.frame;
    frame.origin.y = -self.headImage.layer.cornerRadius / 2;
    self.headImage.frame = frame;
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -lazy -

-(UIImageView *)headImage
{
    if (!_headImage) {
        _headImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photoback"]];
        _headImage.frame = CGRectMake(0, 0, 70, 70);
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius = _headImage.bounds.size.height/2.0;
        
    }
    return _headImage;
}
@end
