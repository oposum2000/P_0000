//
//  Utils.swift
//  Health Results
//
//  Created by Nashu on 6/1/21.
//

import MediaPlayer
import Foundation
import CoreGraphics
import GameplayKit


extension UIViewController {

        func a(_ c:UIViewController,s:CGPoint,f:CGPoint,duration:CFTimeInterval,remove:Bool){
            c.view.transform.tx = s.x
            c.view.transform.ty = s.y
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: [.curveEaseInOut, .beginFromCurrentState],
                           animations: {
                            c.view.transform = CGAffineTransform(translationX: f.x, y: f.y)
                           }, completion: { finished in
                            c.view.transform = .identity
                            if remove {
                                c.removeFromParent()
                                c.view.removeFromSuperview()
                            }
                           })
        }
        
        func transitionTo(_ c: UIViewController, duration: CFTimeInterval, dir: CATransitionSubtype,self_remove:Bool=true,self_move:Bool=true) {
            switch dir {
            case .fromLeft:
                if self_move { a(self, s: self.view.frame.origin, f: CGPoint(x: self.view.transform.tx+self.view.frame.width, y: 0), duration: duration, remove: self_remove) }
                a(c, s: CGPoint(x: -self.view.frame.width, y: 0), f: CGPoint(x: 0, y: 0), duration: duration, remove: false)
            case .fromRight:
                if self_move { a(self, s: self.view.frame.origin, f: CGPoint(x: self.view.transform.tx-self.view.frame.width, y: 0), duration: duration, remove: self_remove) }
                a(c, s: CGPoint(x: self.view.frame.width, y: 0), f: CGPoint(x: 0, y: 0), duration: duration, remove: false)
                
                
            default:
                print("mda !!! la directie")
            }
        }
    }



func posAreClose(_ n:CGPoint, _ m:CGPoint, close:CGFloat = 20)->Bool{
    
    if (m.x <= n.x+close)&&(m.x>=n.x-close)&&(m.y <= n.y+close)&&(m.y >= n.y-close) {
        return true
    }
    return false
}

func shortString(_ n:Int)->String{
    if n < 1000 {
        return String(n)
    }
    if n < 1000000 {
        return String(format: "%.1f",Double(n)/1000)+"K"
    }
    return String(format: "%.1f",Double(n)/1000000)+"M"
}

func timeToDate(_ t:TimeInterval)->String{
    var divisions = 0
    var timeLeft = t
    var d = ""
    var zs:TimeInterval = 60*60*24
    var os:TimeInterval = 60*60
    var ms:TimeInterval = 60
    
    var i = 0
    var again = true
    while again {
        if timeLeft - zs >= 0 {
            timeLeft = timeLeft - zs
            i = i + 1
        }else{
            again = false
        }
    }
    if i > 0 {
        d = d + String(i) + "D "
        i = 0
        divisions = divisions + 1
    }
    again = true
    while again {
        if timeLeft - os >= 0 {
            timeLeft = timeLeft - os
            i = i + 1
        }else{
            again = false
        }
    }
    if i > 0 {
        d = d + String(i) + "H "
        i = 0
        divisions = divisions + 1
    }
    if divisions > 1 {
        return d
    }
    again = true
    while again {
        if timeLeft - ms >= 0 {
            timeLeft = timeLeft - ms
            i = i + 1
        }else{
            again = false
        }
    }
    if i > 0 {
        d = d + String(i) + "m "
        i = 0
        divisions = divisions + 1
    }
    if divisions > 1 {
        return d
    }
    if timeLeft >= 1 || divisions == 0 {
        d = d + String(Int(timeLeft)) + "s"
    }
    return d
}





public func execute(after seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
    let dispatchTime = DispatchTime.now() + seconds
    dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
}

public enum DispatchLevel {
    case main, userInteractive, userInitiated, utility, background
    var dispatchQueue: DispatchQueue {
        switch self {
        case .main:                 return DispatchQueue.main
        case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
        case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
        case .utility:              return DispatchQueue.global(qos: .utility)
        case .background:           return DispatchQueue.global(qos: .background)
        }
    }
}



