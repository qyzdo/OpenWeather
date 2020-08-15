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


-(void)setupView;

@end

