//
//  ArticlesViewModel.swift
//  BoubyanTask
//
//  Created by Ahmed Samir on 12/06/2022.
//

import Foundation
import Combine

protocol ArticlesViewModelProtocol {
    var dataStatus: DataState? { get }
    var articles: [ArticleModel]? { get }
    var error: String? { get }
    var cellIdentifier: String { get }
    var navTitle: String { get }
    var noImagesText: String { get }
}

extension ArticlesViewModelProtocol {
    
    var dataStatus: DataState? {
        return .none
    }
    var cellIdentifier: String {
        return "ArticleTableViewCell"
    }
    var navTitle: String {
        return "Articles"
    }
    
    var noImagesText: String {
        return "No results..."
    }
}

class ArticlesViewModel: ArticlesViewModelProtocol {
    
    @Published private(set) var dataStatus: DataState?
    @Published private(set) var articles: [ArticleModel]?
    @Published private(set) var error: String?
    var period: PeriodEnum = .one {
        didSet {
            refresh()
        }
    }
    private var repository: ArticleRepository!
    private var cancellables = Set<AnyCancellable>()
    
    
    init(repository: ArticleRepository) {
        self.repository = repository
    }
    
    
    func getArticles() {

        dataStatus = .loading
        repository.getArticles(period: period)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error.localizedDescription
                    self?.dataStatus = .finished(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.dataStatus = .finished(.success)
                self.articles = value?.results
            })
            .store(in: &cancellables)
    }
    

    func refresh() {
        articles?.removeAll()
        getArticles()
    }
    
    
    var numberOfRows: Int {
        return articles?.count ?? 0
    }
    
    
    func getRowAtIndex(_ index: Int) -> ArticleModel? {
        return articles?[index]
    }
}
