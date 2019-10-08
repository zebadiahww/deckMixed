//
//  ZWWCardViewController.swift
//  DeckObjC
//
//  Created by Zebadiah Watson on 10/8/19.
//  Copyright © 2019 Zebadiah Watson. All rights reserved.
//

import UIKit

class ZWWCardViewController: UIViewController {
    
    var cards: [ZWWCard] = []
    
    @IBOutlet weak var drawCardButton: UIButton!
    @IBOutlet weak var cardImageView: UIImageView!
    
    @IBOutlet weak var suitLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawCard()

        // Do any additional setup after loading the view.
    }

    
    //Actions

    @IBAction func drawCardButtonTapped(_ sender: UIButton) {
        drawCard()
    }
    
    
    
    
    func drawCard(){
        ZWWCardController.shared()?.drawNewCard(1, completion: { (cards) in
            guard let cards = cards else { return }
            let card = cards[0]
            ZWWCardController.shared()?.fetchImage(card, completion: { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self.cardImageView.image = image
                    self.suitLabel.text = card.suit
                }
            })
        })
    }
}// End of Class
