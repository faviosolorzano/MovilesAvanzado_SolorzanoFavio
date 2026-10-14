import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var culturas: [Cultura] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Culturas Peruanas"
        culturas = [
            Cultura(nombre: "Caral", region: "Valle de Supe, Lima",
                    descripcion: "Una de las civilizaciones más antiguas de América (c. 3000 a.C.). Su ciudad sagrada tiene pirámides, plazas circulares y una organización social compleja.",
                    imagen: "caral"),
            Cultura(nombre: "Chavín", region: "Áncash",
                    descripcion: "Cultura con centro ceremonial en Chavín de Huántar, con galerías subterráneas y el Lanzón monolítico. Su influencia religiosa se extendió por los Andes.",
                    imagen: "chavin"),
            Cultura(nombre: "Paracas", region: "Ica",
                    descripcion: "Famosa por sus mantos bordados de gran calidad y por sus trepanaciones craneanas. Se desarrolló en la costa sur.",
                    imagen: "paracas"),
            Cultura(nombre: "Nazca", region: "Ica",
                    descripcion: "Conocida por los geoglifos de las Líneas de Nazca, su cerámica polícroma y los acueductos subterráneos llamados puquios.",
                    imagen: "nazca"),
            Cultura(nombre: "Moche", region: "La Libertad y Lambayeque",
                    descripcion: "Cultura de la costa norte con grandes huacas como la del Sol y la de la Luna. Destacó por su orfebrería y sus ceramios retrato; el Señor de Sipán es su hallazgo más célebre.",
                    imagen: "moche"),
            Cultura(nombre: "Inca", region: "Cusco",
                    descripcion: "Imperio del Tahuantinsuyo (siglos XV-XVI). Construyó Machu Picchu y el Qhapaq Ñan, una extensa red de caminos.",
                    imagen: "inca")
        ]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return culturas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "miCell") as? PersonasTableViewCell
        let c = culturas[indexPath.row]
        cell?.personaNombre.text = c.nombre
        cell?.PersonaImagen.image = UIImage(named: c.imagen) ?? UIImage(systemName: "photo")
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detalle = CulturaDetalleViewController()
        detalle.cultura = culturas[indexPath.row]
        navigationController?.pushViewController(detalle, animated: true)
    }
}
