//
//  RickAndMortyNetworkService.swift
//  RickAndMortyTestApp
//
//  Created by Fisenko Irina on 15.11.2023.
//

import UIKit

protocol RickAndMortyNetworkService {
    func getCharacters(page: Int, completion: @escaping (Result<Characters, Errors>) -> Void)
    func getAvatar(url: URL, completion: @escaping(UIImage) -> Void)
    func getEpisode(url: URL, completion: @escaping (Result<Episode, Errors>) -> Void)
    func getLocation(string: String, completion: @escaping (Result<Planet, Errors>) -> Void)
}

enum Errors: Error {
    case invalidURL
    case invalidState
    case decodingError
    case noData
}

final class RickAndMortyNetworkServiceImpl: RickAndMortyNetworkService {

    struct API {
        static let character = "https://rickandmortyapi.com/api/character/?page="
    }
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = .init()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    func getAvatar(url: URL, completion: @escaping(UIImage) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                completion(image!)
            }
        }
    }
        
    func getCharacters(page: Int, completion: @escaping (Result<Characters, Errors>) -> Void) {
        guard let url = URL(string: API.character + "\(page)") else {
            completion(.failure(Errors.invalidURL))
            return
        }
        
        getRequest(url: url, completion: completion)
    }
    
    func getEpisode(url: URL, completion: @escaping (Result<Episode, Errors>) -> Void) {
        getRequest(url: url, completion: completion)
    }
        
    func getLocation(string: String, completion: @escaping (Result<Planet, Errors>) -> Void) {
        
        guard let url = URL(string: string) else {
            completion(.failure(Errors.invalidURL))
            return
        }
        getRequest(url: url, completion: completion)
    }
    
    private func getRequest<T:Decodable>(url: URL, completion: @escaping (Result<T, Errors>) -> Void) {
        
        urlSession.dataTask(with: URLRequest(url: url)) { [jsonDecoder] data, _, error in
            switch (data, error) {
            case let (.some(data), nil):
                do {
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    let data = try jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(data))
                    }
                } catch {
                    completion(.failure(Errors.decodingError))
                }
            case let (nil, .some(error)):
                print(error.localizedDescription)
                completion(.failure(Errors.noData))
            default:
                completion(.failure(Errors.invalidState))
            }
        }.resume()
    }
}
