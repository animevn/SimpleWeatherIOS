import Foundation

protocol WeatherDelegate:class{
    func onWeatherResult(weather:WeatherModel)
    func onWeatherError(error:Error)
}

struct WeatherManager{
    
    let appid = "1a9dc82f0a3a7e535acb3ac84407ad81"
    let url = "https://api.openweathermap.org/data/2.5/weather?appid="
    weak var weatherDelegate:WeatherDelegate?
//    private var getLocation:GetLocation
//    
//    init() {
//        getLocation = GetLocation()
//        getLocation.locationDelegate = self
//    }
    
    private func parse(data:Data?, response:URLResponse?, error:Error?)->WeatherModel?{
        if error != nil{
            weatherDelegate?.onWeatherError(error: error!)
            return nil
        }
        
        guard let data = data else {
            print("error data")
            return nil
            
        }
        do{
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            let id = weatherData.weather[0].id
            let temp = weatherData.main.temp
            let city = weatherData.name
            return WeatherModel(iconId: id, cityName: city, temp: temp)
        }catch{
            weatherDelegate?.onWeatherError(error: error)
            return nil
        }
    }
    
    private func performRequest(urlString:String){
        guard let url = URL(string: urlString) else {
            print("enter sth else")
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url){(data, response, error) in
            guard let weatherModel = self.parse(data: data, response: response, error: error) else{
                return
            }
            DispatchQueue.main.async {
                self.weatherDelegate?.onWeatherResult(weather: weatherModel)
                print(weatherModel.cityName)
            }
        }
        task.resume()
    }
    
    func getWeather(city:String){
        let urlString = url + appid + "&units=metric&q=" + city
        performRequest(urlString: urlString)
    }
    
    func getWeather(coord:Coord){
        let urlString = url + appid + "&units=metric&lat=\(coord.lat)&lon=\(coord.lon)"
        performRequest(urlString: urlString)
    }
    
//    func onLocationResult(coord: Coord) {
//        let urlString = url + appid + "&units=metric&lat=\(coord.lat)&lon=\(coord.lon)"
//        performRequest(urlString: urlString)
//    }
//
//    func onLocationError(error: Error?) {
//        if error != nil {
//            print(error!)
//        }
//    }
    
    
    
    
    
    
    
    
    
    
}
