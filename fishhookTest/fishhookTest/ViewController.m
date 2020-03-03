//
//  ViewController.m
//  fishhookTest
//
//  Created by 谢鑫 on 2020/3/3.
//  Copyright © 2020 Shae. All rights reserved.
//

#import "ViewController.h"
#import "fishhook.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //这里必须要先加载一次要交换的函数，否则符号表里面不会出现要交换的函数的地址
    NSLog(@"我是纯正的NSLog函数");
    
    //定义rebinding结构体
    struct rebinding manager;
    //要交换的函数的名称
    manager.name="NSLog";
    //新的函数的地址
    manager.replacement=new_NSLog;
    //保存原始函数地址变量的指针（存储下来，在替换的方法里调用）
    manager.replaced=(void*)&old_NSLog;
    //定义数组
    struct rebinding rebs[]={manager};
    /*
     交换方法
     arg1: 存放rebinding结构体的数组
     arg2: 数组的长度
     */
    rebind_symbols(rebs, 1);
    
}
//函数指针，用来保存原始的函数地址
static void (* old_NSLog)(NSString *format, ...);
//新的NSLog函数
void new_NSLog(NSString *format, ...){
    format=[format stringByAppendingString:@"被勾上了"];
    //再调原来的
    old_NSLog(format);

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"点击屏幕");
}

@end
