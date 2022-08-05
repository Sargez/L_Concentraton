//
//  ConcentrationChooseController.swift
//  Concentraton
//
//  Created by 1C on 08/05/2022.
//

import UIKit

class ConcentrationChooseController: UIViewController, UISplitViewControllerDelegate {

//    override var vclLoggingName: String {
//        return "Theme chooser"
//    }
    
     private var themes: [String: (emojies: [String], backColorOfCard: UIColor, backGroundView: UIColor)] = [
            "Hallowen" : (["🎃","👻","😈","🧛","🧙‍♀️","🙀","🌙","🌚","⚡️", "💀"], #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
            "Fruits": (["🍎","🍋","🍒","🍇","🥝","🍌","🥥","🍍","🍐", "🍊"], #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
            "Sports": (["⚽️","🏀","🏈","🎾","🏓","🏸","🥊","🛹","⛸", "🛼"], #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
            "Transports": (["🚗","🚕","🛴","✈️","🚠","🚜","🚑","🚂","🛥", "🏎"], #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)),
            "Flags": (["🚩","🇩🇿","🇦🇿","🇧🇬","🇨🇿","🇱🇷","🇳🇮","🇺🇸","🇫🇷", "🇩🇪"], #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
            "Smiles": (["😃","😆","😂","😛","🥸","😡","🥳","😍","😤", "🥶"], #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
            "Animals": (["🦧","🐘","🐫","🐈","🦜","🐩","🦔","🐖","🐎","🐄"], #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        ]
    
    private var splitViewControllerDetailConcentrationViewController: ConcentrationViewController? {
        
        return (splitViewController?.viewControllers.last) as? ConcentrationViewController
        
    }
    
    private var lastSequedToConcentrationViewController: ConcentrationViewController?
    
    @IBAction func changeTheme(_ sender: Any) {
//        Беру название тем, из заголовка кнопки, сделано в целях примера, чтобы поработать с controller.
//        понимаю, что так делать - плохо :)
        if let cvc = splitViewControllerDetailConcentrationViewController {

            if let currentTitle = (sender as? UIButton)?.currentTitle, let theme = themes[currentTitle] {
                cvc.themes = theme
            }

        } else if let cvc = lastSequedToConcentrationViewController {

            if let currentTitle = (sender as? UIButton)?.currentTitle, let theme = themes[currentTitle] {
                cvc.themes = theme
            }

            navigationController?.pushViewController(cvc, animated: true)

        } else {
            performSegue(withIdentifier: "Choose theme", sender: sender)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if (secondaryViewController as? ConcentrationViewController)?.themes == nil {
            return true
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if let identifier = segue.identifier {
            if identifier == "Choose theme" {
                if let currentTitle = (sender as? UIButton)?.currentTitle, let theme = themes[currentTitle] {
                    if let cvc = segue.destination as? ConcentrationViewController {
                        cvc.themes = theme
                        lastSequedToConcentrationViewController = cvc
                    }
                }
            }
        }
    }
}

