//
//  ViewController.swift
//  WeatherApp
//
//  Created by Tolgahan Sonmez on 6.03.2023.
//

import UIKit
import CoreLocation
import Lottie

class ViewController: UIViewController {
    let locationManager = CLLocationManager()
    var weatherArray : WeatherData?
    var weatherForecast = [CityWeatherData]()
    @IBOutlet weak var labelCordinates: UILabel!
    @IBOutlet weak var labelWeatherCond: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelMax: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var sunnyAnimationView: LottieAnimationView!
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    var weatherTime : String = " "
    var lat : Float = 0.0
    var lon : Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateLocation()
        forecastCollectionView.layer.cornerRadius = 12
        forecastCollectionView.layer.masksToBounds = true
        forecastCollectionView.clipsToBounds = true
    }
    
    @IBAction func currentLocationButton(_ sender: Any) {
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
           
            WeatherApi.shared.getMyLocationWeather(latitude: lat, longitude: lon) { result in
                DispatchQueue.main.async { [self] in
                    switch result {
                    case .success(let WeatherModel):
                        self.weatherArray = WeatherModel
                        self.labelCordinates.text = self.weatherArray?.name
                        self.labelWeatherCond.text = self.weatherArray?.weather.first?.main
                        
                        let feelsTemp: Float = self.weatherArray?.main.feels_like ?? 0.0
                        
                        var feelsTemperatureString: String {
                            return String(format: "%.0f", feelsTemp)
                        }
                        
                        self.labelMax.text = "Feels Like " + feelsTemperatureString + "°C"
                        
                        
                        
                        let temperature: Float = self.weatherArray?.main.temp ?? 0.0
                        var temperatureString: String {
                            return String(format: "%.0f", temperature)
                        }
                        
                        self.labelTemp.text = temperatureString + "°C"
                        let cond = weatherArray?.weather.first?.id
                        //animations
                        loadAnimation(conditionID: cond!)
                        
                        
                    case .failure(let eror):
                        print(eror)
                    }
                }
           
        }
    }
    
    func loadAnimation(conditionID : Int){
        switch conditionID {
        case 200...232:
            //"cloud.bolt"
            sunnyAnimationView = LottieAnimationView(name: "thunderstorm")
            sunnyAnimationView.frame =  CGRect(x: 117 , y: 100, width: 212, height: 145)
            sunnyAnimationView.loopMode = .loop
            view.addSubview(sunnyAnimationView)
            sunnyAnimationView.play()
            
        case 300...321:
            //"cloud.drizzle"
            sunnyAnimationView = LottieAnimationView(name: "rainy")
            sunnyAnimationView.frame =  CGRect(x: 117, y: 100, width: 212, height: 145)
            sunnyAnimationView.loopMode = .loop
            view.addSubview(sunnyAnimationView)
            sunnyAnimationView.play()
            
        case 500...531:
            //"cloud.rain"
            sunnyAnimationView = LottieAnimationView(name: "rainy")
            sunnyAnimationView.frame =  CGRect(x: 117, y: 100, width: 212, height: 145)
            sunnyAnimationView.loopMode = .loop
            view.addSubview(sunnyAnimationView)
            sunnyAnimationView.play()
            
        case 600...622:
            //"cloud.snow"
            sunnyAnimationView = LottieAnimationView(name: "snow")
            sunnyAnimationView.frame =  CGRect(x: 117, y: 100, width: 212, height: 145)
            sunnyAnimationView.loopMode = .loop
            view.addSubview(sunnyAnimationView)
            sunnyAnimationView.play()
            
        case 701...781:
            //"cloud.fog"
            break
        case 800:
            //"sun.max"
            sunnyAnimationView = LottieAnimationView(name: "sunny")
            sunnyAnimationView.frame =  CGRect(x: 117, y: 100, width: 200, height: 145)
            sunnyAnimationView.loopMode = .loop
            view.addSubview(sunnyAnimationView)
            sunnyAnimationView.play()
            
        case 801...804:
            sunnyAnimationView = LottieAnimationView(name: "thunderstorm")
            sunnyAnimationView.frame =  CGRect(x: 117, y: 100, width: 212, height: 145)
            sunnyAnimationView.loopMode = .loop
            view.addSubview(sunnyAnimationView)
            sunnyAnimationView.play()
            
        default:
            //"cloud"
            return
        }
    }
    private func updateLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        WeatherApi.shared.getCitiesWeather(cityName: "Ankara") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cityModel):
                    self?.weatherForecast = [cityModel]
                    self?.forecastCollectionView.reloadData()
                    self?.labelCordinates.text = cityModel.city.name
                    self?.labelWeatherCond.text = cityModel.list.first?.weather.first?.main
                    
                    let feelsTemp: Float = cityModel.list.first?.main.feels_like ?? 0.0
                    
                    var feelsTemperatureString: String {
                        return String(format: "%.0f", feelsTemp)
                    }
                    
                    self?.labelMax.text = "Feels Like " + feelsTemperatureString + "°C"
                    
                    let condID = self?.weatherForecast.first?.list.first?.weather.first?.id
                    print(condID ?? 301)
                    self?.loadAnimation(conditionID: condID!)
                case .failure(let eror):
                    print(eror)
                }
            }
        }
    }
}

