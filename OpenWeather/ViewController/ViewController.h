//
//  ViewController.h
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import <UIKit/UIKit.h>
#import "WeatherDataManager.h"
#import "WeatherViewModel.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelsLikeTemperatureLabel;


@end

