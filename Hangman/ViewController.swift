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
    var secretWord = ""
    var selectedWordPosition: Int = 0
    var useImageNumber: Int = 0
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var printedLetters: UILabel!
    
    @IBAction func pressButton(_ sender: UIButton) {
        let text: String = sender.currentTitle!
        
        for letter in words[selectedWordPosition].characters {
            if String(letter) == text {
                useImageNumber += 1
                printedLetters.text = regenerateSpaces(letter: text)
                bgImage.image = UIImage(named: "img/" + String(useImageNumber))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgImage.image = UIImage(named: "img/0")
        
        let randomNum:UInt32 = arc4random_uniform(UInt32(words.count))
        selectedWordPosition = Int(randomNum)
        
        generateSpaces()
    }
    
    func generateSpaces() {
        var result: String = ""
        
        for i in words[selectedWordPosition].characters {
            result += "_ "
            secretWord += " "
        }
        
        printedLetters.text = result
    }
    
    func regenerateSpaces(letter: String) -> String {
        var result: String = ""
        
        for (index, i) in words[selectedWordPosition].characters.enumerated() {
            if String(i)  == letter && secretWord[secretWord.index(secretWord.startIndex, offsetBy: index)] == " " {
                secretWord.insert(i, at: secretWord.index(secretWord.startIndex, offsetBy: index))
                secretWord.remove(at: secretWord.index(secretWord.startIndex, offsetBy: index + 1))
                result += letter + " "
            } else if secretWord[secretWord.index(secretWord.startIndex, offsetBy: index)] != " " {
                result += String(secretWord[secretWord.index(secretWord.startIndex, offsetBy: index)]) + " "
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

