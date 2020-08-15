//
//  ViewController.m
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __block WeatherViewModel *viewModel = [WeatherViewModel alloc];

    WeatherDataManager *api = [[WeatherDataManager alloc] init];
    [api getWeather:^(Weather *weather) {
        viewModel = [viewModel initWithWeather:weather];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.temperatureLabel.text = viewModel.temperatureText;
            self.feelsLikeTemperatureLabel.text = viewModel.feelsLikeText;
        });
    }];
    
}


@end
