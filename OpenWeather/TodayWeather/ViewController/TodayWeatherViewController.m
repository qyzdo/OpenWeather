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
            self.weatherIcon.image = viewModel.weatherImage;
            self.temperatureLabel.text = viewModel.temperatureText;
            self.feelsLikeTemperatureLabel.text = viewModel.feelsLikeText;
            self.minTemperatureLabel.text = viewModel.minTemperatureText;
            self.maxTemperatureLabel.text = viewModel.maxTemperatureText;
        });
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = true;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = false;
}

- (void)setupView {
    UILayoutGuide * guide = self.view.safeAreaLayoutGuide;
   
    
    
    self.weatherIcon = [[UIImageView alloc] init];
    self.weatherIcon.translatesAutoresizingMaskIntoConstraints = false;
    self.weatherIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview: self.weatherIcon];
    [self.weatherIcon.topAnchor constraintEqualToAnchor:guide.topAnchor].active = true;
    [self.weatherIcon.leftAnchor constraintEqualToAnchor:guide.leftAnchor constant:55].active = true;
    [self.weatherIcon.rightAnchor constraintEqualToAnchor:guide.rightAnchor constant:-55].active = true;
    [self.weatherIcon.heightAnchor constraintEqualToConstant:150].active = true;

    
    self.maxTemperatureLabel = [[UILabel alloc] init];
    self.maxTemperatureLabel.font = [UIFont systemFontOfSize:12];
    self.maxTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false;
    
    self.minTemperatureLabel = [[UILabel alloc] init];
    self.minTemperatureLabel.font = [UIFont systemFontOfSize:12];
    self.minTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false;
    
    self.stackView = [[UIStackView alloc] init];
    self.stackView.translatesAutoresizingMaskIntoConstraints = false;
    self.stackView.alignment = UIStackViewAlignmentCenter;
    self.stackView.distribution = UIStackViewDistributionFillProportionally;
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.spacing = 10;
    [self.stackView addArrangedSubview:self.minTemperatureLabel];
    [self.stackView addArrangedSubview:self.maxTemperatureLabel];
    
    [self.view addSubview: self.stackView];
    
    [self.stackView.topAnchor constraintEqualToAnchor:self.weatherIcon.bottomAnchor constant:-15].active = true;
    [self.stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;

  
    
    
    
    self.temperatureLabel = [[UILabel alloc] init];
    self.temperatureLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview: self.temperatureLabel];
    [self.temperatureLabel.topAnchor constraintEqualToAnchor:self.stackView.bottomAnchor constant:85].active = true;
    [self.temperatureLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.temperatureLabel.heightAnchor constraintEqualToConstant:50].active = true;

    
    self.feelsLikeTemperatureLabel = [[UILabel alloc] init];
    self.feelsLikeTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview: self.feelsLikeTemperatureLabel];
    [self.feelsLikeTemperatureLabel.topAnchor constraintEqualToAnchor:self.temperatureLabel.bottomAnchor].active = true;
    [self.feelsLikeTemperatureLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.feelsLikeTemperatureLabel.heightAnchor constraintEqualToConstant:50].active = true;

}



@end