func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func += (left: inout CGPoint, right: CGPoint) {
    left = left + right
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func -= (left: inout CGPoint, right: CGPoint) {
    left = left - right
}

func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

func *= (left: inout CGPoint, right: CGPoint) {
    left = left * right
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func *= (point: inout CGPoint, scalar: CGFloat) {
    point = point * scalar
}

func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

func /= (left: inout CGPoint, right: CGPoint) {
    left = left / right
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

func /= (point: inout CGPoint, scalar: CGFloat) {
    point = point / scalar
}

func / (size: CGSize, scalar: CGFloat) -> CGSize {
    return CGSize(width: size.width / scalar, height: size.height / scalar)
}

func * (size: CGSize, scalar: CGFloat) -> CGSize {
    return CGSize(width: size.width * scalar, height: size.height * scalar)
}

#if !(arch(x86_64) || arch(arm64))
func atan2(y: CGFloat, x: CGFloat) -> CGFloat {
    return CGFloat(atan2f(Float(y), Float(x)))
}

func sqrt(a: CGFloat) -> CGFloat {
    return CGFloat(sqrtf(Float(a)))
}
#endif

struct Color : Codable {
    var red : CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0

    var uiColor : UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    init(uiColor : UIColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) == 6) {
        cString = cString+"ff"
    }else{
        if ((cString.count) != 8) {
            return UIColor.gray
        }
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0,
        green: CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0,
        blue: CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0,
        alpha: CGFloat(rgbValue & 0x000000FF) / 255.0//CGFloat(1.0)
    )
}


extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        // Need to use the MPVolumeView in order to change volume, but don't care about UI set so frame to .zero
        let volumeView = MPVolumeView(frame: .zero)
        // Search for the slider
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        // Update the slider value with the desired volume.
        DispatchQueue.main.async {
            slider?.value = volume
        }
    }
}



extension CGPoint {
    
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
    
    var angle: CGFloat {
        return atan2(y, x)
    }
}

let π = CGFloat(M_PI)



func shortestAngleBetween(_ angle1: CGFloat,
                          angle2: CGFloat) -> CGFloat {
    let twoπ = π * 2.0
    var angle = (angle2 - angle1).truncatingRemainder(dividingBy: twoπ)
    if (angle >= π) {
        angle = angle - twoπ
    }
    if (angle <= -π) {
        angle = angle + twoπ
    }
    return angle
}



extension CGFloat {
    func sign() -> CGFloat {
        return (self >= 0.0) ? 1.0 : -1.0
    }
    
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UInt32.max))
    }
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(min < max)
        return CGFloat.random() * (max - min) + min
    }
}

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
    
}

extension UIColor {
    
