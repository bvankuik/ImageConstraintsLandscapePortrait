//
//  ViewController.swift
//  ImageConstraintsLandscapePortrait
//
//  Created by Bart van Kuik on 05/07/2018.
//  Copyright © 2018 DutchVirtual. All rights reserved.
//

import UIKit

// Image by Citobun - Own work, CC BY-SA 4.0, https://commons.wikimedia.org/w/index.php?curid=61540634

class ViewController: UIViewController {
    private let imageView = UIImageView()
    private var imageViewHeightConstraint: NSLayoutConstraint?
    private var imageViewWidthConstraint: NSLayoutConstraint?

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        self.updateView(to: newCollection)
    }
    
    private func updateView(to newCollection: UITraitCollection) {
        if let constraint = self.imageViewHeightConstraint {
            constraint.isActive = false
        }
        
        // Portrait: width/height 85% of device width
        // Landscape: based on device height
        
        if newCollection.verticalSizeClass == .compact {
            self.imageViewHeightConstraint = self.imageView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        } else {
            self.imageViewHeightConstraint = self.imageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85)
        }
        self.imageViewHeightConstraint?.isActive = true
    }
    
    private func makeBlueButton(with title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("\(title)", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title1)
        button.titleLabel?.textColor = .white
        return button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        self.imageView.image = #imageLiteral(resourceName: "1200px-Cafeteria_and_Golden_beaches_August_2017")
        self.imageView.contentMode = .scaleAspectFill
        stackView.addArrangedSubview(self.imageView)

        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        
        let label1 = UILabel()
        label1.text = "Title of label"
        label1.backgroundColor = .darkGray
        label1.textColor = .white
        label1.textAlignment = .center
        label1.font = .preferredFont(forTextStyle: .body)
        labelStackView.addArrangedSubview(label1)

        let label2 = UILabel()
        label2.text = "Subtitle of label"
        label2.backgroundColor = .lightGray
        label2.textAlignment = .center
        label2.font = .preferredFont(forTextStyle: .body)
        labelStackView.addArrangedSubview(label2)
        stackView.addArrangedSubview(labelStackView)

        let secondStackView = UIStackView()
        secondStackView.spacing = 8
        secondStackView.distribution = .fillEqually
        stackView.addArrangedSubview(secondStackView)

        let buttonStackView = UIStackView()
        buttonStackView.spacing = 8
        buttonStackView.axis = .vertical
        (0...3).forEach {
            buttonStackView.addArrangedSubview(self.makeBlueButton(with: "\($0)"))
        }
        secondStackView.addArrangedSubview(buttonStackView)

        let redLabel = UILabel()
        redLabel.backgroundColor = .red
        redLabel.textColor = .white
        redLabel.font = .preferredFont(forTextStyle: .title1)
        redLabel.text = "Special"
        redLabel.textAlignment = .center
        secondStackView.addArrangedSubview(redLabel)
        
        let guide = self.view.safeAreaLayoutGuide
        let constraints = [
            stackView.leftAnchor.constraintEqualToSystemSpacingAfter(guide.leftAnchor, multiplier: 1),
            guide.rightAnchor.constraintEqualToSystemSpacingAfter(stackView.rightAnchor, multiplier: 1),

            scrollView.leftAnchor.constraintEqualToSystemSpacingAfter(guide.leftAnchor, multiplier: 1),
            scrollView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1),
            guide.rightAnchor.constraintEqualToSystemSpacingAfter(scrollView.rightAnchor, multiplier: 1),
            guide.bottomAnchor.constraintEqualToSystemSpacingBelow(scrollView.bottomAnchor, multiplier: 1),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ]
        self.view.addConstraints(constraints)
        
        self.updateView(to: self.traitCollection)
    }
}
