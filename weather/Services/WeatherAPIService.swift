//
//  WeatherAPIService.swift
//  weather
//
//  
//

import Foundation

class WeatherAPIService {
    public static let shared = WeatherAPIService()
    
    static let api = "https://api.openweathermap.org/data/2.5"
    static let api_key = "5a3b3e98baa7409c112e6164dacc03bb"
    static let endpoint_weather = "/weather"
    
    public enum APIError: Error {
        case error(_ errorString: String)
    }
    
    public func getJSON<T: Decodable>(urlString: String,
                                      dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                      keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                      completion: @escaping (Result<T,APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.error("Error: \(error.localizedDescription)")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.error(NSLocalizedString("Error: Data us corrupt.", comment: ""))))
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
                return
            } catch let decodingError {
                completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))
                return
            }
            
        }.resume()
    }
    
    static func getCurrentWeather(lat: Double, lon: Double) async -> CurrentWeather? {
        // MARK: Equivalent to
        // https://api.openweathermap.org/data/2.5/weather?lat=<lat>&lon=<lon>&appid=<API key>
        var endpointQuery: String {
            api +
            endpoint_weather +
            "?" +
            "lat=\(lat)" +
            "&lon=\(lon)" +
            "&appid=\(api_key)"
        }
        return await fetchCurrentWeather(from: endpointQuery)
    }
    
    static func fetchCurrentWeather(from query: String) async -> CurrentWeather? {
        guard let validQuery = URL(string: query) else {
            print("Invalid URL.")
            return nil
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: validQuery) else {
            print("Failede to get current weather.")
            return nil
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(CurrentWeather.self, from: data)
        } catch {
            print(error)
        }
        
        return nil
    }
    
}
