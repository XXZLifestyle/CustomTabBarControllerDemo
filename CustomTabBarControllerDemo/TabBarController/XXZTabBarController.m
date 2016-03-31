//
//  XXZTabBarController.m
//  CustomTabBarControllerDemo
//
//  Created by Jiayu_Zachary on 16/1/8.
//  Copyright © 2016年 Zachary. All rights reserved.
//

#import "XXZTabBarController.h"

//#import "XXZTabBarButton.h"
#import "XXZTabBar.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface XXZTabBarController () <XXZTabBarDelegate>

//设置之前选中的按钮
@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation XXZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self buildLayout];
    //根据有多少个子视图控制器来进行添加按钮 self.viewControllers.count
    [self loadTabBarWithCount:(int)self.viewControllers.count];
}

#pragma mark - build layout
- (void)buildLayout {
    FirstViewController *first = [[FirstViewController alloc] init];
    SecondViewController *second = [[SecondViewController alloc] init];
    ThirdViewController *third = [[ThirdViewController alloc] init];
    
    self.viewControllers = @[first, second, third];
}

#pragma mark - custom tabr bar controller
#pragma mark - XXZTabBarDelegate
- (void)tabBar:(XXZTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
}

#pragma mark - action
#if 0
//自定义TabBar的按钮点击事件
- (void)clickBtn:(UIButton *)button {
    //1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    //2.再将当前按钮设置为选中
    button.selected = YES;
    //3.最后把当前按钮赋值为之前选中的按钮
    self.selectedBtn = button;
    
    //4.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
    self.selectedIndex = button.tag;
}
#endif

#pragma mark - loading
- (void)loadTabBarWithCount:(int)count {
    if (count >6 || count < 2) { //tabBar至少有2个,最多有6个
        count = 4;
    }
    
    //删除现有的tabBar
    CGRect rect = self.tabBar.frame;
    [self.tabBar removeFromSuperview];  //移除TabBarController自带的标签栏
    
    //测试添加自己的视图
    XXZTabBar *tabBarView = [[XXZTabBar alloc] init];
    tabBarView.frame = rect;
    tabBarView.delegate = self;
    tabBarView.clipsToBounds = YES;
    tabBarView.layer.borderWidth = 0.5;
    tabBarView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    tabBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabBarView];
    
#if 1
    
    //为控制器添加按钮
    for (int i=0; i<count; i++) {
        
        NSString *imageName = [NSString stringWithFormat:@"bt2"];
        NSString *imageNameSel = [NSString stringWithFormat:@"bt"];
        
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *imageSel = [UIImage imageNamed:imageNameSel];
        
        [tabBarView addButtonWithImage:image selectedImage:imageSel];
    }
    
#endif
    
#if 0
    //创建按钮
    for (int i = 0; i < count; i++) {
        CGFloat x = i * tabBarView.frame.size.width/count;
        CGRect rect = CGRectMake(x, 0, (tabBarView.frame.size.width/count), tabBarView.frame.size.height);
        
        XXZTabBarButton *btn = [[XXZTabBarButton alloc] initWithFrame:rect];
        
        NSString *imageName = [NSString stringWithFormat:@"bt2"];
        NSString *imageNameSel = [NSString stringWithFormat:@"bt"];
        
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageNameSel] forState:UIControlStateSelected];
        
        [tabBarView addSubview:btn];
        
        btn.tag = i;//设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
        
        //带参数的监听方法记得加"冒号"
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i==0) { //设置刚进入时,第一个按钮为选中状态
            btn.selected = YES;
            self.selectedBtn = btn;  //设置该按钮为选中的按钮
        }  
    }
#endif
}

#pragma mark - getter


#pragma mark - setter


#pragma mark - dealloc
- (void)dealloc {
    
}

#pragma mark - other

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
