//
//  NewsViewModel.swift
//  TheNews
//
//  Created by Jesus Parada on 10/13/19.
//  Copyright © 2019 Jesus Parada. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources
import Moya

typealias NewsIntput = (
    collectionView: Reactive<UICollectionView>,
    navigation: UINavigationController?,
    loadPage: Observable<Int>
)

typealias NewtOutput = (
    section: Disposable,
    selectCell: Observable<Article>,
    articles: [Article]
)

class NewsViewModel {
    
    private let provider: MoyaProvider<NewsAPI>
    var articles: [Article] = []
    
    init(with provider: MoyaProvider<NewsAPI>) {
        self.provider = provider
    }
    
    func setup(input: NewsIntput) -> NewtOutput {
        
        let news =
            input.loadPage.flatMap { [weak self] page -> Observable<News> in
                guard let self = self else { return Observable.just(News()) }
                return self.provider.rx.request(.getTopHeadlines(page: page, pageSize: 21))
                    .asObservable()
                    .map(News.self)
                    .retry(3)
        }
        
        let dataSource = createDataSource()
        
        let section = news.asObservable()
            .map(setArticles)
            .filter { $0.count > 0 }
            .bind(to: input.collectionView.items(dataSource: dataSource))
        
        let selectCell = input.collectionView.modelSelected(Article.self)
            .asObservable()
        return (section: section,
                selectCell: selectCell,
                articles: articles)
    }
}

extension NewsViewModel {
    private func createDataSource() -> RxCollectionViewSectionedReloadDataSource<ArticleSectionModel> {
        let dataSource =
            RxCollectionViewSectionedReloadDataSource<ArticleSectionModel>(configureCell:{ (dataSource: CollectionViewSectionedDataSource<ArticleSectionModel>, collectionView: UICollectionView, indexPath: IndexPath, item: Article) in
                guard let cell =
                    collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NewsCollectionViewCell.self), for: indexPath) as? NewsCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let isTopHeadLine: NewsType = Int.isRowNumberModule(of: indexPath.row, numberDivide: 7) ? .headline : .normal
                cell.buildCell(with: item, type: isTopHeadLine)
                return cell
            })
        return dataSource
    }
    
    private func setArticles(for news: News) -> [ArticleSectionModel] {
        var results: [ArticleSectionModel] = []
        self.articles += news.articles
        results.append(ArticleSectionModel(header: "", items: self.articles))
        return results
    }
}
