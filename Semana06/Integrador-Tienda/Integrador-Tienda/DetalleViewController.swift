import UIKit

class DetalleViewController: UIViewController {

    var producto: Producto!
    var carrito: CarritoModel!

    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var cantidadLabel: UILabel!
    @IBOutlet weak var cantidadStepper: UIStepper!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        nombreLabel.text = producto.nombre
        precioLabel.text = "Precio: S/ " + String(format: "%.2f", producto.precio)
        stockLabel.text = "Stock: \(producto.stock)"
        cantidadStepper.minimumValue = 1
        cantidadStepper.maximumValue = 99
        cantidadStepper.value = 1
        cantidadLabel.text = "1"
    }
    
    @IBAction func stepperCambio(_ sender: UIStepper) {
        cantidadLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func agregarTapped(_ sender: UIButton) {
        let cantidad = Int(cantidadStepper.value)
        if carrito.agregar(producto: producto, cantidad: cantidad) {
            navigationController?.popViewController(animated: true)
        } else {
            let alerta = UIAlertController(title: "Stock insuficiente",
                                            message: "No hay stock suficiente para esa cantidad.",
                                            preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default))
            present(alerta, animated: true)
        }
    }
}
