//
//  ViewController.m
//  GrayDealDemo
//
//  Created by zl on 2024/2/24.
//

#import "ViewController.h"
#import "WebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"截屏2024-02-29 11.48.25"]];
    imageView.frame = CGRectMake(50, 100, 200, 200);
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 350, 200, 50)];
    label.text = @"这是测试信息";
    label.textColor = [UIColor blueColor];
    [label sizeToFit];
    [self.view addSubview:label];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 450, 200, 50)];
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"web按钮" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btn_Click:(UIButton *)btn {
    WebViewController *webVC = [[WebViewController alloc]init];
    [self presentViewController:webVC animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

@end
