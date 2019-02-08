//
//  ViewController.swift
//  Practica1_AlvaroSalomoni
//
//  Created by Alvaro Salomoni on 10/10/18.
//  Copyright © 2018 Alvaro Salomoni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //var num:Int = Int(arc4random_uniform(100))
    
    //let MAX : UInt32 = 100
    //let MIN : UInt32 = Negative
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var gameOverlabel: UILabel!
    @IBOutlet weak var pruebaOtraVez: UIButton!
    @IBOutlet weak var puntos: UILabel!
    @IBOutlet weak var timer: UILabel!
    
    
    //func randomNumber(Min: Int, Max: Int) -> Int {
      //  return Int(arc4random_uniform(UInt32(Max)) + UInt32(Min));
    //}
    
    var GameOver: Bool = false
    var botones: [UIButton] = []
    var numerosOrdenados: [Int] = []
    var superTitle = 0
    var puntitos = 0
    var tiempito = Timer()
    var segundos = 30
    
    @IBAction func ClickButton(_ sender: UIButton) {
        
        
        superTitle = Int(sender.currentTitle!)!
        if  superTitle == numerosOrdenados[0]{
            sender.isHidden = true
            puntitos += 1
            puntos.text = "Puntos : \(puntitos)"
            numerosOrdenados.removeFirst()
            
            if numerosOrdenados.isEmpty{
                start()
            }
        }
        else {
            hasPerdido()
        }
        
    }
    
    func start () {
        
        puntos.text = "Puntos : \(puntitos) "
        tiempito.invalidate()
        segundos = 30
        empezarTimer()
        numerosOrdenados.removeAll()
        botones = [btn1,btn2,btn3,btn4,btn5,btn6]
        
        for b in 0...5{
            let aleatorio = Int.random(in: -101..<101)
            numerosOrdenados.append(aleatorio)
            let aleatorioString = String(aleatorio)
            botones[b].setTitle(aleatorioString, for: .normal)
            botones[b].isHidden = false
        }
        
        numerosOrdenados.sort()
        print(numerosOrdenados)
        
    }
    
    func hasPerdido (){
        tiempito.invalidate()
        segundos = 0
        timer.text = "0"
        puntitos = 0
        GameOver = true
        gameOverlabel.isHidden = false
        for b in 0...5{
            botones[b].isHidden = true
        }
        botones.removeAll()
        pruebaOtraVez.isHidden = false
    }
    
    
    @IBAction func restart(_ sender: UIButton) {
        
        gameOverlabel.isHidden = true
        pruebaOtraVez.isHidden = true
        botones.removeAll()
        start()
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //print(randomNumber(Min: -100, Max: 100))
        
        gameOverlabel.isHidden = true
        pruebaOtraVez.isHidden = true
        start()
    }
    
    func empezarTimer(){
        tiempito = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.renovarTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func renovarTimer(){
        segundos -= 1
        timer.text = "\(segundos)"
        if segundos == 0 {
            tiempito.invalidate()
            hasPerdido()
        }
    }
    
}

