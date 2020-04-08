import Foundation

struct WeatherModel{
    
    let iconId:Int
    let cityName:String
    let temp:Double
    
    var tempString:String{
        return String(format: "%.1f", temp)
    }
    
    var iconString:String{
        switch iconId {
        case 200...232:
            return "bolt"
        case 300...321:
            return "drizzle"
        case 500...531:
            return "rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "fog"
        case 800:
            return "sun"
        case 801...804:
            return "bolt"
        default:
            return "cloud"
        }
    }
    
}
