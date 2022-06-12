//
//  ArticlesVC.swift
//  BoubyanTask
//
//  Created by Ahmed Samir on 11/06/2022.
//

import UIKit
import Combine
import SVProgressHUD

class ArticlesVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var articleTableView: UITableView! {
        didSet {
            articleTableView.dataSource = self
            articleTableView.delegate = self
            articleTableView.register(UINib(nibName: viewModel.cellIdentifier, bundle: nil), forCellReuseIdentifier: viewModel.cellIdentifier)
            articleTableView.refreshControl = refreshControl
        }
    }
    
    //MARK: - Vars
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.refreshContent(_:)), for: .valueChanged)
        return refresh
    }()
    
    private lazy var noImagesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.text = viewModel.noImagesText
        label.textAlignment = .center
        return label
    }()
    
    var viewModel: ArticlesViewModel!
    var cancelable = Set<AnyCancellable>()
    var progressHud = SVProgressHUD.self
    weak var coordinator: MainCoordinator?
    
    
    //MARK: - ViewLifeCycle
    convenience init(viewModel: ArticlesViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        bindViewModel()
        viewModel.getArticles()
    }
    
    
    //MARK: - Methods
    private func setupUI() {
        navigationItem.title = viewModel.navTitle
        let filter = UIBarButtonItem(image: UIImage(systemName: "slider.vertical.3"), style: .plain, target: self, action: #selector(filterBtnDidTapped))
        navigationItem.rightBarButtonItems = [filter]
    }
    
    @objc private func refreshContent(_ sender: AnyObject) {
        viewModel.refresh()
    }
    
    private func bindViewModel() {
        viewModel.$dataStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self, let state = state else { return }
                switch state {
                case .loading:
                    self.startLoading()
                case .finished(let outcome):
                    self.finishLoading()
                    self.refreshControl.endRefreshing()
                    switch outcome {
                    case .success:
                        break
                    case .failure(let error):
                        self.displayAlert(title: "Error", message: error.localizedDescription)
                    }
                }}
            .store(in: &cancelable)
        
        viewModel.$articles
            .receive(on: DispatchQueue.main)
            .sink { [weak self] articles in
                guard let self = self, let articles = articles else {
                    self?.refreshControl.endRefreshing()
                    return
                }
                if articles.count == 0 {
                    self.articleTableView.backgroundView = self.noImagesLabel
                } else {
                    self.articleTableView.backgroundView = nil
                }
                self.articleTableView.reloadData()
            }
            .store(in: &cancelable)
    }
    
    private func startLoading() {
        self.progressHud.setContainerView(self.view)
        self.progressHud.setRingThickness(10)
        self.progressHud.setBackgroundColor(.clear)
        self.progressHud.setForegroundColor(.black)
        self.progressHud.setDefaultMaskType(SVProgressHUDMaskType.black)
        self.progressHud.show()
    }
    
    private func finishLoading() {
        self.progressHud.dismiss()
    }
    
    private func displayAlert(title: String?, message: String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    @objc private func filterBtnDidTapped() {
        let alert = UIAlertController(title: "Period", message: "Select one of those three available periods!!", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "One", style: .default, handler: { [weak self] _ in
            guard let self = self else {return}
            self.viewModel.period = .one
        }))
        alert.addAction(UIAlertAction(title: "Seven", style: .default, handler: { [weak self] _ in
            guard let self = self else {return}
            self.viewModel.period = .seven
        }))
        alert.addAction(UIAlertAction(title: "Thirty", style: .default, handler: { [weak self] _ in
            guard let self = self else {return}
            self.viewModel.period = .thirty
        }))
        present(alert, animated: true, completion: nil)
    }
}
