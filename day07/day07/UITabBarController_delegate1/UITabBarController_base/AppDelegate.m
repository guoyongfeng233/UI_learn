//
//  AppDelegate.m
//  UITabBarController_base
//
//  Created by 夏婷 on 15/11/24.
//  Copyright (c) 2015年 夏婷. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "ViewController5.h"
#import "ViewController6.h"
#import "ViewController7.h"


@interface AppDelegate ()<UITabBarControllerDelegate>//遵循协议

@end

@implementation AppDelegate

#pragma mark - 创建UITabBarController

-(void)createTabBarController
{
    // 取出就顺序
    NSArray *sortArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"sort"];
    //管理视图控制器
    NSMutableArray *viewArray = [[NSMutableArray alloc]init];
    if (sortArray && sortArray.count > 0) {
        //按照新的顺序去创建
        
        for (NSString *className in sortArray)
        {
            //通过类名获取类
            Class aClass = NSClassFromString(className);
            //创建对应类的对象
            UIViewController *vc = [[aClass alloc]init];
            //取出最后一个字符
            NSString *title = [className substringFromIndex:className.length - 1];
            vc.title = title;
            //添加到管理视图的数组中
            [viewArray addObject:vc];
        }
        
    }else
    {
        ViewController1 *vc1 = [[ViewController1 alloc]init];
        vc1.title = @"1";
        ViewController2 *vc2 = [[ViewController2 alloc]init];
        vc2.title = @"2";
        ViewController3 *vc3 = [[ViewController3 alloc]init];
        vc3.title = @"3";
        ViewController4 *vc4 = [[ViewController4 alloc]init];
        vc4.title = @"4";
        ViewController5  *vc5 = [[ViewController5 alloc]init];
        vc5.title = @"5";
        ViewController6 *vc6 = [[ViewController6 alloc]init];
        vc6.title = @"6";
        ViewController7 *vc7 = [[ViewController7 alloc]init];
        vc7.title = @"7";
        NSArray *viewControllers = @[vc1,vc2,vc3,vc4,vc5,vc6,vc7];
        //把按顺序创建的视图控制器添加到viewArray中
        [viewArray addObjectsFromArray:viewControllers];
    }
    //创建UITabBarController
    UITabBarController *tab = [[UITabBarController alloc]init];
    // 指定代理关系，代理对象是UIApplcationMain函数中创建的AppDelegate 的对象
    tab.delegate = self;
    
    //UITabBarController继承于UIViewCongtroller的容器视图控制器，管理具有平级关系的视图控制器
    //设置平级关系的视图控制器数组
    
    tab.viewControllers = viewArray;
    
    self.window.rootViewController = tab;
    //UITabBarController默认选中第一个视图，可以通过设置selectedIndex改变选中的视图
    //取出上一次选中的下标
    NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:@"index"];
    //设置选中视图的下标
    tab.selectedIndex = index;
}

-(void)tabBarStyleSetting
{
    //通过window取到UITabBarController
    UITabBarController * tab = (id)self.window.rootViewController;
    //取到UITabBarController的TabBar
    UITabBar * tabBar = tab.tabBar;
    //设置样式
    tabBar.barStyle = UIBarStyleBlack;
    /*
     UIBarStyleDefault 白色半透明
     UIBarStyleBlack  黑色半透明
     UIBarStyleBlackOpaque 黑色半透明
     UIBarStyleBlackTranslucent 黑色半透明
     */
    //设置tabBar半透明或不透明
    tabBar.translucent = NO;
    
    //设置背景颜色
    tabBar.barTintColor = [UIColor redColor];
    
    //设置镂空部分的颜色
    tabBar.tintColor = [UIColor whiteColor];
    
    //设置背景图片
    [tabBar setBackgroundImage:[UIImage imageNamed:@"tab_bg"]];
    
}
-(void)tabBarItemSetting
{
    //取出TabBarController
    UITabBarController *tab = (id)self.window.rootViewController;
    //tab所管理的视图控制器器
    NSArray *viewControllers = tab.viewControllers;
    //设置tabBarItem,属于视图控制器
    
    for (UIViewController *vc in viewControllers)
    {
        //取出类名
        NSString *className = NSStringFromClass([vc class]);
        NSString *title = [className substringFromIndex:className.length - 1];
        NSString *text = [NSString stringWithFormat:@"第%@页",title];
        //非选中时的图片
        UIImage *imaeg = [[UIImage imageNamed:[NSString stringWithFormat:@"tab_%@",title]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 选中时的图片
        NSString *imageName = [NSString stringWithFormat:@"tab_s%@",title];
        UIImage *imageS = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //重设标题
        vc.title = text;
        if ([title isEqualToString:@"7"]) {
            
            UITabBarItem * item = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
            vc.title = text;
            vc.tabBarItem = item;
            
        }else
        {
            //创建TabBarItem
            UITabBarItem * item = [[UITabBarItem alloc]initWithTitle:text image:imaeg selectedImage:imageS];
            vc.tabBarItem = item;
        }
    }
   
}

#pragma mark - UITabBarControllerDelegate Methods
//将要选中某一个视图，切换到这个视图前调用这个方法，返回YES，允许跳转到相应的视图界面，否则停留在原视图界面
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    // 通过一个类获取类名
    NSString * className = NSStringFromClass([viewController class]);
    if ([className isEqualToString:@"ViewController4"]) {
        
        return NO;
    }
    return YES;
}
//已经先选中某一个视图
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"已经选中视图");
    // 取到视图的tabarItem
    UITabBarItem *item = viewController.tabBarItem;
    item.badgeValue = nil;
    
    //获取TabBarController所管理的所有的视图控制器
    NSArray *viewControllers = tabBarController.viewControllers;
    //得到当前选中的视图控制器在viewControllers中得下标
    NSInteger index = [viewControllers indexOfObject:viewController];
    // 保存到本地
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"index"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//将要开始编辑时调用这个方法，将要改变UITabBarController中得视图顺序
-(void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers
{
    NSLog(@"将要改变顺序");
    for (UIViewController *vc in  viewControllers)
    {
        NSString *className = NSStringFromClass([vc class]);
        NSLog(@"%@",className);
    }
    
}
//将结束编辑时调用这个方法，changed 是YES，顺序已经发生改变，NO顺序无变化
-(void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    NSLog(@"%@",changed ? @"顺序已经发生改变": @"顺序没有变化" );
}
//编辑已经结束，点Done 按钮之后之后
-(void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    //viewControllers中按顺序存储视图控制器
    NSLog(@"已经编辑结束");
    //在这个函数中，如果顺序有改变，保存下新的顺序
    if(changed)
    {
        NSMutableArray *sortArray = [[NSMutableArray alloc]init];
        for (UIViewController * vc  in viewControllers)
        {
            //获取视图控制器的类名
            NSString *className = NSStringFromClass([vc class]);
            //存储新的顺序
            [sortArray addObject:className];
            
        }
        NSLog(@"新的顺序:%@",sortArray);
        //保存到本地
        [[NSUserDefaults standardUserDefaults] setObject:sortArray forKey:@"sort"];
        //同步数据
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
}

#pragma mark - UIApplicationDelegate Method

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    //成为主窗口并显示
    [_window makeKeyAndVisible];
    //创建
    [self createTabBarController];
    //TabBar样式设置
    [self tabBarStyleSetting];
    //设置TabBarItem 设置
    [self tabBarItemSetting];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
