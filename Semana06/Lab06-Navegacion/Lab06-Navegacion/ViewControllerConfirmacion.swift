import UIKit

class ViewControllerConfirmacion: UIViewController {

    
    @IBOutlet weak var lblApellido: UILabel!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblDni: UILabel!
    
    var cliente: ClienteModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        lblApellido.text = cliente?.apellido
        lblNombre.text = cliente?.nombre
        lblDni.text = cliente?.dni
    }

    @IBAction func cerrarModal(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
