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
    var ventaCalculada: VentaModel?
    
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

        override func shouldPerformSegue(
            withIdentifier identifier: String,
            sender: Any?
        ) -> Bool {

            if identifier == "mostrarResumen" {

                guard let venta = calcularVenta() else {

                    let alerta = UIAlertController(
                        title: "Datos incorrectos",
                        message: "Ingrese valores válidos.",
                        preferredStyle: .alert
                    )

                    alerta.addAction(
                        UIAlertAction(title: "Aceptar", style: .default)
                    )

                    present(alerta, animated: true)

                    return false
                }

                ventaCalculada = venta
            }

            return true
        }

        override func prepare(
            for segue: UIStoryboardSegue,
            sender: Any?
        ) {

            if segue.identifier == "mostrarResumen",
               let destino = segue.destination as? ResumenViewController {

                destino.venta = ventaCalculada
            }
        }

}

