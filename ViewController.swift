
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var memoryLabel: UILabel!
    @IBOutlet weak var factorialButton: UIButton!
    var questionTime = 300
    var searchInProgress = false
    var newNumber = true
    var dotIsSet = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var sign: String = ""
    var input: Double {
        get{
            return Double(self.resultLabel.text!)!
        }
        set{
            let value = "\(newValue)"
            if value != "inf"{
                let valueArray = value.components(separatedBy: ".")
                if valueArray[1] == "0" {
                    self.resultLabel.text = "\(valueArray[0])"
                } else {
                    self.resultLabel.text = "\(newValue)"
                }
            }else {
                self.resultLabel.text = "\(newValue)"
            }
            newNumber = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        if self.newNumber {
            self.resultLabel.text = number
            self.newNumber = false
        } else {
            if (self.resultLabel.text?.characters.count)! < 30{
                self.resultLabel.text = self.resultLabel.text! + number
            }
        }
    }
    @IBAction func operandsSignPressed(_ sender: UIButton) {
        self.sign = sender.currentTitle!
        self.firstOperand = self.input
        self.newNumber = true
        self.dotIsSet = false
    }
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        
        if newNumber == false{
            self.secondOperand = input
        }
        self.dotIsSet = false
        switch sign {
        case "+":
            self.input = FuncManager.shared.add(self.firstOperand, self.secondOperand)
            newNumber = true
        case "-":
            self.input = FuncManager.shared.substract(self.firstOperand, self.secondOperand)
            newNumber = true
        case "✕":
            self.input = FuncManager.shared.multiply(self.firstOperand, self.secondOperand)
            newNumber = true
        case "÷":
            self.input = FuncManager.shared.divide(self.firstOperand, self.secondOperand)
            newNumber = true
        case "xʸ":
            self.input = FuncManager.shared.powIt(self.firstOperand, self.secondOperand)
            newNumber = true
        default: break
        }
        if self.input == 42 {
            self.mainQuestionAnswer()
        }
    }
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        self.firstOperand = 0
        self.secondOperand = 0
        self.input = 0
        self.resultLabel.text = "0"
        self.newNumber = true
        self.dotIsSet = false
        self.sign = ""
        self.factorialButton.isEnabled = true
        self.searchInProgress = false
        self.questionTime = 300
    }
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        self.input = -self.input
    }
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if !self.newNumber && !self.dotIsSet{
            self.resultLabel.text = self.resultLabel.text! + "."
            self.dotIsSet = true
        } else {
            if self.newNumber && !self.dotIsSet{
                self.resultLabel.text = "0."
                self.newNumber = false
            }
        }
    }
    @IBAction func percentButtonPressed(_ sender: UIButton) {
        if self.firstOperand == 0{
            self.input = self.input/100
        }else {
            self.secondOperand = self.firstOperand*self.input/100
        }
        self.newNumber = true
    }
    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        self.input = FuncManager.shared.squareRoot(self.input)
    }
    @IBAction func deleteLastNumberButtonPressed(_ sender: UIButton) {
        let string = String(self.resultLabel.text!)
        self.resultLabel.text = String(string.dropLast())
        if self.resultLabel.text?.characters.count == 0{
            self.resultLabel.text = "0"
            newNumber = true
        }
    }
    @IBAction func factorialButtonPressed(_ sender: UIButton) {
        self.input = FuncManager.shared.factorial(self.input)
        self.factorialButton.isEnabled = false
    }
    @IBAction func reverseNumberButtonPressed(_ sender: UIButton) {
        self.input = FuncManager.shared.reverseNumber(self.input)
    }
    @IBAction func logarithmButtonPressed(_ sender: UIButton) {
        self.input = FuncManager.shared.logarithm(self.input)
    }
    @IBAction func naturalLogarithmButtonPressed(_ sender: UIButton) {
        self.input = FuncManager.shared.naturalLogarithm(self.input)
    }
    @IBAction func trigonometricButtonsPressed(_ sender: UIButton) {
        self.sign = sender.currentTitle!
        switch sign {
        case "sin":
            self.input = sin(self.input * Double.pi / 180)
        case "cos":
            self.input = cos(self.input * Double.pi / 180)
        case "tan":
            self.input = tan(self.input * Double.pi / 180)
        default: break
        }
    }
    @IBAction func memoryCellButtonPressed(_ sender: UIButton) {
        self.sign = sender.currentTitle!
        switch sign {
        case "MS":
            FuncManager.shared.mSave(self.input)
            self.memoryLabel.text = String(FuncManager.shared.memoryCell)
        case "MR":
            self.input = FuncManager.shared.mRead()
        case "M+":
            FuncManager.shared.mPlus(self.input)
            self.memoryLabel.text = String(FuncManager.shared.memoryCell)
        case "M-":
            FuncManager.shared.mMinus(self.input)
            self.memoryLabel.text = String(FuncManager.shared.memoryCell)
        case "MC":
            FuncManager.shared.mClear()
            self.memoryLabel.text = "0"
        default: break
        }
    }
    
    func mainQuestionAnswer(){
        let alertCtrl = UIAlertController(title: "42", message: "Вы получили Ответ на главный вопрос жизни, вселенной и всего такого", preferredStyle: .alert)
        let OKButton = UIAlertAction(title: "OK", style: .default) { (_) in
            //self.present(alertCtrl, animated: true)
        }
        //let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let questionButton = UIAlertAction(title: "Найти основной вопрос?", style: .destructive) { (_) in
            self.searchInProgress = true
            self.tryFindMainQuestion()
            self.timer()
            //self.present(alertCtrl, animated: true)
            
        }
        
        alertCtrl.addAction(OKButton)
        alertCtrl.addAction(questionButton)
        //alertCtrl.addAction(cancelButton)
        self.present(alertCtrl, animated: true)
    }
    
    func tryFindMainQuestion(){
        let when = DispatchTime.now()+300
        DispatchQueue.main.asyncAfter(deadline: when) {
            fatalError()
        }
    }
    func timer(){
        if self.searchInProgress{
            let when = DispatchTime.now()+1
            DispatchQueue.main.asyncAfter(deadline: when){
                self.resultLabel.text = "Вопрос будет найден через \(self.questionTime)c"
                self.questionTime-=1
                if self.questionTime > 0{
                    self.timer()
                }
            }
        }
    }
}

