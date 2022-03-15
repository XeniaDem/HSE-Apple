//
//  LoginViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 07.02.2022.
//

import UIKit

protocol LoginViewControllerDelegate {
    func openRegistrationVC()
    func openAuthorizationVC()
    func closeVC()
}
class LoginViewController: UIViewController {

    var collectionView: UICollectionView!
    var slides: [Slides] = []
    let slider = Slider()
    var authorizationVC: AuthorizationViewController!
    var registrationVC: RegistrationViewController!
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configurePageControl()
        slides = slider.getSlides()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = CGRect(x: 10, y: view.frame.size.height - 70, width: view.frame.size.width - 20, height: 70)
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .init(red: 241.0/255.0, green: 144.0/255.0, blue: 102.0/255.0, alpha: 1.0)
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register( UINib(nibName: SlideCollectionViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: SlideCollectionViewCell.reuseId)
        collectionView.isPagingEnabled = true
    }
    
    func configurePageControl() {
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        self.view.addSubview(pageControl)
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage 
        collectionView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }
}

extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideCollectionViewCell.reuseId, for: indexPath) as! SlideCollectionViewCell
        cell.delegate = self
        let slide = slides[indexPath.row]
        cell.configure(slide: slide)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(collectionView.contentOffset.x) / Float(collectionView.frame.size.width)))
    }
}

extension LoginViewController : LoginViewControllerDelegate {
    func closeVC() {
        if authorizationVC != nil {
            UIView.transition(with: self.view, duration: 0.5, options: [.transitionFlipFromTop], animations: {
                self.authorizationVC.view.removeFromSuperview()
            }, completion: nil)
            authorizationVC = nil
        }
        if registrationVC != nil {
            UIView.transition(with: self.view, duration: 0.5, options: [.transitionFlipFromTop], animations: {
                self.registrationVC.view.removeFromSuperview()
            }, completion: nil)
            registrationVC = nil
        }
        pageControl.isHidden = false
    }
    
    func openRegistrationVC() {
        if registrationVC == nil {
            registrationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController
        }
        registrationVC.loginVCDelegate = self
        UIView.transition(with: self.view, duration: 0.5, options: [.transitionFlipFromBottom], animations: {
            self.view.insertSubview(self.registrationVC.view, at: 1)
        }, completion: nil)
        pageControl.isHidden = true;
    }
    func openAuthorizationVC() {
        if authorizationVC == nil {
            authorizationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthorizationViewController") as? AuthorizationViewController
        }
        authorizationVC.loginVCDelegate = self
        UIView.transition(with: self.view, duration: 0.5, options: [.transitionFlipFromBottom], animations: {
            self.view.insertSubview(self.authorizationVC.view, at: 1)
        }, completion: nil)
        pageControl.isHidden = true;
    }
}