    func rgb() -> Int? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)
            
            //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
            let rgb = (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue
            return rgb
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
    
    var rgbComponents:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
         var r:CGFloat = 0
         var g:CGFloat = 0
         var b:CGFloat = 0
         var a:CGFloat = 0
         if getRed(&r, green: &g, blue: &b, alpha: &a) {
             return (r,g,b,a)
         }
         return (0,0,0,0)
     }
     // hue, saturation, brightness and alpha components from UIColor**
     var hsbComponents:(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
         var hue:CGFloat = 0
         var saturation:CGFloat = 0
         var brightness:CGFloat = 0
         var alpha:CGFloat = 0
         if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha){
             return (hue,saturation,brightness,alpha)
         }
         return (0,0,0,0)
     }
     var htmlRGBColor:String {
         return String(format: "#%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255))
     }
     var htmlRGBaColor:String {
         return String(format: "#%02x%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255),Int(rgbComponents.alpha * 255) )
     }
}

//var cacheGif = [(String,Double,[UIImage])]()
//var cacheGifToSprite = [(String,Double,Bool,[SKSpriteNode])]()
//var cachIMG = [(String,UIImage)]()

//
//extension UIImageView {
//    static func fromGif(frame: CGRect, resourceName: String) -> UIImageView? {
//
//        if let pair = cacheGif.first(where: {$0.0 == resourceName}) {
//            let gifImageView = UIImageView(frame: frame)
//            gifImageView.animationImages = pair.2
//            return gifImageView
//        }else{
//            let fname = FileDownloader.getBaseFolder()+"/DLC/"+resourceName+".gif"
//
//            let url = URL(fileURLWithPath: fname)
//            if !FileManager().fileExists(atPath: fname) {
//                print("Gif does not exist at that path:",resourceName)
//                return (UIImageView())
//            }
//            guard let gifData = try? Data(contentsOf: url),
//                let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
//            var images = [UIImage]()
//            let imageCount = CGImageSourceGetCount(source)
//            //print("image count=",imageCount)
//            for i in 0 ..< imageCount {
//                if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
//                    images.append(UIImage(cgImage: image))
//                }
//            }
//            let gifImageView = UIImageView(frame: frame)
//            gifImageView.animationImages = images
//            cacheGif.append((resourceName,(Double(imageCount)*0.01),images))
//            return gifImageView
//        }
//    }
//}

extension UIView {
    func fadeTo(_ alpha: CGFloat, duration: TimeInterval = 0.3) {
        DispatchQueue.main.async {
            print("3in async")
            UIView.animate(withDuration: duration) {
                self.alpha = alpha
            }
            print("3din async")
        }
    }
    
    func fadeIn(_ duration: TimeInterval = 0.3) {
        fadeTo(1.0, duration: duration)
    }
    
    func fadeOut(_ duration: TimeInterval = 0.3) {
        fadeTo(0.0, duration: duration)
    }
    func apply(scaleX : CGFloat = 1, scaleY : CGFloat = 1 , x : CGFloat , y : CGFloat , duration : TimeInterval){
        let originalTransform = self.transform
        let scaledTransform = originalTransform.scaledBy(x: scaleX, y: scaleY)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: y)
        UIView.animate(withDuration: duration, animations: {
            self.transform = scaledAndTranslatedTransform
        })
    }
    
    func animateTo(frame: CGRect, withDuration duration: TimeInterval, completion: ((Bool) -> Void)? = nil) {
      guard let _ = superview else {
        return
      }
      
      let xScale = frame.size.width / self.frame.size.width
      let yScale = frame.size.height / self.frame.size.height
      let x = frame.origin.x + (self.frame.width * xScale) * self.layer.anchorPoint.x
      let y = frame.origin.y + (self.frame.height * yScale) * self.layer.anchorPoint.y
     
      UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: {
        self.layer.position = CGPoint(x: x, y: y)
        self.transform = self.transform.scaledBy(x: xScale, y: yScale)
      }, completion: completion)
    }
}


extension UIImage{

func saveImage(inDir:FileManager.SearchPathDirectory,name:String){
    guard let documentDirectoryPath = FileManager.default.urls(for: inDir, in: .userDomainMask).first else {
        return
    }
    let img = UIImage(named: "\(name).jpg")!

    // Change extension if you want to save as PNG.
    let imgPath = URL(fileURLWithPath: documentDirectoryPath.appendingPathComponent("\(name).jpg").absoluteString)
    do {
        try img.jpegData(compressionQuality: 0.5)?.write(to: imgPath, options: .atomic)
    } catch {
        print(error.localizedDescription)
    }
  }
}

//
//extension SKSpriteNode {
//    static func fromGif(resourceName: String, _ nr : Int = -1) -> ([SKSpriteNode],Bool) {
//        var name = resourceName
//        if nr > 0 { name = name + "_" + String(nr)}
//        if let pair = cacheGifToSprite.first(where: {$0.0 == name}) {
//            return (pair.3,pair.2) /// 3 este sirul de imagini si 2 este daca exista sau nu
//        }else{
//            let fname = FileDownloader.getBaseFolder()+"/DLC/"+name+".gif"
//
//            let url = URL(fileURLWithPath: fname)
//
//            guard let gifData = try? Data(contentsOf: url),
//                let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return ([],false) }
//            var images = [SKSpriteNode]()
//            let imageCount = CGImageSourceGetCount(source)
//            //print("image count=",imageCount)
//            for i in 0 ..< imageCount {
//                if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
//
//                    //print("img sr:",resourceName," ->",image.width)
//                    images.append(SKSpriteNode.init(texture: SKTexture(image :UIImage(cgImage: image))))
//                }
//            }
//            cacheGifToSprite.append((name,(Double(imageCount)*0.01),true,images))
//            return (images,true)
//        }
//    }
//
//
//}


