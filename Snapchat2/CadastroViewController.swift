//
//  CadastroViewController.swift
//  Snapchat2
//
//  Created by Wesley Fonseca Pivoto Dias on 05/10/18.
//  Copyright © 2018 Wesley Fonseca Pivoto Dias. All rights reserved.
//

import UIKit
import FirebaseAuth

class CadastroViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var senhaConfirmacao: UITextField!
    
    func exibirMensagem(titulo: String, mensagem: String) {
        
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alerta.addAction(acaoCancelar)
        present(alerta, animated: true, completion: nil)
        
    }
    
    
    @IBAction func criarConta(_ sender: Any) {
        //Recupera dados digitados
        if let emailR = self.email.text {
            if let senhaR = self.senha.text {
                if let senhaConfirmacaoR = self.senhaConfirmacao.text {
                    
                    //Validar senha
                    if senhaR == senhaConfirmacaoR {
                        
                        //Criar conta no Firebase
                        let autenticacao = Auth.auth()
                        autenticacao.createUser(withEmail: emailR, password: senhaR) { (usuario, erro) in
                            
                            if erro == nil {
                                if usuario == nil {
                                    self.exibirMensagem(titulo: "Erro ao autenticar", mensagem: "Problema ao realizar autenticacao, tente novamente.")
                                }else{
                                        self.performSegue(withIdentifier: "cadastroLoginSegue", sender: nil)
                                }
                                
                            }else {
                                
                                // ERROR_INVALID_EMAIL
                                // ERROR_WEAK_PASSWORD
                                // ERROR_EMAIL_ALREADY_IN_USE
                                
                                let erroR = erro! as NSError
                                if let codigoERRO = erroR.userInfo["error_name"] {
                                    
                                    let erroTexto = codigoERRO as! String
                                    var mensagemErro = " "
                                    switch erroTexto {
                                        case "ERROR_INVALID_EMAIL" :
                                            mensagemErro = "E-mail inválido, digite um e-mail válido"
                                            break
                                        case "ERROR_WEAK_PASSWORD" :
                                            mensagemErro = "Senha fraca"
                                            break
                                        case "ERROR_EMAIL_ALREADY_IN_USE" :
                                            mensagemErro = "Ja tem o email"
                                            break
                                        
                                    default:
                                        mensagemErro = "Dados incorretos"
                                    }
                                    
                                    self.exibirMensagem(titulo: "Dados inválidos", mensagem: mensagemErro)
                                    
                                }
                                
                            }
                            
                        }
                        
                    }else {
                        
                        self.exibirMensagem(titulo: "Dados incorretos", mensagem: "As senhas nao estao iguais, digite novamente")
                        
                        
                    }//Fim validacao senha
                    
                }
            }
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
