import UIKit

class ResumenViewController: UIViewController {

    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var tasaLabel: UILabel!
    @IBOutlet weak var plazoLabel: UILabel!
    @IBOutlet weak var cuotaLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    var venta: VentaModel?
    override func viewDidLoad() {
            super.viewDidLoad()

            guard let venta = venta else {
                print("ERROR: No se recibió VentaModel")
                return
            }

            precioLabel.text = String(format: "S/ %.2f", venta.precio)
            tasaLabel.text = String(format: "%.2f %%", venta.tasaAnual)
            plazoLabel.text = "\(venta.plazoMeses) meses"
            cuotaLabel.text = String(format: "S/ %.2f", venta.cuotaMensual)
            totalLabel.text = String(format: "S/ %.2f", venta.totalPagar)
        }
}
