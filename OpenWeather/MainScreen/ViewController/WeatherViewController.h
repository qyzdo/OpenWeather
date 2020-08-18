//
//  ViewController.h
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WeatherViewModel.h"

@interface WeatherViewController : UIViewController <WeatherViewModelDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *feelsLikeTemperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *minTemperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *maxTemperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentTemperatureLabel;
@property (strong, nonatomic) IBOutlet UIStackView *stackView;
@property (strong, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) WeatherViewModel *weatherViewModel;
@property (nonatomic, strong) UIActivityIndicatorView *loadingAnimation;
@property (nonatomic, strong) UILayoutGuide * guide;
@property (nonatomic, strong) CLLocationManager * manager;

 
-(void)setupView;
-(void)setupTableView;


@end

