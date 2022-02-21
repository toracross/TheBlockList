//
//  EmployeeCell.swift
//  TheBlockList
//
//  Created by Wellison Pereira on 2/21/22.
//

import UIKit

final class EmployeeCell: UITableViewCell {
    
    // MARK: - Private Variables
    
    private lazy var employeeImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var employeeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var employeeTeamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var employeeTypeView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 10)))
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var employeeBioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var employeeEmailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var employeePhoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle Events
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(_ employee: Employee) {
        loadImage(urlString: employee.photoUrlSmall)
        setType(type: employee.employeeType)
        employeeNameLabel.text = employee.fullName
        employeeTeamLabel.text = employee.team
        employeeEmailLabel.text = employee.emailAddress
        employeePhoneLabel.text = employee.phoneNumber?.phoneNumberFormat()
        employeeBioLabel.text = employee.biography
    }
    
    // MARK: - Private Methods {
    
    func configureUI() {
        let parentStackView = UIStackView(arrangedSubviews: [configureTopStackView(), configureBottomStackView()])
        parentStackView.axis = .vertical
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(parentStackView)
        NSLayoutConstraint.activate([
            employeeImageView.heightAnchor.constraint(equalToConstant: employeeImageView.frame.height),
            employeeImageView.widthAnchor.constraint(equalToConstant: employeeImageView.frame.width),
            employeeTypeView.heightAnchor.constraint(equalToConstant: employeeTypeView.frame.height),
            employeeTypeView.widthAnchor.constraint(equalToConstant: employeeTypeView.frame.width),
            parentStackView.heightAnchor.constraint(equalToConstant: 125),
            parentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            parentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            parentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            parentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func configureTopStackView() -> UIView {
        let employeeTeamStack = UIStackView(arrangedSubviews: [employeeTeamLabel, employeeTypeView])
        employeeTeamStack.axis = .horizontal
        employeeTeamStack.spacing = 4
        employeeTeamStack.alignment = .center
        employeeTeamStack.distribution = .equalSpacing
        
        let labelStackView = UIStackView(arrangedSubviews: [employeeNameLabel, employeeTeamStack])
        labelStackView.axis = .vertical
        labelStackView.spacing = 4
        labelStackView.alignment = .leading
        labelStackView.distribution = .equalSpacing
        
        let stackView = UIStackView(arrangedSubviews: [employeeImageView, labelStackView])
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.alignment = .leading
        
        return stackView
    }
    
    private func configureBottomStackView() -> UIView {
        let infoStackView = UIStackView(arrangedSubviews: [employeeEmailLabel, employeePhoneLabel])
        infoStackView.axis = .vertical
        infoStackView.spacing = 4
        infoStackView.alignment = .leading
        
        let stackView = UIStackView(arrangedSubviews: [infoStackView, employeeBioLabel])
        stackView.distribution = .fill
        infoStackView.spacing = 4
        stackView.axis = .vertical
        
        return stackView
    }
    
    private func loadImage(urlString: String?) {
        if let urlString = urlString, let url = NSURL(string: urlString) {
            ImageCache.shared.load(url: url) { [weak self] image in
                guard let self = self else { return }
                self.employeeImageView.image = image
            }
        }
    }
    
    private func setType(type: Employee.EmployeeType) {
        switch type {
        case .fullTime:
            employeeTypeView.backgroundColor = .green
        case .partTime:
            employeeTypeView.backgroundColor = .yellow
        case .contractor:
            employeeTypeView.backgroundColor = .blue
        }
    }
    
}

extension EmployeeCell {
    static let identifier = "EmployeeCell"
}
