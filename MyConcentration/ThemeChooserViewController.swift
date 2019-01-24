//
//  ThemeChooserViewController.swift
//  MyConcentration
//
//  Created by Peter on 24/01/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {
    
    private var themeColors = [
        "Haloween" : [
            "backgroundColor" : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            "cardColor" : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ],
        "Construction" : [
            "backgroundColor" : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
            "cardColor" : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        ],
        "Plants" : [
            "backgroundColor" : #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),
            "cardColor" : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        ],
        "Faces" : [
            "backgroundColor" : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),
            "cardColor" : #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        ],
        "Animals" : [
            "backgroundColor" : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
            "cardColor" : #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        ],
        "Sports" : [
            "backgroundColor" : #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),
            "cardColor" : #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        ],
        ]
    
    private var gameThemes = [
        "Haloween" : ["👻","🎃","👿","🍬","🙀","💀","🦇","😱","🍎","⚰️","🍭"],
        "Construction" : ["🚧", "🔨", "🏠", "🏗", "🔩", "⚒","🥽","⛑","🧱","💪"],
        "Animals" : ["🦝","🐁","🦋","🦒", "🐕", "🐒", "🐖", "🦉", "🕷","🐬"],
        "Sports" : ["🏐", "🥎", "🏀", "🏓", "⚽️", "⛸", "🏈", "🏒", "🥊", "⛷"],
        "Faces" : ["😃", "😅", "😍", "😡", "🥶", "🤢", "😳", "🤑", "🤠", "😖"],
        "Plants" : ["💐", "🌿", "🌺", "🌱", "🌵", "🌸", "🍁", "🌴", "🌹", "🌻"]
    ]
    
    

    @IBAction func changeTheme(_ sender: Any) {
        performSegue(withIdentifier: "Choose Theme", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme"{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = gameThemes[themeName] {
                if let gvc = segue.destination as? GameViewController {
                    gvc.cardColor = themeColors[themeName]!["cardColor"]
                    gvc.view.backgroundColor = themeColors[themeName]!["backgroundColor"]
                    gvc.theme = theme
                }
            }
        }
    }
    
}
