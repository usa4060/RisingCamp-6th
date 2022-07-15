
import UIKit
import Alamofire
class FindRestaurantViewController: UIViewController {
    
    
    
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var middleView: UIView!
    
    var images = [UIImage(named: "pageControll1.jpeg")!, UIImage(named: "pageControll2.jpeg")!, UIImage(named: "pageControll3.jpeg")!, UIImage(named: "pageControll4.jpeg")!, UIImage(named: "pageControll5.jpeg")!, ]
    var imageView = [UIImageView]()
    var RestaurantInfo : [Datum] = []
    var resName : [String] = []
    var imageURL : [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .white
        scrollView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        filterBtn.layer.borderWidth = 1
        filterBtn.layer.cornerRadius = 13
        filterBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        middleView.layer.borderWidth = 0
        middleView.layer.shadowOffset = CGSize(width: 0, height: 3)
        middleView.layer.shadowOpacity = 0.5
        middleView.layer.shadowRadius = 12
        addContentScrollView()
        setPageControl()
        
        self.fetchRestaurantInfo { [weak self] result in
            guard let self = self else {return;}
        }
        
        print(resName.count)
        registerNib()
        setupFlowLayout()
    }
    
    private func fetchRestaurantImage(
        keyword : String, complitionHandler: @escaping (Result<KakaoImage, Error>) -> Void
    ){
        
        let url = "https://dapi.kakao.com/v2/search/image?query=\(keyword)1&page=1&size=1"
        let header : HTTPHeaders = ["Authorization" : "KakaoAK f3307185e766c86de2e715d1ce2eab74"]
        let request = AF.request(url, method: .get, encoding: URLEncoding.default ,headers: header)
        request.responseDecodable(of: KakaoImage.self){response in
            guard let image = response.value else {return;}
            self.imageURL.append(image.documents[0].imageURL)
            print(image.documents[0].imageURL)
            print(self.imageURL.count)
        }
        
    }
    
    
    private func fetchRestaurantInfo(
        complitionHandler: @escaping (Result<Welcome, Error>) -> Void
    ){
        let url = "https://api.odcloud.kr/api/15066516/v1/uddi:507e01f5-76ec-42ff-96a5-8b6ff9ce554e?page=1&perPage=10&serviceKey=fowOB%2Bj2tJTM0JKO5%2BmliF2O4FEIr8fhNrfitZkFFlbh%2Bfrz5s5IFdEcQIpnSIDgvBBxYs2vA1hO%2B8IptUxNtA%3D%3D"
        
        let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
        request.responseDecodable(of:Welcome.self){response in
            guard let info = response.value else {return;}
            for idx in info.data{
                self.RestaurantInfo.append(idx)
                self.resName.append(idx.resName)
                DispatchQueue.global().sync {
                    self.fetchRestaurantImage(keyword: idx.resName) { [weak self] result in
                        guard let self = self else {return;}
                    }
                }
                self.collectionView.reloadData()
            }
        }.resume()
    }
    
    
    private func registerNib() {
        collectionView.register(UINib(nibName: "FindResCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FindResCollectionViewCell")
    }
    
    private func addContentScrollView() {
        for i in 0..<images.count {
            let imageView = UIImageView()
            let xPos = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
            scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
        }
    }
    
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 4
        flowLayout.minimumLineSpacing = 4
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let halfWidth = UIScreen.main.bounds.width / 2
        let height : CGFloat = 200
        flowLayout.itemSize = CGSize(width: halfWidth * 0.9 , height: height)
        self.collectionView.collectionViewLayout = flowLayout
    }
    
    private func setPageControl() {
        pageControl.numberOfPages = images.count
    }
    
    private func setPageControlSelectedPage(currentPage:Int) {
        pageControl.currentPage = currentPage
    }
    
    
    
    
}

extension FindRestaurantViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
}


extension FindRestaurantViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RestaurantInfo.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FindResCollectionViewCell", for: indexPath) as?
                FindResCollectionViewCell else {return UICollectionViewCell()}
        cell.setData(RestaurantInfo[indexPath.row])
        cell.imageView.image = UIImage(named: "\(indexPath.row+1).jpeg")
        cell.imageView.contentMode = .scaleToFill
        return cell;
    }
}
