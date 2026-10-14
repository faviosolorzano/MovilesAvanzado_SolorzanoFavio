import UIKit

class CulturaDetalleViewController: UIViewController {

    var cultura: Cultura!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = cultura.nombre

        let imagen = UIImageView(image: UIImage(named: cultura.imagen) ?? UIImage(systemName: "photo"))
        imagen.contentMode = .scaleAspectFill
        imagen.clipsToBounds = true
        imagen.layer.cornerRadius = 12
        imagen.heightAnchor.constraint(equalToConstant: 240).isActive = true

        let nombre = UILabel()
        nombre.text = cultura.nombre
        nombre.font = .boldSystemFont(ofSize: 28)

        let region = UILabel()
        region.text = "Región: \(cultura.region)"
        region.font = .systemFont(ofSize: 17, weight: .medium)
        region.textColor = .secondaryLabel

        let descripcion = UILabel()
        descripcion.text = cultura.descripcion
        descripcion.font = .systemFont(ofSize: 16)
        descripcion.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [imagen, nombre, region, descripcion])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
