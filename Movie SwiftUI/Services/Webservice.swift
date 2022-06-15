

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct LoginRequestBody: Codable {
    let username: String
    let password: String
}

struct LoginResponse: Codable {
    let validTo: String
    let token: String
    
}

class Webservice {
    
    func login(username: String, password: String, completion: @escaping (Result< LoginResponse , NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://iosdevtest.herokuapp.com/api/login") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        //let loginString = String(format: "%@:%@", "iosdeveloper", "novartis2022") 
        let loginString = String(format: "%@:%@", username, password)
        
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let account = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(account))
            
        }.resume()
        
        
    }
    
    func getAllMovies( completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://iosdevtest.herokuapp.com/api/movies") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        let token = UserDefaults.standard.string(forKey: "Token")!
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let accounts = try? JSONDecoder().decode([Movie].self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(accounts))
            
        }.resume()
    }
}
