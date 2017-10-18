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
    var score: Int = 0
    
    var buttonsUsed = [UIButton]()
    
    @IBOutlet weak var hangman: UIImageView!
    @IBOutlet weak var selectedWordLabel: UILabel!
    @IBOutlet weak var triesLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var generateButton: UIButton!
    
    @IBAction func resetButton(_ sender: UIButton) {
        reset(deleteScore: true)
        let appleColor = UIColor(red:14.0/255, green:122.0/255, blue:254.0/255, alpha:1.0)
        
        for button in buttonsUsed {
            button.setTitleColor(appleColor, for: .normal)
        }
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        buttonsUsed.append(sender)
        let text: String = sender.currentTitle!
        var fail: Bool = true
        
        
        for letter in words[selectedWordPosition].characters {
            if String(letter) == text {
                setTextToLabel(text: regenerateSpaces(letter: text))
                fail = false
                score += 10
                scoreLabel.text = String(score)
            }
        }
        
        if fail && fails < 7 {
            fails += 1
            useImageNumber += 1
            tries -= 1
            triesLabel.text = String(tries)
            sender.setTitleColor(.red, for: .normal)
            hangman.image = UIImage(named: "img/" + String(useImageNumber))
        } else {
            sender.setTitleColor(.green, for: .normal)
        }
        
        if fails == 7 {
            hangman.image = UIImage(named: "img/lose")
        }
        
        if words[selectedWordPosition] == selectedWord {
            hangman.image = UIImage(named: "img/win")
            generateButton.isEnabled = true
        }
    }
    
    @IBAction func pressGenerateButton(_ sender: UIButton) {
        generateButton.isEnabled = false
        reset(deleteScore: false)
        
        let appleColor = UIColor(red:14.0/255, green:122.0/255, blue:254.0/255, alpha:1.0)
        
        for button in buttonsUsed {
            button.setTitleColor(appleColor, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reset(deleteScore: true)
    }
    
    func reset(deleteScore: Bool) {
        fails = 0
        useImageNumber = 0
        selectedWordPosition = 0
        selectedWord = ""
        tries = 7
        
        if deleteScore {
            score = 0
        }
        
        triesLabel.text = String(tries)
        scoreLabel.text = String(score)
        
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

