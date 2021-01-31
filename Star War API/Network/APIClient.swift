import Foundation



struct APIClient
{
    static let root = "https://swapi.dev/"
    
    static
    func fetchResouce<T: Codable>(_ url: URL,
                                  completion: @escaping (Result<T, NSError>) -> Void)
    {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error as NSError?
            {
                completion(Result.failure(error))
            }
            else if let data = data
            {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                        let container = try decoder.singleValueContainer()
                        let dateString = try container.decode(String.self)
                        
                        if let date = DateFormatter.iso8601Full.date(from: dateString)
                        {
                            // .iso8601 with milliseconds
                            return date
                        }
                        else if let date = ISO8601DateFormatter().date(from: dateString)
                        {
                            return date
                        }
                        
                        throw DecodingError.dataCorruptedError(in: container,
                            debugDescription: "Cannot decode date string \(dateString)")
                    })
                    
                    let response = try decoder.decode(T.self, from: data)
                    completion(Result.success(response))
                }
                catch let error as NSError {
                    completion(Result.failure(error))
                }
            }
        }.resume()
    }
}


extension APIClient
{
    static
    func fetchResources<T: Codable>(_ urlStrings: [String]?,
                                    type: T.Type,
                                    completion: @escaping (([T], [String]) -> Void))
    {
        guard let urlStrings = urlStrings else {
            completion([], [])
            return
        }
        
        var arrModels: [T] = []
        var errorUrlStrings: [String] = []
        
        let group = DispatchGroup()
        
        for urlString in urlStrings
        {
            guard let url = URL(string: urlString) else {
                errorUrlStrings.append(urlString)
                continue
            }
            
            group.enter()
            
            fetchResouce(url) { (resp: Result<T, NSError>) in
                switch resp {
                case .success(let model):
                    arrModels.append(model)
                    
                case .failure:
                    errorUrlStrings.append(urlString)
                    break
                }
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(arrModels, errorUrlStrings)
        }
    }
}
