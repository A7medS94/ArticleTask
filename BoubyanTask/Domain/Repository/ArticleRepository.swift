//
//  ArticleRepository.swift
//  BoubyanTask
//
//  Created by Ahmed Samir on 11/06/2022.
//

import Foundation
import Moya
import Combine

protocol ArticleRepositoryProtocol {
    func getArticles(period: PeriodEnum) -> AnyPublisher<BaseAPIModel<[ArticleModel]>?, Error>
}

class ArticleRepository: ArticleRepositoryProtocol {

    private let provider: MoyaProvider<ArticleService>
    private var cancellables = Set<AnyCancellable>()
    
    
    init(provider: MoyaProvider<ArticleService>) {
        self.provider = provider
    }
    
    func getArticles(period: PeriodEnum) -> AnyPublisher<BaseAPIModel<[ArticleModel]>?, Error> {
        return Future<BaseAPIModel<[ArticleModel]>?, Error> { [weak self] promise in
            guard let self = self else { return }
            
            self.provider.request(.getMostViewed(period: period)) { result in
                switch result {
                case .success(let success):
                    do {
                        let article = try JSONDecoder().decode(BaseAPIModel<[ArticleModel]>.self, from: success.data)
                        promise(.success(article))
                    } catch {
                        promise(.failure(error))
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }.eraseToAnyPublisher()
    }
}

