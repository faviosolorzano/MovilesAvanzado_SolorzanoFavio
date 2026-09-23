//
//  ViewController.swift
//  Laboratorio-CP
//
//  Created by Tecsup on 16/09/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var capitalTextField: UITextField!
    @IBOutlet weak var tasaTextField: UITextField!
    @IBOutlet weak var plazoTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "Ingrese los datos del préstamo"
    }

    @IBAction func calcularPrestamo(_ sender: Any) {
        
        let capital = Double(capitalTextField.text ?? "") ?? 0
        let tasaAnual = Double(tasaTextField.text ?? "") ?? 0
        let plazoAnios = Double(plazoTextField.text ?? "") ?? 0
        
        // Validar los datos ingresados
        if capital <= 0 || tasaAnual <= 0 || plazoAnios <= 0 {
            resultLabel.text = "Por favor, ingrese valores válidos."
            return
        }
        
        // Convertir la tasa anual a tasa mensual
        let tasaMensual = (tasaAnual / 100) / 12

        // Calcular el número total de pagos
        let numeroPagos = plazoAnios * 12

        // Calcular la cuota mensual
        let potencia = pow(1 + tasaMensual, numeroPagos)

        let cuotaMensual = capital *
            (tasaMensual * potencia) /
            (potencia - 1)

        // Mostrar la cuota mensual
        resultLabel.text = "Cuota mensual: S/ \(String(format: "%.2f", cuotaMensual))"
        
        
        
    
}

