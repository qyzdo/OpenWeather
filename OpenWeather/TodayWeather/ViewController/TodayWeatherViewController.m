//
//  ViewController.m
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "TodayWeatherViewController.h"

@interface TodayWeatherViewController ()
@end

@implementation TodayWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
        
    __block WeatherViewModel *viewModel = [WeatherViewModel alloc];
    
    WeatherDataManager *api = [[WeatherDataManager alloc] init];
    [api getWeather:^(Weather *weather) {
        viewModel = [viewModel initWithWeather:weather];
        NSLog(@"%@", viewModel);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.temperatureLabel.text = viewModel.temperatureText;
            self.feelsLikeTemperatureLabel.text = viewModel.feelsLikeText;
        });
    }];
    
}


- (void)setupView {
    
    UILayoutGuide * guide = self.view.safeAreaLayoutGuide;
    self.temperatureLabel = [[UILabel alloc] init];
    self.temperatureLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview: self.temperatureLabel];
    [self.temperatureLabel.topAnchor constraintEqualToAnchor:guide.topAnchor constant:20].active = true;
    [self.temperatureLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.temperatureLabel.heightAnchor constraintEqualToConstant:50].active = true;

    
    self.feelsLikeTemperatureLabel = [[UILabel alloc] init];
    self.feelsLikeTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview: self.feelsLikeTemperatureLabel];
    [self.feelsLikeTemperatureLabel.topAnchor constraintEqualToAnchor:self.temperatureLabel.topAnchor constant:50].active = true;
    [self.feelsLikeTemperatureLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.feelsLikeTemperatureLabel.heightAnchor constraintEqualToConstant:50].active = true;

}



@end
