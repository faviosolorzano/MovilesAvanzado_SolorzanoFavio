
import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {

    @IBOutlet weak var TablaContacto: UITableView!

    var contactos = [Contacto]()
    var contactosFiltrados = [Contacto]()
    var buscando = false

    override func viewDidLoad() {
        super.viewDidLoad()

        TablaContacto.dataSource = self
        TablaContacto.delegate = self

        mostrarRutaBaseDeDatos()
        cargarInfoCoreData()
        
        let buscador = UISearchController(searchResultsController: nil)
        buscador.searchResultsUpdater = self
        buscador.obscuresBackgroundDuringPresentation = false
        buscador.searchBar.placeholder = "Buscar contacto por nombre"

        navigationItem.searchController = buscador
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    // Conexion Core Data

    func conexion() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }

    func mostrarRutaBaseDeDatos() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let ruta = delegate.persistentContainer
            .persistentStoreDescriptions.first?.url?.path ?? "sin ruta"

        print("Base de datos SQLite en: \(ruta)")
    }

    // READ

    func cargarInfoCoreData() {
        let contexto = conexion()
        let request: NSFetchRequest<Contacto> = Contacto.fetchRequest()

        request.sortDescriptors = [
            NSSortDescriptor(key: "nombre", ascending: true)
        ]

        do {
            contactos = try contexto.fetch(request)
        } catch {
            print("Error al cargar: \(error)")
        }
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return buscando ? contactosFiltrados.count : contactos.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let celda = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath
        )

        let contacto = buscando
            ? contactosFiltrados[indexPath.row]
            : contactos[indexPath.row]

        celda.textLabel?.text = contacto.nombre
        celda.detailTextLabel?.text =
            "\(contacto.telefono ?? "") | \(contacto.direccion ?? "")"

        return celda
    }

    // CREATE

    @IBAction func agregarContacto(_ sender: UIBarButtonItem) {

        let alert = UIAlertController(
            title: "Agregar Contacto",
            message: "Nuevo Contacto",
            preferredStyle: .alert
        )

        alert.addTextField { $0.placeholder = "Nombre" }
        alert.addTextField { $0.placeholder = "Telefono" }
        alert.addTextField { $0.placeholder = "Direccion" }

        let aceptar = UIAlertAction(title: "Aceptar", style: .default) { _ in

            guard let nombre = alert.textFields?[0].text,
                  !nombre.isEmpty else { return }

            let contexto = self.conexion()
            let contacto = Contacto(context: contexto)

            contacto.nombre = nombre
            contacto.telefono = alert.textFields?[1].text ?? ""
            contacto.direccion = alert.textFields?[2].text ?? ""

            do {
                try contexto.save()
                self.cargarInfoCoreData()
                self.TablaContacto.reloadData()
            } catch {
                print("Error al guardar: \(error)")
            }
        }

        alert.addAction(aceptar)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))

        present(alert, animated: true)
    }

    // UPDATE

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        let contacto = contactos[indexPath.row]

        let alert = UIAlertController(
            title: "Editar Contacto",
            message: "Modifica los datos",
            preferredStyle: .alert
        )

        alert.addTextField { $0.text = contacto.nombre }
        alert.addTextField { $0.text = contacto.telefono }
        alert.addTextField { $0.text = contacto.direccion }

        let guardar = UIAlertAction(title: "Guardar", style: .default) { _ in

            guard let nombre = alert.textFields?[0].text,
                  !nombre.isEmpty else { return }

            contacto.nombre = nombre
            contacto.telefono = alert.textFields?[1].text
            contacto.direccion = alert.textFields?[2].text

            do {
                try self.conexion().save()
                self.cargarInfoCoreData()
                self.TablaContacto.reloadData()
            } catch {
                print("Error al actualizar: \(error)")
            }
        }

        alert.addAction(guardar)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))

        present(alert, animated: true)
    }

    // DELETE

    func eliminarContacto(at indexPath: IndexPath) {

        let contexto = conexion()
        let contacto = buscando
            ? contactosFiltrados[indexPath.row]
            : contactos[indexPath.row]

        contexto.delete(contacto)

        do {
            try contexto.save()
            cargarInfoCoreData()

            if buscando {
                let texto = navigationItem.searchController?.searchBar.text ?? ""
                contactosFiltrados = buscarContactos(texto: texto)
            }

            TablaContacto.reloadData()
        } catch {
            contexto.rollback()
            print("Error al eliminar: \(error)")
        }
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            eliminarContacto(at: indexPath)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let texto = searchController.searchBar.text ?? ""
        buscando = !texto.isEmpty

        if buscando {
            contactosFiltrados = buscarContactos(texto: texto)
        } else {
            contactosFiltrados = []
        }

        TablaContacto.reloadData()
    }
}
