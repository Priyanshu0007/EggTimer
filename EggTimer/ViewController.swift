
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var textLabel: UILabel!
    let softTime=3//00
    let mediumTime=4//20
    let hardTime=7//20
    var totalTime=0
    var secondPass=0
    var timer = Timer()
    var player: AVAudioPlayer!
    @IBAction func hardnessSelector(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness=sender.currentTitle!
        switch hardness {
        case "Soft":
            totalTime=softTime
            break
        case "Medium":
            totalTime=mediumTime
            break
        case "Hard":
            totalTime=hardTime
            break
        default:
            break
        }
        progressBar.progress=0.0
        secondPass=0
        textLabel.text=hardness
        timer=Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    @objc func updateTimer() {
        if(secondPass<=totalTime){
            let percentageProgress=Float(secondPass)/Float(totalTime)
            progressBar.progress=percentageProgress
            secondPass+=1
        }else{
            timer.invalidate()
            textLabel.text="Done"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    

}
