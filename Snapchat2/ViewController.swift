//
//  ViewController.swift
//  Snapchat2
//
//  Created by Wesley Fonseca Pivoto Dias on 05/10/18.
//  Copyright © 2018 Wesley Fonseca Pivoto Dias. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let autenticacao = Auth.auth()
        
//        do {
//            try autenticacao.signOut()
//        } catch{
//            print("Erro ao deslogar usuario")
//        }
        
        autenticacao.addStateDidChangeListener { (autenticacao, usuario) in
            
            if let usuarioLogado = usuario {
                self.performSegue(withIdentifier: "loginAutomaticoSegue", sender: nil)
            }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

