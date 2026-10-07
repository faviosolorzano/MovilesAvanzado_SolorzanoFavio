import UIKit

class BoletaViewController: UIViewController {

    var carrito: CarritoModel!
    var cliente: ClienteModel!

    @IBOutlet weak var boletaLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        boletaLabel.numberOfLines = 0
        boletaLabel.font = UIFont.monospacedSystemFont(ofSize: 12, weight: .regular)

        var t = "=========== BOLETA DE COMPRA ===========\n"
        t += "Cliente: \(cliente.nombre) \(cliente.apellido) (\(carrito.categoria())) DNI: \(cliente.dni)\n"
        t += "----------------------------------------\n"
        for item in carrito.items {
            t += "\(item.producto.nombre) x\(item.cantidad)  S/ " + String(format: "%.2f", item.subtotal()) + "\n"
        }
        t += "----------------------------------------\n"
        let pct = Int(carrito.porcentajeDescuento() * 100)
        t += "Subtotal: S/ " + String(format: "%.2f", carrito.subtotal()) + "\n"
        t += "Descuento (\(pct)%): -S/ " + String(format: "%.2f", carrito.descuento()) + "\n"
        t += "IGV (18%): S/ " + String(format: "%.2f", carrito.igv()) + "\n"
        t += "TOTAL: S/ " + String(format: "%.2f", carrito.total()) + "\n"
        t += "========================================"
        boletaLabel.text = t

        carrito.confirmarCompra()
    }

    @IBAction func cerrarTapped(_ sender: UIButton) {
        let nav = (presentingViewController as? UINavigationController) ?? presentingViewController?.navigationController
        dismiss(animated: true) {
            nav?.popToRootViewController(animated: false)
        }
    }
}
