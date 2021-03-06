//
//  UISwitchViewController.m
//  OtherControls
//
//  Created by MS on 15-11-25.
//  Copyright (c) 2015年 guoyongfeng. All rights reserved.
//

#import "UISwitchViewController.h"

@interface UISwitchViewController ()

@end

@implementation UISwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)createControl{
    //UISwitch开关控件，继承于UIControl
    UISwitch * sw = [[UISwitch alloc]initWithFrame:CGRectMake(50, 200, 100, 50)];
    //设置打开时的tintColor
    sw.onTintColor = [UIColor yellowColor];
    sw.on = YES;//设置打开，默认是NO
    sw.tintColor = [UIColor grayColor];//设置关闭时的镂空颜色tintColor
    //设置打开的图片
//    sw.onImage = [UIImage imageNamed:@""];
    
    sw.thumbTintColor = [UIColor redColor];//设置开滑动小球的颜色
    
    //添加事件
    [sw addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sw];
}

-(void)valueChanged:(UISwitch *)sw
{
    NSLog(@"%@",sw.on?@"开关打开":@"开关关闭");
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

@end
