//
//  LobbyViewController.swift
//  TechMon
//
//  Created by 二本松秀樹 on 2021/02/17.
//

import UIKit

class LobbyViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaLabel:UILabel!
    
    let techMonManager = TechMonManager.shared
    
    var stamina: Int = 100
    var staminaTimer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // UISetting
        nameLabel.text = "勇者"
        staminaLabel.text = "\(stamina) / 100"
        
        // タイマーの設定
        staminaTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.updateStaminaValue), userInfo: nil, repeats: true)
        
        staminaTimer.fire()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // ロビー画面が見えるようになる時に呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        techMonManager.playBGM(fileName: "lobby")
    }
    
    @IBAction func toBattle() {
        //スタミナが50以上あればスタミナ50を消費して戦闘画面へ
        if 50 < stamina {
            stamina -= 50
            staminaLabel.text = "\(stamina) / 100"
            performSegue(withIdentifier: "toBattle", sender: nil)
        } else {
            let alert: UIAlertController = UIAlertController(title: "バトルに行けません", message: "スタミナが足りません", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    // スタミナの回復
    @objc func updateStaminaValue() {
        if stamina < 100 {
            stamina += 1
            staminaLabel.text = "\(stamina) / 100"
        }
    }
}
