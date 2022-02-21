//
//  LoadingView.swift
//  TheBlockList
//
//  Created by Wellison Pereira on 2/21/22.
//

import UIKit

/// A view that displays an empty state for the parent view.
final class EmptyView: UIView {
    
    // MARK: - Private Variables
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "No Employees"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Tap the refresh button to search for employees."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    // MARK: - Private Methods
    
    private func configureUI() {
        let labelStackView = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis = .vertical
        labelStackView.alignment = .center
        labelStackView.spacing = 16
        addSubview(labelStackView)
        
        NSLayoutConstraint.activate([
            labelStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
