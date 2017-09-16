import UIKit

class WikipediaImageDisplayVC: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate  {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    var allImages = [Image]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        searchField.delegate = self
        searchField.addTarget(self, action: #selector(WikipediaImageDisplayVC.textDidChange(_:)), for: UIControlEvents.editingChanged)
    }

    func textDidChange(_ sender: UITextField) {
        WikipediaAPIClient.generateWikipediaImages(for: searchField.text ?? "") {
            (response) in
            switch response {
            case .success(let responseImages):
                self.allImages = responseImages
                print("The number of images are ", responseImages.count)
            case .failure(let error):
                print(error.localizedDescription)

                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        self.collectionView.reloadData()
    }

    // MARK: - Data Source

    //we only need one section, there are no separate categories of images

    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }


    //we can either return the count of the images in the image array, or hard code it to 50, either way it is the same result

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImages.count
    }




    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! WikipediaImageViewCell
        let image = allImages[indexPath.item].image
        cell.imageViewCell.image = image

        let finalFrame: CGRect = cell.frame
        cell.frame = CGRect(x: finalFrame.origin.x - 1000, y: -500, width: 200, height: 200)

        UIView.animate(withDuration: 1, animations: {
            cell.frame = finalFrame

        })

        return cell
    }
}
