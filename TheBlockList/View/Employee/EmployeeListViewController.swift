//
//  EmployeeViewController.swift
//  TheBlockList
//
//  Created by Wellison Pereira on 2/21/22.
//

import UIKit

final class EmployeeListViewController: UIViewController {
    
    // MARK: - Private Variables
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: EmployeeCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emptyView: EmptyView = {
        let view = EmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var viewModel: EmployeeListViewModel!
    
    // MARK: - Lifecycle Events
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = EmployeeListViewModel(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureNavigationBar()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        title = "Employee List"
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(emptyView)
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        toggleLoadingState(show: false)
        toggleEmptyState(show: true)
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(fetchEmployees))
    }
    
    @objc private func fetchEmployees() {
        viewModel.fetchEmployees()
    }

}

// MARK: - ViewModel Delegate Methods

extension EmployeeListViewController: EmployeeListViewDelegate {
    func viewStateUpdated(state: EmployeeListViewModel.State) {
        switch state {
        case .ready:
            toggleReadyState()
        case .loading:
            toggleLoadingState(show: true)
            toggleEmptyState(show: false)
        case .empty:
            toggleEmptyState(show: true)
            toggleLoadingState(show: false)
        }
    }
    
    private func toggleReadyState() {
        DispatchQueue.main.async {
            self.toggleEmptyState(show: false)
            self.toggleLoadingState(show: false)
            self.tableView.reloadData()
        }
    }
    
    private func toggleLoadingState(show: Bool) {
        DispatchQueue.main.async {
            self.loadingView.isHidden = !show
            self.loadingView.isUserInteractionEnabled = show
            show ? self.loadingView.start() : self.loadingView.stop()
        }
    }
    
    private func toggleEmptyState(show: Bool) {
        DispatchQueue.main.async {
            self.emptyView.isHidden = !show
            self.emptyView.isUserInteractionEnabled = show
        }
    }
}

// MARK: - UITableViewDelegate Methods

extension EmployeeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.state == .ready else { return }
    }

}

// MARK: - UITableViewDataSource Methods

extension EmployeeListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.identifier, for: indexPath) as? EmployeeCell else { return UITableViewCell() }
        cell.configure(viewModel.employees[indexPath.row])
        return cell
    }

}