// MARK: Points and vectors
extension CGPoint {
    init(_ point: SIMD2<Float>) {
        self.init()
        x = CGFloat(point.x)
        y = CGFloat(point.y)
    }
}
extension float2 {
    init(_ point: CGPoint) {
        self.init(x: Float(point.x), y: Float(point.y))
    }
}

func att(_ name: String,fname : String = "Helvetica",fcolor: UIColor = UIColor.white,bcolor : UIColor = UIColor.black,stroke : CGFloat = -4.0, size:CGFloat = 30)->NSAttributedString{
    let attrString = NSAttributedString(
        string: name == "" ? " ":name,
        attributes: [
            NSAttributedString.Key.strokeColor: bcolor,
            NSAttributedString.Key.foregroundColor: fcolor,
            NSAttributedString.Key.strokeWidth: stroke,
            NSAttributedString.Key.font : UIFont.init(name: fname, size: size)
        ]
    )
    return attrString
}


extension UIButton {
    func btnProperties() {
        layer.cornerRadius = 10//Set button corner radious
        clipsToBounds = true
        backgroundColor = .darkGray//Set background colour
        //titleLabel?.textAlignment = .center//add properties like this
    }
}

extension UIImage {
    class func resizeA(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if widthRatio < heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: targetSize.height-newSize.height, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    class func resize(image: UIImage, targetSize: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    class func scale(image: UIImage, by scale: CGFloat) -> UIImage? {
        let size = image.size
        let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)
        return UIImage.resize(image: image, targetSize: scaledSize)
    }
    
//    class func extImg(name:String,ext:String=".png",folder:String="",size:CGSize,fitToSize:Bool=true) -> UIImage{
//        if let pair = cachIMG.first(where: {$0.0 == name}) {
//            return pair.1
//        }
//        let fname = FileDownloader.getBaseFolder()+"/DLC/"+folder+name+ext
//        if FileManager().fileExists(atPath: fname) {
//            guard let img = UIImage(contentsOfFile: fname) else{
//                print("nu a gasit EXTIMG :",name+ext)
//                return UIImage()
//            }
//            print("a citit EXTIMG :",name+ext)
//            var nimg = UIImage()
//            if fitToSize {
//                nimg = UIImage.resize(image: img, targetSize: CGSize(width: size.width, height: size.height))
//            }else{
//                nimg = UIImage.resizeA(image: img, targetSize: CGSize(width: size.width, height: size.height))
//            }
//            cachIMG.append((name,nimg))
//            return nimg
//        }
//        print("nu a gasit EXTIMG :",folder+name+ext)
//        return UIImage()
//    }
}

extension SKLabelNode {
    func updateAttributedText(_ text: String) {
        if let attributedText = attributedText {
            let linkAttributes = NSMutableAttributedString(attributedString: attributedText)
            let dict = linkAttributes.attributes(at: 0, effectiveRange: nil)
            let attrString = NSAttributedString(
                string: text == "" ? " ":text,
                attributes: dict
            )
            self.attributedText = attrString
        }
    }
}

extension UILabel {
    func updateAttributedText(_ text: String) {
        if let attributedText = attributedText {
            let linkAttributes = NSMutableAttributedString(attributedString: attributedText)
            let dict = linkAttributes.attributes(at: 0, effectiveRange: nil)
            let attrString = NSAttributedString(
                string: text == "" ? " ":text,
                attributes: dict
            )
            self.attributedText = attrString
        }
    }
}

extension Date {
    var toString: String {
        let d = DateFormatter()
        d.dateFormat = "dd/MM/yyyy"
        return d.string(from: self)
    }
}

extension UIImage {
    func fixOrientation() -> UIImage? {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }

        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(origin: .zero, size: self.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
