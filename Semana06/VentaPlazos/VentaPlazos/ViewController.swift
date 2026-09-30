//
//  ViewController.swift
//  VentaPlazos
//
//  Created by Alexander on 30/09/26.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var precioTextField: UITextField!
    @IBOutlet weak var tasaTextField: UITextField!
    @IBOutlet weak var plazoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func calcularVenta() -> VentaModel? {

            guard let precio = Double(precioTextField.text ?? ""),
                  let tasaAnual = Double(tasaTextField.text ?? ""),
                  let plazoMeses = Int(plazoTextField.text ?? ""),
                  precio > 0,
                  tasaAnual > 0,
                  plazoMeses > 0 else {
                return nil
            }

            let tasaMensual = (tasaAnual / 100) / 12

            let cuotaMensual = (precio * tasaMensual) /
                (1 - pow(1 + tasaMensual, -Double(plazoMeses)))

            let totalPagar = cuotaMensual * Double(plazoMeses)

            return VentaModel(
                precio: precio,
                tasaAnual: tasaAnual,
                plazoMeses: plazoMeses,
                cuotaMensual: cuotaMensual,
                totalPagar: totalPagar
            )
        }


}

