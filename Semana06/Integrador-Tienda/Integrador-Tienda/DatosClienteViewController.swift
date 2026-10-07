import UIKit

class DatosClienteViewController: UIViewController {

    var carrito: CarritoModel!
    var cliente: ClienteModel!

    @IBOutlet weak var apellidoField: UITextField!
    @IBOutlet weak var nombreField: UITextField!
    @IBOutlet weak var dniField: UITextField!

    @IBAction func confirmarTapped(_ sender: UIButton) {
        let nombre = nombreField.text ?? ""
        let apellido = apellidoField.text ?? ""
        let dni = dniField.text ?? ""

        if nombre.isEmpty || apellido.isEmpty || dni.isEmpty {
            mostrarAlerta("Campos vacíos", "Completa los tres campos.")
            return
        }
        if dni.count != 8 || Int(dni) == nil {
            mostrarAlerta("DNI inválido", "El DNI debe tener exactamente 8 dígitos.")
            return
        }
        cliente = ClienteModel(nombre: nombre, apellido: apellido, dni: dni)
        performSegue(withIdentifier: "verBoleta", sender: nil)
    }

    func mostrarAlerta(_ titulo: String, _ mensaje: String) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verBoleta" {
            let destino = segue.destination as! BoletaViewController
            destino.carrito = carrito
            destino.cliente = cliente
        }
    }
}
