//
//  DayWeatherTableViewCell.h
//  OpenWeather
//
//  Created by Oskar Figiel on 19/08/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DayWeatherTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *dayNameLabel;
@property (nonatomic, strong) UIImageView *weatherImage;
@property (nonatomic, strong) UILabel *maxTemperatureLabel;
@property (nonatomic, strong) UILabel *minTemperatureLabel;



@end

NS_ASSUME_NONNULL_END
