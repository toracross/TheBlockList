//
//  LoadingView.swift
//  TheBlockList
//
//  Created by Wellison Pereira on 2/21/22.
//

import UIKit

/// A view that displays a loading indicator in the center of the parent's view.
final class LoadingView: UIView {
    
    // MARK: - Private Variables
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    // MARK: - Lifecycle Events
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func start() {
        indicatorView.startAnimating()
    }
    
    public func stop() {
        indicatorView.stopAnimating()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            indicatorView.topAnchor.constraint(equalTo: topAnchor),
            indicatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            indicatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
