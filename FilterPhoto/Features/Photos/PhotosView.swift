//
//  PhotosView.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import UIKit

// MARK: - PhotosViewDelegate
protocol PhotosViewDelegate: AnyObject {
    func didSelectPhoto(urlString: String)
}

// MARK: - PhotosView
final class PhotosView: UIView {
    
    // MARK: - UI
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Properties
    private let dataSource: PhotosDataSource
    
    weak var delegate: PhotosViewDelegate? {
        didSet {
            dataSource.delegate = delegate
        }
    }
    
    // MARK: - Init
    init(dataSource: PhotosDataSource) {
        self.dataSource = dataSource
        super.init(frame: .zero)
        setupUI()
        configureTableView()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .white
    }
    
    func configureTableView() {
        setupTableViewDelegates()
        setupTableViewRegistration()
        setupViewHierarchy()
        setupTableViewLayout()
    }
    
    private func setupTableViewDelegates() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.prefetchDataSource = dataSource
    }
    
    private func setupTableViewRegistration() {
        tableView.register(PhotoCell.self,
                           forCellReuseIdentifier: PhotoCell.id)
    }
    
    private func setupViewHierarchy() {
        addSubview(tableView)
    }
    
    private func setupTableViewLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func update(with items: [String]) {
        dataSource.items = items
        tableView.reloadData()
    }
}
