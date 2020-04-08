import Foundation

class GetWeather{
    
    let appid = "1a9dc82f0a3a7e535acb3ac84407ad81"
    let url = "https://api.openweathermap.org/data/2.5/weather?appid="

    private func parse(data:Data?, response:URLResponse?, error:Error?)->WeatherModel?{
        if error != nil{
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
            return nil
        }
    }
    
    private func performRequest(urlString:String, completion:@escaping (WeatherModel)->Void){
        guard let url = URL(string: urlString) else {
            print("enter sth else")
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url){(data, response, error) in
            guard let weatherModel = self.parse(data: data, response: response, error: error) else{
                return
            }
            completion(weatherModel)
        }
        task.resume()
    }
    
    func getWeather(city:String, completion:@escaping (WeatherModel)->Void){
        let urlString = url + appid + "&units=metric&q=" + city
        performRequest(urlString: urlString, completion: completion)
    }
    
    func getWeather(coord:Coord, completion:@escaping (WeatherModel)->Void){
        let urlString = url + appid + "&units=metric&lat=\(coord.lat)&lon=\(coord.lon)"
        performRequest(urlString: urlString, completion: completion)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
