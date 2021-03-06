//
//  ViewController.m
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    self.manager = [[CLLocationManager alloc] init];
    self.manager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.manager.delegate = self;

    
    [self.manager requestWhenInUseAuthorization];
    [self.manager requestLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = true;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = false;
}

- (void)setupView {
    self.guide = self.view.safeAreaLayoutGuide;
    
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    self.weatherIcon = [[UIImageView alloc] init];
    self.weatherIcon.translatesAutoresizingMaskIntoConstraints = false;
    self.weatherIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview: self.weatherIcon];
    [self.weatherIcon.topAnchor constraintEqualToAnchor:self.guide.topAnchor].active = true;
    [self.weatherIcon.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.weatherIcon.heightAnchor constraintEqualToConstant:200].active = true;
    [self.weatherIcon.widthAnchor constraintEqualToConstant:200].active = true;
    
    
    self.currentTemperatureLabel = [[UILabel alloc] init];
    self.currentTemperatureLabel.font = [UIFont systemFontOfSize:45];
    self.currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview: self.currentTemperatureLabel];
    
    [self.currentTemperatureLabel.topAnchor constraintEqualToAnchor:self.weatherIcon.bottomAnchor constant:-5].active = true;
    [self.currentTemperatureLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    
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
    
    [self.stackView.topAnchor constraintEqualToAnchor:self.currentTemperatureLabel.bottomAnchor constant:5].active = true;
    [self.stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    
    self.feelsLikeTemperatureLabel = [[UILabel alloc] init];
    self.feelsLikeTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview: self.feelsLikeTemperatureLabel];
    [self.feelsLikeTemperatureLabel.topAnchor constraintEqualToAnchor:self.stackView.bottomAnchor].active = true;
    [self.feelsLikeTemperatureLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.feelsLikeTemperatureLabel.heightAnchor constraintEqualToConstant:50].active = true;
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
    self.collectionView.backgroundColor = UIColor.systemBackgroundColor;
    [self.collectionView registerClass:[HourWeatherCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    
    self.loadingAnimation = [[UIActivityIndicatorView alloc] init];
    self.loadingAnimation.activityIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;
    self.loadingAnimation.hidesWhenStopped = true;
    self.loadingAnimation.translatesAutoresizingMaskIntoConstraints = false;
    [self.loadingAnimation startAnimating];
    [self.view addSubview:self.loadingAnimation];
    
    [self.loadingAnimation.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.loadingAnimation.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = true;
}

- (void)didFinishFetchingData:(WeatherViewModel *)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setupCollectionView];
        [self setupTableView];
        self.weatherIcon.image = self.weatherViewModel.weatherImage;
        self.feelsLikeTemperatureLabel.text = self.weatherViewModel.feelsLikeText;
        self.minTemperatureLabel.text = self.weatherViewModel.minTemperatureText;
        self.maxTemperatureLabel.text = self.weatherViewModel.maxTemperatureText;
        self.currentTemperatureLabel.text = self.weatherViewModel.currentTemperatureText;
        [self.loadingAnimation stopAnimating];
        [self.tableView reloadData];
        [self.collectionView reloadData];
    });
}

#pragma mark - TABLEVIEW

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"tableViewCell";
    [self.weatherViewModel setupDailyForecastCell:indexPath.row];
    DayWeatherTableViewCell *cell = [[DayWeatherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.dayNameLabel.text = self.weatherViewModel.dayNameTableCellText;
    cell.weatherImage.image = self.weatherViewModel.weatherTableCellImage;
    cell.maxTemperatureLabel.text = self.weatherViewModel.maxTemperatureTableCellText;
    cell.minTemperatureLabel.text = self.weatherViewModel.minTemperatureTableCellText;

    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.weatherViewModel.tableNumberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weatherViewModel.tableNumberOfRows;
}

- (void)setupTableView {
    [self.view addSubview:self.tableView];
    [self.tableView.topAnchor constraintEqualToAnchor:self.collectionView.bottomAnchor constant:5].active = true;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.guide.bottomAnchor].active = true;
    [self.tableView.leftAnchor constraintEqualToAnchor:self.guide.leftAnchor].active = true;
    [self.tableView.rightAnchor constraintEqualToAnchor:self.guide.rightAnchor].active = true;
}

#pragma mark - COLLECTIONVIEW

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.weatherViewModel.collectionNumberOfRows;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.weatherViewModel setupHourlyForecastCell:indexPath.row];
    HourWeatherCollectionViewCell *cell = (HourWeatherCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    cell.timeLabel.text = self.weatherViewModel.hourTableCellText;
    cell.temperatureLabel.text = self.weatherViewModel.currentTemperatureCollectionCellText;
    cell.weatherImage.image = self.weatherViewModel.weatherColectionCellImage;
 
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width/6, 80);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.weatherViewModel.collectionNumberOfSections;
}

- (void)setupCollectionView {
    [self.view addSubview:self.collectionView];
    [self.collectionView.topAnchor constraintEqualToAnchor:self.feelsLikeTemperatureLabel.bottomAnchor constant:-5].active = true;
    [self.collectionView.leftAnchor constraintEqualToAnchor:self.guide.leftAnchor].active = true;
    [self.collectionView.rightAnchor constraintEqualToAnchor:self.guide.rightAnchor].active = true;
    [self.collectionView.heightAnchor constraintEqualToConstant:105].active = true;
}

#pragma mark - LOCATION

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [manager stopUpdatingLocation];
    manager.delegate = nil;
    NSNumber *latNumber = [NSNumber numberWithDouble:locations.lastObject.coordinate.latitude];
    NSString *lat = [[NSString alloc] initWithString:[latNumber stringValue]];
    NSNumber *lonNumber = [NSNumber numberWithDouble:locations.lastObject.coordinate.longitude];
    NSString *lon = [[NSString alloc] initWithString:[lonNumber stringValue]];
    self.weatherViewModel = [[WeatherViewModel alloc] initWithLocation: lat : lon];
    self.weatherViewModel.delegate = self;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", error.localizedDescription);
}

@end
