//
//  ViewController.swift
//  Concentraton
//
//  Created by 1C on 27/03/2022.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var Game = Concentration(numberOfCardsPair: numberOfCardsPair)
    
    var numberOfCardsPair: Int {
        return (cardsButton.count/2)+1
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        currentNumberOfTheme = keys.count.arc4random
        refreshUIView()
        updateViewFromTheme()
    }
   
   
    private func updateViewFromTheme() {
        view.backgroundColor = themes[keys[currentNumberOfTheme]]?.backGroundView ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let backGroundColorCard = themes[keys[currentNumberOfTheme]]?.backColorOfCard ?? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        for index in cardsButton.indices {
            cardsButton[index].backgroundColor = backGroundColorCard
        }
        updateNewGameButton()
        updateTitle()
    }
    
    private func updateNewGameButton() {
        let backColor = themes[keys[currentNumberOfTheme]]?.backColorOfCard
        NewGameButton.setTitleColor(backColor ?? #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), for: UIControl.State.normal)
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeColor: backColor ?? #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),
            .strokeWidth: 5.0
        ]
        let attributedString = NSAttributedString.init(string: "New game", attributes: attributes)
        NewGameButton.setAttributedTitle(attributedString, for: UIControl.State.normal)
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: themes[keys[currentNumberOfTheme]]?.backColorOfCard ?? #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        ]
        let stringFlipCount = "Flip count: \(Game.flipCount)"
//        let attributedString = NSAttributedString.init(string: "Flip count: \(Game.flipCount)", attributes: attributes)
        let attributedString = NSMutableAttributedString(string: stringFlipCount, attributes: attributes)
        
        let firstWord = stringFlipCount.startIndex..<stringFlipCount.lastIndex(of: "c")!
        let nsRange = NSRange(firstWord, in: stringFlipCount)
        attributedString.addAttribute(.strokeWidth, value: 10.0, range: nsRange)
        attributedString.addAttribute(.strokeColor, value: UIColor.green, range: nsRange)
                
        

        FlipCountLabel.attributedText = attributedString
        
        
        
    }
    
   
    private func updateScoreLabel() {
        let NSAattributes: [NSAttributedString.Key : Any] = [
            .strokeWidth : 5.0,
            .strokeColor : themes[keys[currentNumberOfTheme]]?.backColorOfCard ?? #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        ]
        let NSAstring = NSAttributedString.init(string: "Score:\(Game.score)", attributes: NSAattributes)
        ScoreCountLabel.attributedText = NSAstring
    }
    
    private func updateTitle() {
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeColor : themes[keys[currentNumberOfTheme]]?.backColorOfCard ?? #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),
            .strokeWidth : 5.0
        ]
        let NSAstring = NSAttributedString.init(string: "\(keys[currentNumberOfTheme])", attributes: attributes)
        TitleLabel.attributedText = NSAstring
        
    }
    
    @IBOutlet weak var NewGameButton: UIButton!
    
    @IBAction private func NewGame(_ sender: UIButton) {
        
        currentNumberOfTheme = keys.count.arc4random
        
        Game.NewGame()
        
        updateViewFromTheme()
        refreshUIView()

    }
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        
        
        if let index = cardsButton.firstIndex(of: sender) {
            Game.chooseCard(at: index)
            refreshUIView()
        } else {
            print("Chosen card is not in array cardsButton")
        }
        
    }
    
    @IBOutlet private weak var FlipCountLabel: UILabel!
    
    @IBOutlet weak var ScoreCountLabel: UILabel!
    
    @IBOutlet private var cardsButton: [UIButton]!
        
    private func refreshUIView()  {
        
        for index in cardsButton.indices {
            let card = Game.cards[index]
            let cardButton = cardsButton[index]
            
            if card.isFaceUp {
                cardButton.setTitle(Emoji(for: card), for: UIControl.State.normal)
                cardButton.backgroundColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                cardButton.setTitle("", for: UIControl.State.normal)
                cardButton.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : themes[keys[currentNumberOfTheme]]?.backColorOfCard ?? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        updateFlipCountLabel()
        
        updateScoreLabel()
        
    }
    
    private var emojies = [""]
    
    private var emojiAtCard = [Card: String]()
        
    private var currentNumberOfTheme = 0 {
        didSet{
            emojiAtCard.removeAll()
            emojies = themes[keys[currentNumberOfTheme]]?.emojies ?? []
            updateTitle()
            updateViewFromTheme()
        }
    }
    
    
    @IBOutlet weak var TitleLabel: UILabel!
            
    private var themes: [String: (emojies: [String], backColorOfCard: UIColor, backGroundView: UIColor)] = [
        "Hallowen" : (["🎃","👻","😈","🧛","🧙‍♀️","🙀","🌙","🌚","⚡️", "💀"], #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
        "Fruits": (["🍎","🍋","🍒","🍇","🥝","🍌","🥥","🍍","🍐", "🍊"], #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        "Sports": (["⚽️","🏀","🏈","🎾","🏓","🏸","🥊","🛹","⛸", "🛼"], #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
        "Transports": (["🚗","🚕","🛴","✈️","🚠","🚜","🚑","🚂","🛥", "🏎"], #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)),
        "Flags": (["🚩","🇩🇿","🇦🇿","🇧🇬","🇨🇿","🇱🇷","🇳🇮","🇺🇸","🇫🇷", "🇩🇪"], #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
        "Smiles": (["😃","😆","😂","😛","🥸","😡","🥳","😍","😤", "🥶"], #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
        "Animals": (["🦧","🐘","🐫","🐈","🦜","🐩","🦔","🐖","🐎","🐄"], #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
    ]
    
    private var keys: [String] {
        return Array(themes.keys)
    }
    
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
