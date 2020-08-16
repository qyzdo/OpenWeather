//
//  ViewController.h
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import <UIKit/UIKit.h>
#import "WeatherDataManager.h"
#import "WeatherViewModel.h"

@interface TodayWeatherViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *feelsLikeTemperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *minTemperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *maxTemperatureLabel;
@property (strong, nonatomic) IBOutlet UIStackView *stackView;
@property (strong, nonatomic) IBOutlet UIImageView *weatherIcon;



-(void)setupView;

@end

