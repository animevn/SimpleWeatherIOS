import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var lbTemp: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    
    private var weatherManager = WeatherManager()
    private var getLocation = GetLocation()
    
    deinit {
        print("The class \(type(of: self)) was remove from memory")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("WelcomeView did load")
        weatherManager.weatherDelegate = self
        getLocation.locationDelegate = self
    }
    
    @IBAction func onSearchClick(_ sender: UIButton) {
        weatherManager.getWeather(city: tfSearch.text!)
        tfSearch.endEditing(true)
    }
    
    @IBAction func onLocationClick(_ sender: UIButton) {
        getLocation.startUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("WelcomeView will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("WelcomeView did appear")
    }
       
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("WelcomeView will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("WelcomeView did appear")
    }


}

extension ViewController:WeatherDelegate{
    
    func onWeatherResult(weather: WeatherModel) {
        print("update")
        ivIcon.image = UIImage(named: weather.iconString)
        lbTemp.text = weather.tempString
        lbCity.text = weather.cityName
    }
    
    func onWeatherError(error: Error) {
        print(error)
    }
    
}

extension ViewController:LocationDelegate{
    func onLocationResult(coord: Coord) {
        weatherManager.getWeather(coord: coord)
    }
    
    func onLocationError(error: Error?) {
        print("error")
    }
}







