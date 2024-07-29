import UIKit
import CoreData
import GoogleSignIn

class GalleryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var photos: [UnsplashPhoto] = []
    var pageNumber = 1
    let pageSize = 20
    let accessKey = "mxqoB-RrdJcUwvgpMehLo4dIq-4oJ9KQdjoZsJPThkQ"

    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ImageCell")
        fetchImages()
        loadSavedImages()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)

        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        cell.contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])

        let photo = photos[indexPath.row]

        DispatchQueue.global().async {
            guard let url = URL(string: photo.urls.regular) else { return }
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
                
                // Save images to Core Data for offline access
                self.saveImageToCoreData(photo: photo, imageData: data)
            } catch {
                print("Error fetching image data: \(error.localizedDescription)")
            }
        }

        if indexPath.row == photos.count - 1 {
            fetchImages()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = .white // Optional: set cell background color
        cell.layer.masksToBounds = true // Optional: add corner radius for a rounded effect
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }

    // Fetch images from Unsplash API
    func fetchImages() {
        let urlString = "https://api.unsplash.com/photos/?client_id=\(accessKey)&page=\(pageNumber)&per_page=\(pageSize)"
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching images: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let photos = try? JSONDecoder().decode([UnsplashPhoto].self, from: data) {
                self.photos.append(contentsOf: photos)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

                self.pageNumber += 1
            }
        }

        task.resume()
    }
    
    // Save image to Core Data
    func saveImageToCoreData(photo: UnsplashPhoto, imageData: Data) {
        let uuid = UUID() // Generate a new UUID for each image
        CoreDataHelper.shared.saveImage(id: uuid, url: photo.urls.regular, imageData: imageData)
    }

    // Load saved images from Core Data
    func loadSavedImages() {
        if let savedImages = CoreDataHelper.shared.fetchImages() {
            // Handle loading and displaying saved images if necessary
            // You can update the photos array and reload the table view as needed
        }
    }

    @IBAction func logout(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signOut()
        self.navigationController?.popToRootViewController(animated: true)
    }
}
