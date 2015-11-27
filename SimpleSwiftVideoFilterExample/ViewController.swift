import UIKit
import GPUImage

class ViewController: UIViewController {
    
    var videoCamera:GPUImageVideoCamera?
    
    var unsharp = GPUImageUnsharpMaskFilter()
    var contrast = GPUImageContrastFilter()
    var eye = GPUImageShiTomasiFeatureDetectionFilter()
    var group = GPUImageFilterGroup()
    var filterOn = false
    var toggle = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .Front)
        videoCamera!.outputImageOrientation = .Portrait;
        
        //This filter smooths the skin, but also smooths everything else.
        //I ONLY want to smooth skin. Do NOT smooth the eyes/hair/lips
        
        videoCamera?.horizontallyMirrorFrontFacingCamera = true
        unsharp.blurRadiusInPixels = 4.0
        unsharp.intensity = 0.5
        contrast.contrast = 1.15
        unsharp.addTarget(contrast)
        
        
        group.addFilter(unsharp)
        group.addFilter(contrast)
        group.initialFilters = [ unsharp ]
        group.terminalFilter = contrast
        videoCamera?.addTarget(group)
        group.addTarget(self.view as! GPUImageView)
        filterOn = true
        
        videoCamera?.startCameraCapture()
        

    }
    
}