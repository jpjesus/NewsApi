//
//  NewsViewController.swift
//  TheNews
//
//  Created by Jesus Parada on 10/13/19.
//  Copyright © 2019 Jesus Parada. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsCollectionView: UICollectionView! {
        didSet {
            newsCollectionView.showsHorizontalScrollIndicator = false
            newsCollectionView.showsVerticalScrollIndicator = false
            newsCollectionView.register(UINib(nibName: String(describing: NewsCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: "NewsCollectionViewCell")
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.tintColor = .red
            activityIndicator.hidesWhenStopped = true
            activityIndicator.color = .red
        }
    }
    private let viewModel: NewsViewModel
    private var counter: Int = 1
    private let disposeBag = DisposeBag()
    private let isLastCell: PublishSubject<Int> = PublishSubject<Int>()
    private var loadMoreNews:
        Observable<Int> {
        return isLastCell.asObservable()
    }
    private var articles: [Article] = []
    
    init(with viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: NewsViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

//MARK: - private methods

extension NewsViewController {
    
    private func bind() {
        let config: NewsIntput = (
            collectionView: newsCollectionView.rx,
            navigation: navigationController,
            loadPage: loadMoreNews,
            indicator: activityIndicator
        )
        let output = viewModel.setup(input:config)
        
        isLastCell.onNext(counter)
        
        newsCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        output.selectCell
            .subscribe(onNext: { [weak self] article in
                guard let self = self else { return }
                self.viewModel.showFullArticle(with: article.url, navigation: self.navigationController)
            }).disposed(by: disposeBag)
        
        self.articles = output.articles
    }
}
//MARK: - CollectionView delegate

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.articles.count - 1 {
            counter = counter + 1
            isLastCell.onNext((counter))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch UIApplication.shared.statusBarOrientation {
            
        case .portrait where !Int.isRowNumberModule(of: indexPath.row, numberDivide: 7):
            return CGSize(width: setWidhtSize(2, collectionViewLayout: collectionViewLayout, collectionView: collectionView), height: self.view.bounds.height/3)
        case .landscapeLeft where !Int.isRowNumberModule(of: indexPath.row, numberDivide: 7),
             .landscapeRight where !Int.isRowNumberModule(of: indexPath.row, numberDivide: 7):
            return CGSize(width: setWidhtSize(3, collectionViewLayout: collectionViewLayout, collectionView: collectionView), height: self.view.bounds.height)
        case .landscapeLeft,
             .landscapeRight:
             return CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
        case .portrait:
            return CGSize(width: self.view.bounds.width, height: self.view.bounds.height/2.5)
        default:
            return CGSize.zero
        }
    }
    
    
    private func setWidhtSize(_ numberOfCells: Int, collectionViewLayout: UICollectionViewLayout, collectionView: UICollectionView) -> CGFloat {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        let spacing = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfCells - 1))
        
        return (collectionView.bounds.width - spacing) / CGFloat(numberOfCells)
    }
}

