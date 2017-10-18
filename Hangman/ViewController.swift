import UIKit

class ViewController: UIViewController {
    
    let words = [
        "cama",
        "movil",
        "ordenador",
        "lluvia",
        "habitacion",
        "mesa",
        "noche",
        "dormir"
    ]
    var selectedWord = ""
    var selectedWordPosition: Int = 0
    var useImageNumber: Int = 0
    var fails: Int = 0
    var tries: Int = 7
    
    @IBOutlet weak var hangman: UIImageView!
    @IBOutlet weak var selectedWordLabel: UILabel!
    @IBOutlet weak var triesLabel: UILabel!
    
    @IBAction func resetButton(_ sender: UIButton) {
        reset()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        let text: String = sender.currentTitle!
        var fail: Bool = true
        
        for letter in words[selectedWordPosition].characters {
            if String(letter) == text {
                setTextToLabel(text: regenerateSpaces(letter: text))
                fail = false
            }
        }
        
        if fail {
            fails += 1
            useImageNumber += 1
            tries -= 1
            triesLabel.text = String(tries)
            hangman.image = UIImage(named: "img/" + String(useImageNumber))
        }
        
        if fails == 7 {
            hangman.image = UIImage(named: "img/lose")
        }
        
        if words[selectedWordPosition] == selectedWord {
            hangman.image = UIImage(named: "img/win")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
    }
    
    func reset() {
        fails = 0
        useImageNumber = 0
        selectedWordPosition = 0
        selectedWord = ""
        tries = 7
        triesLabel.text = String(tries)
        
        hangman.image = UIImage(named: "img/0")
        generateWordToUse()
        generateSpaces()
    }
    
    func generateWordToUse() {
        selectedWordPosition = randomNumberOfArray(words: words)
    }
    
    func randomNumberOfArray(words: [String]) -> Int {
        return Int(arc4random_uniform(UInt32(words.count)))
    }
    
    func generateSpaces() {
        var spaces: String = ""
        
        for _ in words[selectedWordPosition].characters {
            spaces += "_ "
            selectedWord += " "
        }
        
        setTextToLabel(text: spaces)
    }
    
    
    
    func characterAt(s: String, position: Int) -> Character {
        return s[s.index(s.startIndex, offsetBy: position)]
    }
    
    func setTextToLabel(text: String) {
        selectedWordLabel.text = text
    }
    
    func regenerateSpaces(letter: String) -> String {
        var result: String = ""
        
        for (index, i) in words[selectedWordPosition].characters.enumerated() {
            if String(i)  == letter && String(characterAt(s: selectedWord, position: index)) == " " {
                selectedWord.insert(i, at: selectedWord.index(selectedWord.startIndex, offsetBy: index))
                selectedWord.remove(at: selectedWord.index(selectedWord.startIndex, offsetBy: index + 1))
                result += letter + " "
            } else if String(characterAt(s: selectedWord, position: index)) != " " {
                result += String(characterAt(s: selectedWord, position: index)) + " "
            } else {
                result += "_ "
            }
        }
        
        return result
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

