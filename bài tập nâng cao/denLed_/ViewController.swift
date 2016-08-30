//
//  ViewController.swift
//  denLed_
//
//  Created by Admin on 8/29/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var _margin_row: CGFloat = 40
    var _margin_col: CGFloat = 65
    var n = 0
    var lastOnLed = -1
    var tang_giam = true
    var iconView = [UIImageView]()
    var d = 0 ,value = 0, hang = 0, cot = 0
    var assign_tag = [Int](count:100,repeatedValue:0)

    @IBOutlet weak var number: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
            }
    
    @IBAction func action_Draw(sender: AnyObject) {
        number.resignFirstResponder()

        n = Int(number.text!)!
        removeBall()
        gan_the()
        drawBall()
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.2
            , target: self, selector: #selector(runningLed), userInfo: nil, repeats: true)
        
    }
    func gan_the(){
        d = 0
        hang = n-1
        cot = n-1
        value = 0
        while( d <= n/2){
            for  var i = d; i <= cot;i++ {
                assign_tag[d * n + i] = value
                value += 1
            }
            
            for var i = d+1; i <= hang;i++ {
                assign_tag[i * n + cot] = value
                value += 1
            }
            for var i = cot - 1;i >= d; i-- {
                assign_tag[hang * n + i] = value
                value += 1
            }
            for var i = hang - 1;i > d; i-- {
                assign_tag[i * n + d] = value
                value += 1
            }
            d += 1
            hang -= 1
            cot -= 1
        }
        
    }
    
    
    func runningLed(){
        if (lastOnLed != -1){
            turnOffLed()
        }


        if(lastOnLed == n * n - 1){
            tang_giam = false
        }
        if(lastOnLed == 0){
            tang_giam = true
        }
        if(tang_giam == true){
            lastOnLed += 1
        }else{
            lastOnLed -= 1
        }
        
        turnOnLed()
        
    }

    func turnOnLed(){
        if let ball = self.view.viewWithTag(100+lastOnLed)
            as? UIImageView
        {
            ball.image = UIImage(named: "green")
        }

    }
    func turnOffLed(){
        if let ball = self.view.viewWithTag(100+lastOnLed)
            as? UIImageView
        {
            ball.image = UIImage(named: "grey")
        }
        
    }
        
    func drawBall()  {
        var ball: UIImageView? = nil
        var vitri = 0
        
        for indexdCol in 1...n{
            for indexRow in 1...n{
                
                let image = UIImage(named: "grey")
                ball = UIImageView(image: image)
                ball!.tag = assign_tag[vitri] + 100
                print("the \(ball!.tag)")
                vitri += 1

                ball!.center = CGPointMake(_margin_row + CGFloat(indexRow-1 ) * spaceRow() , CGFloat(indexdCol-1) * spaceCol() + _margin_col)
                self.view.addSubview(ball!)
                iconView.append(ball!)
                print("hang :\(indexRow)" + " cot: \(indexdCol)")

            }
        }
        print("rong: \(self.view.bounds.size.width)")
        print("cao: \(self.view.bounds.size.height)")
    
    }
    func removeBall(){
        for i in 0..<iconView.count{
            iconView[i].removeFromSuperview()
        }
        iconView.removeAll()
    }
    func spaceRow() -> CGFloat {
        var space: CGFloat = 0
        
        if(n > 1){
             space = (self.view.bounds.size.width - 2*_margin_row)/CGFloat(n-1)
            
        }else{
             space = CGFloat(0)
        }
                return space
    }
    func spaceCol() -> CGFloat {
        var space: CGFloat = 0
        if(n > 1){
            space = (self.view.bounds.size.height - 2*_margin_col)/CGFloat(n-1)
        }else{
            space = CGFloat(0)
        }
        
        return space
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        number.resignFirstResponder()
        
    }

    


}