extension ViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            lat = Float(location.coordinate.latitude)
            lon = Float(location.coordinate.longitude)
            WeatherApi.shared.getMyLocationWeather(latitude: lat, longitude: lon) { result in
                DispatchQueue.main.async { [self] in
                    switch result {
                    case .success(let WeatherModel):
                        self.weatherArray = WeatherModel
                        self.labelCordinates.text = self.weatherArray?.name
                        self.labelWeatherCond.text = self.weatherArray?.weather.first?.main
                        
                        let feelsTemp: Float = self.weatherArray?.main.feels_like ?? 0.0
                        
                        var feelsTemperatureString: String {
                            return String(format: "%.0f", feelsTemp)
                        }
                        
                        self.labelMax.text = "Feels Like " + feelsTemperatureString + "°C"
                        
                        
                        
                        let temperature: Float = self.weatherArray?.main.temp ?? 0.0
                        var temperatureString: String {
                            return String(format: "%.0f", temperature)
                        }
                        
                        self.labelTemp.text = temperatureString + "°C"
                        let cond = weatherArray?.weather.first?.id
                        //animations
                        loadAnimation(conditionID: cond!)
                        
                        
                    case .failure(let eror):
                        print(eror)
                    }
                }
            }
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error from didFailWithError : \(error)")
    }
}

extension ViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        weatherForecast.removeAll()
        WeatherApi.shared.getCitiesWeather(cityName: searchBar.text ?? "") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cityModel):
                    self?.weatherForecast.removeAll()
                    self?.weatherForecast = [cityModel]
                    let condID = self?.weatherForecast.first?.list.first?.weather.first?.id
                    print(condID ?? 301)
                    self?.loadAnimation(conditionID: condID!)
                    self?.forecastCollectionView.reloadData()
                    self?.labelCordinates.text = cityModel.city.name
                    self?.labelWeatherCond.text = cityModel.list.first?.weather.first?.main
                    
                    let feelsTemp: Float = self?.weatherForecast.first?.list.first?.main.feels_like ?? 0.0
                    
                    var feelsTemperatureString: String {
                        return String(format: "%.0f", feelsTemp)
                    }
                    
                    self?.labelMax.text = "Feels Like " + feelsTemperatureString + "°C"
                    
                    let temperature: Float = self?.weatherForecast.first?.list.first?.main.temp ?? 0.0
                    var temperatureString: String {
                        return String(format: "%.0f", temperature)
                    }
                    
                    self?.labelTemp.text = temperatureString + "°C"
                    
                    self?.searchBar.endEditing(true)
                case .failure(let eror):
                    print(eror)
                }
            }
            
        }
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (weatherForecast.first?.list.count) ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weatherForecast = weatherForecast.first?.list[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as?
        ForecastCollectionViewCell
        cell?.labelTemp.text = String(weatherForecast?.main.temp ?? 0.0) + "°"
        let dateFormatter = DateFormatter()
        let dateString = weatherForecast?.dt_txt ?? ""
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd/MM HH"
            dateFormatter.locale = Locale(identifier: "en")
            cell?.labelDate.text = dateFormatter.string(from: date)
        }
        let viewModel = CityWeatherViewModel(temperature: (weatherForecast?.main.temp ?? 0.0), conditionID: (weatherForecast?.weather.first!.id ?? 302))
        cell?.configure(with: viewModel)
        return cell!
    }
    
    
}


/*  thunderstormAnimationView.isHidden = true
 snowAnimatonView.isHidden = true
 sunnyAnimationView.isHidden = true
 view.addSubview(rainyAnimationView)
 rainyAnimationView.frame = CGRect(x: 100, y: 280, width: 212, height: 145)
 rainyAnimationView.loopMode = .loop
 rainyAnimationView.play()*/
