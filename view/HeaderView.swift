//
//  HeaderView.swift
//  Sports App
//
//  Created by Haneen Medhat on 20/05/2024.
//

import UIKit

class HeaderView: UICollectionReusableView {

    static let reuseIdentifier = "HeaderView"

        private let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .black
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        }
        
        private func setupView() {
            addSubview(titleLabel)
            
            // Set constraints for titleLabel
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
        }
        
        func configure(with title: String) {
            titleLabel.text = title
        }
}
