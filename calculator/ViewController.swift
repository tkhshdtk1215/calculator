//
//  ViewController.swift
//  calculator
//
//  Created by hidetaka on 2019/10/13.
//  Copyright © 2019 hidetaka. All rights reserved.
//

import UIKit


extension String {
    func splitInto(_ length: Int) -> [String] {
        var str = self
        for i in 0 ..< (str.count - 1) / max(length, 1) {
            str.insert(",", at: str.index(str.startIndex, offsetBy: (i + 1) * max(length, 1) + i))
        }
        return str.components(separatedBy: ",")
    }
}

class ViewController: UIViewController {
    
    var largeNumStrs: [String] = [String]()
    var numStrs: [String] = [String]()
    
    var result = 0.0
    var strDoubleArray = [String]()
    var num: [String] = [String]()
    
    var leftCount = 0
    var rightCount = 0
    
    
    @IBOutlet weak var largeView: UIView!
    @IBOutlet weak var smallView: UIView!
    @IBOutlet weak var largeMathLabel: UILabel!
    @IBOutlet weak var mathLabel: UILabel!
    @IBOutlet weak var largeScrollView: UIScrollView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var keyView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: mathLabel.bottomAnchor).isActive = true
        largeScrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: largeMathLabel.bottomAnchor).isActive = true
        
        addBorder(self.smallView)
        addBorder2(self.keyView)
        
    }
    
    @IBAction func redBtn(_ sender: Any) {
        textColorChanged(UIColor.red)
    }
    
    @IBAction func blueBtn(_ sender: Any) {
        textColorChanged(UIColor.blue)
    }
    
    @IBAction func yellowBtn(_ sender: Any) {
        textColorChanged(UIColor.yellow)
    }
    
    @IBAction func greenBtn(_ sender: Any) {
        textColorChanged(UIColor.green)
    }
    
    @IBAction func whiteBtn(_ sender: Any) {
        textColorChanged(UIColor.white)
    }
    
    
    
    @IBAction func btn0(_ sender: Any) {
        pushedBtn("0")
    }
    @IBAction func btn1(_ sender: Any) {
        pushedBtn("1")
    }
    @IBAction func btn2(_ sender: Any) {
        pushedBtn("2")
    }
    @IBAction func btn3(_ sender: Any) {
        pushedBtn("3")
    }
    @IBAction func btn4(_ sender: Any) {
        pushedBtn("4")
    }
    
    @IBAction func btn5(_ sender: Any) {
        pushedBtn("5")
    }
    @IBAction func btn6(_ sender: Any) {
        pushedBtn("6")
    }
    @IBAction func btn7(_ sender: Any) {
        pushedBtn("7")
    }
    @IBAction func btn8(_ sender: Any) {
        pushedBtn("8")
    }
    @IBAction func btn9(_ sender: Any) {
        pushedBtn("9")
    }
    
    @IBAction func dotBtn(_ sender: Any) {
        if numStrs.count > 0{
            if !(numStrs[numStrs.count-1] == "(" || numStrs[numStrs.count-1] == ")" || numStrs[numStrs.count-1] == "+" || numStrs[numStrs.count-1] == "-" || numStrs[numStrs.count-1] == "×" || numStrs[numStrs.count-1] == "÷" || numStrs[numStrs.count-1] == "." ) {
                if !strDoubleArray.isEmpty {
                    if !strDoubleArray.contains(".") {
                        self.numStrs.append(".")
                        self.strDoubleArray.append(".")
                        halfway()
                    }
                } else {
                    if numStrs.count >= 2{
                        let numSplit = num[num.count-1].splitInto(1)
                        if numSplit.count >= 2 {
                            if numSplit[numSplit.count-2] == numStrs[numStrs.count-2] && numSplit[numSplit.count-1] == numStrs[numStrs.count-1]{
                                return
                            } else {
                                strDoubleArray = num[num.count-1].splitInto(1)
                                strDoubleArray.remove(at: strDoubleArray.count-1)
                                num.remove(at: num.count-1)
                                self.numStrs.append(".")
                                halfway()
                            }
                        }else{
                            return
                        }
                    } else {
                        strDoubleArray = num[num.count-1].splitInto(1)
                        strDoubleArray.remove(at: strDoubleArray.count-1)
                        num.remove(at: num.count-1)
                        self.numStrs.append(".")
                        halfway()
                    }
                }
            } else {
                return
            }
        } else {
            return
        }
        
    }
    
    @IBAction func leftBrackets(_ sender: Any) {
        if numStrs.count > 0 {
            if numStrs.count > 12 {
                let ns12 = numStrs[numStrs.count-13...numStrs.count-1]
                if ns12.contains("+") || ns12.contains("-") || ns12.contains("×") || ns12.contains("÷") {
                    if numStrs[numStrs.count-1] != "." {
                        leftCount += 1
                        if numStrs.count > 0 {
                            if !(numStrs[numStrs.count-1] == "+" || numStrs[numStrs.count-1] == "-" || numStrs[numStrs.count-1] == "×" || numStrs[numStrs.count-1] == "÷" || numStrs[numStrs.count-1] == "." ) {
                                if strDoubleArray.contains(".") {
                                    num.append(String(self.strDoubleArray.joined()))
                                } else if !strDoubleArray.isEmpty{
                                    num.append(String(Double(Int(self.strDoubleArray.joined())!)))
                                }
                                strDoubleArray = []
                                if numStrs[numStrs.count-1] != "("{
                                    numStrs.append("×")
                                    num.append("*")
                                    numStrs.append("(")
                                    num.append("(")
                                } else {
                                    numStrs.append("(")
                                    num.append("(")
                                }
                                halfway()
                            } else {
                                numStrs.append("(")
                                num.append("(")
                            }
                        } else {
                            numStrs.append("(")
                            num.append("(")
                        }
                        halfway()
                    } else {
                        return
                    }
                }else{
                    showAlert(message: "()または数字が多すぎです")
                    return
                }
            }else{
                leftCount += 1
                if numStrs.count > 0 {
                    if !(numStrs[numStrs.count-1] == "+" || numStrs[numStrs.count-1] == "-" || numStrs[numStrs.count-1] == "×" || numStrs[numStrs.count-1] == "÷" || numStrs[numStrs.count-1] == "." ) {
                        if strDoubleArray.contains(".") {
                            num.append(String(self.strDoubleArray.joined()))
                        } else if !strDoubleArray.isEmpty{
                            num.append(String(Double(Int(self.strDoubleArray.joined())!)))
                        }
                        strDoubleArray = []
                        if numStrs[numStrs.count-1] != "("{
                            numStrs.append("×")
                            num.append("*")
                            numStrs.append("(")
                            num.append("(")
                        } else {
                            numStrs.append("(")
                            num.append("(")
                        }
                        halfway()
                    } else if numStrs[numStrs.count-1] != "."{
                        numStrs.append("(")
                        num.append("(")
                    } else {
                        leftCount -= 1
                        return
                    }
                } else {
                    numStrs.append("(")
                    num.append("(")
                }
                halfway()
            }
        } else {
            leftCount += 1
            numStrs.append("(")
            num.append("(")
            halfway()
        }
    }
    
    @IBAction func rightBrackets(_ sender: Any) {
        if leftCount > rightCount {
            if self.numStrs.count > 0 {
                if !(numStrs[numStrs.count-1] == "(" || numStrs[numStrs.count-1] == "+" || numStrs[numStrs.count-1] == "-" || numStrs[numStrs.count-1] == "×" || numStrs[numStrs.count-1] == "÷" || numStrs[numStrs.count-1] == "." ){
                    self.numStrs.append(")")
                    if strDoubleArray.contains(".") {
                        num.append(String(self.strDoubleArray.joined()))
                    } else if !strDoubleArray.isEmpty{
                        num.append(String(Double(Int(self.strDoubleArray.joined())!)))
                    }
                    self.strDoubleArray = []
                    self.num.append(")")
                    halfway()
                    rightCount += 1
                }
            } else {
                return
            }
        }
    }
    
    @IBAction func plusBtn(_ sender: Any) {
        if numStrs.count > 0 {
            if !(numStrs[numStrs.count-1] == "+" || numStrs[numStrs.count-1] == "-" || numStrs[numStrs.count-1] == "×" || numStrs[numStrs.count-1] == "÷" || numStrs[numStrs.count-1] == "." || numStrs[numStrs.count-1] == "(" ){
                self.numStrs.append("+")
                if strDoubleArray.contains(".") {
                    num.append(String(self.strDoubleArray.joined()))
                } else if !strDoubleArray.isEmpty{
                    num.append(String(Double(Int(self.strDoubleArray.joined())!)))
                }
                self.strDoubleArray = []
                self.num.append("+")
                halfway()
            }
        } else {
            numStrs.append("0")
            num.append("0")
            numStrs.append("+")
            num.append("+")
            halfway()
        }
    }
    
    @IBAction func minusBtn(_ sender: Any) {
        if numStrs.count > 0{
            if !(numStrs[numStrs.count-1] == "+" || numStrs[numStrs.count-1] == "-" || numStrs[numStrs.count-1] == "×" || numStrs[numStrs.count-1] == "÷" || numStrs[numStrs.count-1] == "." ){
                self.numStrs.append("-")
                if strDoubleArray.contains(".") {
                    num.append(String(self.strDoubleArray.joined()))
                } else if !strDoubleArray.isEmpty{
                    num.append(String(Double(Int(self.strDoubleArray.joined())!)))
                }
                self.strDoubleArray = []
                self.num.append("-")
                halfway()
            }
        } else {
            numStrs.append("0")
            num.append("0")
            numStrs.append("-")
            num.append("-")
            halfway()
        }
    }
    
    @IBAction func timesBtn(_ sender: Any) {
        if numStrs.count > 0 {
            if !(numStrs[numStrs.count-1] == "(" || numStrs[numStrs.count-1] == "+" || numStrs[numStrs.count-1] == "-" || numStrs[numStrs.count-1] == "×" || numStrs[numStrs.count-1] == "÷" || numStrs[numStrs.count-1] == "." ){
                self.numStrs.append("×")
                if strDoubleArray.contains(".") {
                    num.append(String(self.strDoubleArray.joined()))
                } else if !strDoubleArray.isEmpty {
                    num.append(String(Double(Int(self.strDoubleArray.joined())!)))
                }
                self.strDoubleArray = []
                self.num.append("*")
                halfway()
            }
        }else{
            return
        }
    }
    
    @IBAction func devidedBtn(_ sender: Any) {
        if numStrs.count > 0 {
            if !(numStrs[numStrs.count-1] == "(" || numStrs[numStrs.count-1] == "+" || numStrs[numStrs.count-1] == "-" || numStrs[numStrs.count-1] == "×" || numStrs[numStrs.count-1] == "÷" || numStrs[numStrs.count-1] == "." ){
                self.numStrs.append("÷")
                if strDoubleArray.contains(".") {
                    num.append(String(self.strDoubleArray.joined()))
                } else if !strDoubleArray.isEmpty {
                    num.append(String(Double(Int(self.strDoubleArray.joined())!)))
                }
                self.strDoubleArray = []
                self.num.append("/")
                halfway()
            }
        } else {
            return
        }
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        if numStrs.count > 0{
            if numStrs[numStrs.count-1] == "(" {
                leftCount -= 1
            } else if numStrs[numStrs.count-1] == ")"{
                rightCount -= 1
            }
            if strDoubleArray.isEmpty {
                strDoubleArray = num[num.count-1].splitInto(1)
                num.remove(at: num.count-1)
                if numStrs.count > 1 && strDoubleArray.count > 1 {
                    if !(numStrs[numStrs.count-2] == strDoubleArray[strDoubleArray.count-2] && numStrs[numStrs.count-1] == strDoubleArray[strDoubleArray.count-1]){
                        numStrs.remove(at: numStrs.count-1)
                        strDoubleArray.remove(at: strDoubleArray.count-1)
                        strDoubleArray.remove(at: strDoubleArray.count-1)
                        strDoubleArray.remove(at: strDoubleArray.count-1)
                    } else {
                        numStrs.remove(at: numStrs.count-1)
                        strDoubleArray.remove(at: strDoubleArray.count-1)
                    }
                }else{
                    numStrs.remove(at: numStrs.count-1)
                    strDoubleArray = []
                }
            } else {
                strDoubleArray.remove(at: strDoubleArray.count-1)
                numStrs.remove(at: numStrs.count-1)
            }
            halfway()
        } else {
            return
        }
    }
    
    @IBAction func ACBtn(_ sender: Any) {
        numStrs = []
        result = 0.0
        strDoubleArray = []
        num = []
        self.leftCount = 0
        self.rightCount = 0
        halfway()
    }
    
    
    @IBAction func equalBtn(_ sender: Any) {
        
        if numStrs.count > 0 {
            if !(numStrs[numStrs.count-1] == "(" || numStrs[numStrs.count-1] == "+" || numStrs[numStrs.count-1] == "-" || numStrs[numStrs.count-1] == "×" || numStrs[numStrs.count-1] == "÷" || numStrs[numStrs.count-1] == "." || numStrs[numStrs.count-1] == "=" ) {
                if self.leftCount == self.rightCount {
                    if strDoubleArray.contains(".") {
                        num.append(String(self.strDoubleArray.joined()))
                    } else if !strDoubleArray.isEmpty {
                        num.append(String(Double(Int(self.strDoubleArray.joined())!)))
                    }
                    strDoubleArray = []
                    let equation = num.joined()
                    
                    let expression = NSExpression(format: equation)
                    self.result = expression.expressionValue(with: nil, context: nil) as! Double
                    if String(result) == "inf" {
                        showAlert(message: "計算できません")
                    }else{
                        num.append("=")
                        numStrs.append("=")
                        var strResult = String(result).splitInto(1)
                        if strResult[strResult.count-2] == "." && strResult[strResult.count-1] == "0" {
                            strResult.remove(at: strResult.count-1)
                            strResult.remove(at: strResult.count-1)
                            numStrs.append(strResult.joined())
                        } else {
                            numStrs.append(strResult.joined())
                        }
                        halfway()
                    }
                } else {
                    showAlert(message: "左右のカッコの数が合ってません")
                }
            } else {
                return
            }
        } else {
            return
        }
    }
    
    func halfway() {
        self.mathLabel.text = self.numStrs.joined()
        if num.count > 0 {
            if num[num.count-1] == "=" {
                largeNumStrs.append(numStrs.joined())
                largeNumStrs.append("\n")
                largeMathLabel.text = largeNumStrs.joined()
                numStrs = []
                result = 0.0
                strDoubleArray = []
                num = []
                self.leftCount = 0
                self.rightCount = 0
                print("largenumstrs",largeNumStrs)
            } else {
                return
            }
        } else {
            return
        }
    }
    
    func pushedBtn(_ number: String){
        if numStrs.count > 12 {
            let ns12 = numStrs[numStrs.count-13...numStrs.count-1]
            if ns12.contains("+") || ns12.contains("-") || ns12.contains("×") || ns12.contains("÷") {
                if numStrs.count > 0 {
                    if numStrs[numStrs.count-1] == ")"{
                        numStrs.append("×")
                        numStrs.append(number)
                        num.append("*")
                    } else {
                        self.numStrs.append(number)
                    }
                } else {
                    self.numStrs.append(number)
                }
                self.strDoubleArray.append(number)
                halfway()
            } else {
                showAlert(message: "()または数字が多すぎです")
                return
            }
        } else {
            if numStrs.count > 0 {
                if numStrs[numStrs.count-1] == ")"{
                    numStrs.append("×")
                    numStrs.append(number)
                    num.append("*")
                } else {
                    self.numStrs.append(number)
                }
            } else {
                self.numStrs.append(number)
            }
            self.strDoubleArray.append(number)
            halfway()
        }
    }
    
    
    func addBorder(_ selectedView:UIView) {
        let topBorder = CALayer()
        let bottomBorder = CALayer()
        let leftBorder = CALayer()
        let rightBorder = CALayer()
        
        topBorder.frame = CGRect(x: -5.0, y: -5.0, width: selectedView.frame.size.width+10, height: 5.0)
        topBorder.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0.5, alpha: 1).cgColor
        
        bottomBorder.frame = CGRect(x: -10.0, y: selectedView.frame.size.height+5, width: selectedView.frame.size.width+20, height: 5.0)
        bottomBorder.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0.5, alpha: 1).cgColor
        
        leftBorder.frame = CGRect(x: -10.0, y: -5.0, width: 5.0, height: selectedView.frame.size.height+10)
        leftBorder.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0.5, alpha: 1).cgColor
        
        rightBorder.frame = CGRect(x: selectedView.frame.size.width+5, y: -5.0, width: 5.0, height: selectedView.frame.size.height+10)
        rightBorder.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0.5, alpha: 1).cgColor
        
        selectedView.layer.addSublayer(topBorder)
        selectedView.layer.addSublayer(bottomBorder)
        selectedView.layer.addSublayer(leftBorder)
        selectedView.layer.addSublayer(rightBorder)
    }
    
    func addBorder2(_ selectedView:UIView) {
        let topBorder = CALayer()
        let bottomBorder = CALayer()
        let leftBorder = CALayer()
        let rightBorder = CALayer()
        
        topBorder.frame = CGRect(x: -5.0, y: -5.0, width: selectedView.frame.size.width+5, height: 5.0)
        topBorder.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0.5, alpha: 1).cgColor
        
        bottomBorder.frame = CGRect(x: -5.0, y: selectedView.frame.size.height, width: selectedView.frame.size.width+10, height: 5.0)
        bottomBorder.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0.5, alpha: 1).cgColor
        
        leftBorder.frame = CGRect(x: -5.0, y: -5.0, width: 5.0, height: selectedView.frame.size.height+10)
        leftBorder.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0.5, alpha: 1).cgColor
        
        rightBorder.frame = CGRect(x: selectedView.frame.size.width, y: -5.0, width: 5.0, height: selectedView.frame.size.height+10)
        rightBorder.backgroundColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0.5, alpha: 1).cgColor
        
        selectedView.layer.addSublayer(topBorder)
        selectedView.layer.addSublayer(bottomBorder)
        selectedView.layer.addSublayer(leftBorder)
        selectedView.layer.addSublayer(rightBorder)
    }
    
    func showAlert(message:String) {
        let alertController = UIAlertController(title: "ERROR", message:message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func textColorChanged(_ color: UIColor ){
        self.mathLabel.textColor = color
        self.largeMathLabel.textColor = color
    }
    
    
}

