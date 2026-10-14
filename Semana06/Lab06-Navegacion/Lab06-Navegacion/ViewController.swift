//
//  ViewController.swift
//  Lab06-Navegacion
//
//  Created by Alexander on 30/09/26.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tfApellido: UITextField!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfDni: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmarDatos(_ sender: UIButton) {

            let cliente = ClienteModel(
                apellido: tfApellido.text ?? "",
                nombre: tfNombre.text ?? "",
                dni: tfDni.text ?? ""
            )

            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            if let confirmacionVC = storyboard.instantiateViewController(
                withIdentifier: "ViewControllerConfirmacion"
            ) as? ViewControllerConfirmacion {

                confirmacionVC.cliente = cliente
                confirmacionVC.modalPresentationStyle = .pageSheet

                present(confirmacionVC, animated: true)
            }
        }
    
    
    


}

