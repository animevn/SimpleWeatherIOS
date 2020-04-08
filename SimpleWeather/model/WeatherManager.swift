import Foundation

protocol WeatherDelegate {
    func onWeatherResult(weather:WeatherModel?)
    func onWeatherError(error:Error?)
}

struct WeatherManager{
    
    let appid = "1a9dc82f0a3a7e535acb3ac84407ad81"
    let url = "https://api.openweathermap.org/data/2.5/weather?appid="
    var weatherDelegate:WeatherDelegate?
    var getLocation:GetLocation?
    
    private func parse(data:Data?, response:URLResponse?, error:Error?)->WeatherModel?{
        if error != nil{
            weatherDelegate?.onWeatherError(error: error)
            return nil
        }
        
        guard let data = data else {return nil}
        do{
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            let id = weatherData.weather[0].id
            let temp = weatherData.main.temp
            let city = weatherData.name
            return WeatherModel(iconId: id, cityName: city, temp: temp)
        }catch{
            return nil
        }
    }
    
    private func performRequest(urlString:String){
        guard let url = URL(string: urlString) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url){(data, response, error) in
            let weatherModel = self.parse(data: data, response: response, error: error)
            DispatchQueue.main.async {
                self.weatherDelegate?.onWeatherResult(weather: weatherModel)
            }
        }
        task.resume()
    }
    
    func getWeather(city:String){
        let urlString = url + appid + "&units=metric&q=" + city
        performRequest(urlString: urlString)
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
