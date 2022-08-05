//
//  ViewController.swift
//  Concentraton
//
//  Created by 1C on 27/03/2022.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        false
    }
    
    private lazy var game = Concentration(numberOfCardsPair: numberOfCardsPair)
    
//    override var vclLoggingName: String {
//        return "Game"
//    }
    
    var numberOfCardsPair: Int {
        return (visibleCardsButton.count/2)+1
    }
            
    override func viewDidLoad(){
        super.viewDidLoad()

        refreshUIView()
        updateViewFromTheme()
    }
   
   
    private func updateViewFromTheme() {
        view.backgroundColor = themes?.backGroundView ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let backGroundColorCard = themes?.backColorOfCard ?? #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        for index in visibleCardsButton.indices {
            visibleCardsButton[index].backgroundColor = backGroundColorCard
        }
//        updateNewGameButton()
    }
    
//    private func updateNewGameButton() {
//        let backColor = themes?.backColorOfCard
//        NewGameButton.setTitleColor(backColor ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
//        let attributes: [NSAttributedString.Key : Any] = [
//            .strokeColor: backColor ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
//            .strokeWidth: 5.0
//        ]
//        let attributedString = NSAttributedString.init(string: "New game", attributes: attributes)
//        NewGameButton.setAttributedTitle(attributedString, for: UIControl.State.normal)
//    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: themes?.backColorOfCard ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let flipsString = traitCollection.verticalSizeClass == .compact ? "Flips:\n\(game.flipCount)" : "Flips:\(game.flipCount)"
        let attributedString = NSAttributedString.init(
            string: flipsString,
            attributes: attributes)

        FlipCountLabel.attributedText = attributedString
    }
       
    private func updateScoreLabel() {
        let NSAattributes: [NSAttributedString.Key : Any] = [
            .strokeWidth : 5.0,
            .strokeColor : themes?.backColorOfCard ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let scoreString = traitCollection.verticalSizeClass == .compact ? "Score:\n\(game.score)" : "Score:\(game.score)"
        let NSAstring = NSAttributedString.init(string: scoreString, attributes: NSAattributes)
        ScoreCountLabel.attributedText = NSAstring
    }
        
//    @IBOutlet weak var NewGameButton: UIButton!
    
//    @IBAction private func NewGame(_ sender: UIButton) {
//
//        game = Concentration(numberOfCardsPair: numberOfCardsPair)
//        updateViewFromTheme()
//        refreshUIView()
//
//    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateFlipCountLabel()
        updateScoreLabel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
            
        if let index = visibleCardsButton.firstIndex(of: sender) {
            game.chooseCard(at: index)
            refreshUIView()
        } else {
            print("Chosen card is not in array visibleCardsButtons")
        }
        
    }
    
    @IBOutlet private weak var FlipCountLabel: UILabel!
    @IBOutlet weak var ScoreCountLabel: UILabel!
    @IBOutlet private var cardsButton: [UIButton]!
        
    private var visibleCardsButton: [UIButton]! {
        return cardsButton.filter {!$0.superview!.isHidden}
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        refreshUIView()
    }
    
    private func refreshUIView()  {
        
        for index in visibleCardsButton.indices {
            let card = game.cards[index]
            let cardButton = visibleCardsButton[index]
            
            if card.isFaceUp {
                cardButton.setTitle(Emoji(for: card), for: UIControl.State.normal)
                cardButton.backgroundColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                cardButton.setTitle("", for: UIControl.State.normal)
                cardButton.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : themes?.backColorOfCard ?? #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            }
        }
        updateFlipCountLabel()
        updateScoreLabel()
    }
    
    @IBOutlet weak var TitleLabel: UILabel!
            
    var themes: (emojies: [String], backColorOfCard: UIColor, backGroundView: UIColor)? {
        didSet{
            emojiAtCard = [:]
            emojies = themes?.emojies ?? [""]
            updateViewFromTheme()
            refreshUIView()
        }
    }
    
    private var emojies = [""]
    private var emojiAtCard = [Card: String]()
    private func Emoji(for card: Card) -> String {
                
        if emojiAtCard[card] == nil, emojies.count > 0 {
            emojiAtCard[card] = emojies.remove(at: emojies.count.arc4random)
        }
        
        return emojiAtCard[card] ?? "?"
        
    }
        
    // Testing: Swift lang
    @IBAction private func TestSwift(_ sender: UIButton) {
        
        LetTestSwift()
        
    }
    
}

//Extensions
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(Int32(self))))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(Int32(abs(self)))))
        } else {
            return 0
        }
    }
}
