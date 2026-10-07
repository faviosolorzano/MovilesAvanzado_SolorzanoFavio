import UIKit

class CarritoViewController: UIViewController {

    var carrito: CarritoModel!

    @IBOutlet weak var productosLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var descuentoLabel: UILabel!
    @IBOutlet weak var igvLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var categoriaLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        productosLabel.numberOfLines = 0

        var lineas = ""
        for item in carrito.items {
            lineas += "\(item.producto.nombre) x\(item.cantidad)  S/ " + String(format: "%.2f", item.subtotal()) + "\n"
        }
        productosLabel.text = lineas

        let pct = Int(carrito.porcentajeDescuento() * 100)
        subtotalLabel.text = "SubTotal: S/ " + String(format: "%.2f", carrito.subtotal())
        descuentoLabel.text = "Descuento (\(pct)%): -S/ " + String(format: "%.2f", carrito.descuento())
        igvLabel.text = "IGV (18%): S/ " + String(format: "%.2f", carrito.igv())
        totalLabel.text = "TOTAL: S/ " + String(format: "%.2f", carrito.total())
        categoriaLabel.text = "Categoría: " + carrito.categoria()
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "irDatosCliente" && carrito.items.isEmpty {
            let alerta = UIAlertController(title: "Carrito vacío",
                                           message: "Agrega al menos un producto.",
                                           preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default))
            present(alerta, animated: true)
            return false
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "irDatosCliente" {
            let destino = segue.destination as! DatosClienteViewController
            destino.carrito = carrito
        }
    }
}
