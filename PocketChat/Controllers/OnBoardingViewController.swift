//
//  OnBoardingViewController.swift
//  PocketChat
//
//  Created by Igor Parnadjiev on 17.5.21.
//

import UIKit

class OnBoardingViewController: UIViewController, UIScrollViewDelegate {
   
    var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:70,y: 350, width:200, height:50))

    private let scrollView: UIScrollView = {
        var scrollView = UIScrollView(frame: CGRect(x: 39, y: 58, width: 297, height: 297))
        
        return scrollView
    }()
        
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pattern")
        image.systemLayoutSizeFitting(CGSize(width: 389, height: 242))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.frame.size = CGSize(width: 236, height: 50)
        stackView.autoresizesSubviews = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 30
        return stackView
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 47).isActive = true
        button.widthAnchor.constraint(equalToConstant: 103).isActive = true
        button.backgroundColor = UIColor(hex: "A8E490")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(loginButtonTapped) , for: .touchUpInside)
        return button
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 47).isActive = true
        button.widthAnchor.constraint(equalToConstant: 103).isActive = true
        button.backgroundColor = UIColor(hex: "A8E490")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 24
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func loginButtonTapped() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func signupButtonTapped() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    let images = ["scrollview01", "scrollview02", "scrollview03"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupImage(view: view)
        view.addSubview(stackView)
        view.addSubview(scrollView)
        setupScrollView()
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupImage(view: UIView) {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        view.addSubview(image)
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    private func setupButtons(){
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(signupButton)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -169),
        ])
    }
    
    private func setupScrollView() {
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        
        for index in 0..<images.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            let imageView = UIImageView(frame: frame)
            imageView.image = UIImage(named: images[index])
            self.scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count), height: scrollView.frame.size.height)
        scrollView.delegate = self
        configurePageControl()
    }
    
    
    private func configurePageControl() {
        self.pageControl.numberOfPages = images.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.green
//        pageControl.setIndicatorImage(UIImage(named: "activepage"), forPage: pageControl.currentPage)
        self.view.addSubview(pageControl)
        
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    private func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
//        pageControl.setIndicatorImage(UIImage(named: "activepage"), forPage: pageControl.currentPage)
        
    }
    
    internal func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
