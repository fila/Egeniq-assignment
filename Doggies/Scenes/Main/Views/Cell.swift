//
//  Cell.swift
//  Doggies
//
//  Created by Irina Filkovskaya on 07/10/2020.
//

import UIKit
import Nuke

class DogCell: UITableViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lifeSpanStackView: UIStackView!
    @IBOutlet weak var lifeSpanLabel: UILabel!
    @IBOutlet weak var bredForStackView: UIStackView!
    @IBOutlet weak var bredForLabel: UILabel!
    @IBOutlet weak var temperamentStackView: UIStackView!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var dogImageView: UIImageView!
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        hideStackViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        let labels = [titleLabel, lifeSpanLabel, bredForLabel, temperamentLabel]
        labels.forEach { label in
            label?.text = ""
        }
        
        hideStackViews()
        dogImageView.image = nil
    }
    
    // MARK: - Configure
    func configure(with model: ViewModel) {
        titleLabel.text = model.title
        
        if !model.lifeSpan.isEmpty {
            lifeSpanStackView.isHidden.toggle()
            lifeSpanLabel.text = model.lifeSpan
        }
        
        if !model.bredFor.isEmpty {
            bredForStackView.isHidden.toggle()
            bredForLabel.text = model.bredFor
        }
        
        if !model.temperament.isEmpty {
            temperamentStackView.isHidden.toggle()
            temperamentLabel.text = model.temperament
        }
    }
    
    // MARK: - Privates
    private func hideStackViews() {
        let stackViews = [lifeSpanStackView, bredForStackView, temperamentStackView]
        stackViews.forEach { view in
            view?.isHidden = true
        }
    }
}
