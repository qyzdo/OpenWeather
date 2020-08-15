//
//  ViewController.m
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "ViewController.h"
#import "WeatherDataManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WeatherDataManager *api = [[WeatherDataManager alloc] init];
    [api getWeather];
}


@end
