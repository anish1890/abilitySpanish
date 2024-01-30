//
//  APPConstantData.swift
//  Workout
//
//  Created by Zero thirteen on 05/08/21.
//

import Foundation
import UIKit

//MARK:- Structer Model

struct WorkoutMainStruct {
    var image: String
    var strCount: String
    var strName: String
    var strDescription: String
    var arrResult : [WorkoutSubStruct]
    
    init(image: String, strCount: String, strName: String, strDescription: String, arrResult : [WorkoutSubStruct]) {
        self.image = image
        self.strCount = strCount
        self.strName = strName
        self.strDescription = strDescription
        self.arrResult = arrResult
    }
}

struct AppSupport {
    static func rateApp(){
        if let url = URL(string:"itms-apps://itunes.apple.com/app/\(appID)") {
            AppSupport.openURL(url)
        }
    }
    
    static func openURL(_ url: URL){
        if UIApplication.shared.canOpenURL(url){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
        
    static func shareApp(inController controller:UIViewController){
        let textToShare = "\(appDelegate.modelConfig.iosShareText ?? "") \n itms-apps://itunes.apple.com/app/\(appID)"
        AppSupport.itemShare(inController: controller, items: textToShare)
    }
    
    static func itemShare(inController controller:UIViewController, items:Any){
        let objectsToShare = [items]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = controller.view
        activityVC.popoverPresentationController?.sourceRect = CGRect(x: 100, y: 200, width: 300, height: 300)
        controller.present(activityVC, animated: true, completion: nil)
    }
}



struct WorkoutSubStruct {
    var name: String
    var image: String
    var duration: String
    var video: String
    var description: String
    var gif: String
    init(name: String, image: String, duration: String, video: String, description: String, gif: String) {
        self.name = name
        self.image = image
        self.duration = duration
        self.video = video
        self.description = description
        self.gif = gif
    }
}

//MARK:- Constant Array

var arrClassic = [
    WorkoutSubStruct(name: "Jumping Jacks", image: "jumpingjack", duration: "30 s", video: "yDSMdd8hiFg", description: "Start with your feet together and your arms by your sides, then jump up with your feet apart and your hands overhead. Return to the start position then do the next rep. This exercise provides a full-body workout and works all your large muscle groups.", gif: "jumping_jacks"),
    WorkoutSubStruct(name: "Wall sit", image: "wallsit.jpg", duration: "30 s", video: "M5MKJ4T4e2k", description: "Start with your back against the wall, then slide down until your knees are at a 90 degree angle. Keep your back against the wall with your hands and arms away from your legs. Hold the position. The exercise is to strengthen the quadriceps muscles.", gif: "wallsit.jpg"),
    WorkoutSubStruct(name: "Push-Ups", image: "pushup", duration: "30 s", video: "Eh00_rniF8E", description: "Lay prone on the ground with arms supporting your body. Keep your body straight while raising and lowering your body with your arms. This exercise works the chest, shoulders, triceps, back and legs.", gif: "pushups"),
    WorkoutSubStruct(name: "Abdominal Crunches", image: "abdombial", duration: "30 s", video: "M6yAoJJQvGY", description: "Lie on your back with your knees bent and your arms stretched forward. Then lift your upper body off the floor. Hold for a few seconds and slowly return. It primarily works the rectus abdominis muscle and the obliques.", gif: "abdominal"),
    WorkoutSubStruct(name: "Step-Up Onto Chair", image: "setupontochair", duration: "30 s", video: "ay-MtjfYtwo", description: "Stand in front of a chair. Then step up on the chair and step back down. The exercise works to strengthen the legs and buttocks.", gif: "step_up_chair"),
    WorkoutSubStruct(name: "Squats", image: "squats", duration: "30 s", video: "SU2UmCkiKC8", description: "Stand with your feet shoulder width apart and your arms stretched forward, then lower your body until your thighs are parallel with the floor. Your knees should be extended in the same direction as your toes. Return to the start position and do the next rep. This works the thighs, hips buttocks, quads, hamstrings and lower body.", gif: "squats_g"),
    WorkoutSubStruct(name: "Triceps Dips", image: "tricepdips", duration: "30 s", video: "6kALZikXxLc", description: "For the start position, sit on the chair. Then move your hip off the chair with your hands holding the edge of the chair. Slowly bend and stretch your arms to make your body go up and down. This is a great exercise for the triceps.", gif: "triceps_dips"),
    WorkoutSubStruct(name: "Planks", image: "plank.jpg", duration: "30 s", video: "pSHjTRCQxIw", description: "Lie on the floor with your toes and forearms on the ground. Keep your body straight and hold this position as long as you can. This exercise strengthens the abdomen, back and shoulders.", gif: "plank.jpg"),
    WorkoutSubStruct(name: "High Stepping", image: "highstepping", duration: "30 s", video: "kMFv3Alg-Gc", description: "Run in place while pulling your knees as high as possible with each step. Keep your upper body upright during this exercise.", gif: "high_stepping"),
    WorkoutSubStruct(name: "Lunges", image: "lunges", duration: "30 s", video: "Z2n58m2i4jg", description: "Stand with your feet shoulder width apart and your hands on your hips. Take a step forward with your right leg and lower your body until your right thigh is parallel with the floor. Then return and switch to the other leg. This exercise strengthens the quadriceps, gluteus maximus and hamstrings.", gif: "lunges_g"),
    WorkoutSubStruct(name: "Push-Up & Rotation", image: "pushuprotation", duration: "30 s", video: "iu3VptPuikY", description: "Start in the push-up position. Then go down for a push-up and as you come up, rotate your upper body and extend your right arm upwards. Repeat the exercise with the other arm. It's a great exercise for the chest, shoulders, arms and core.", gif: "push_up_rotation"),
    WorkoutSubStruct(name: "Side Plank Right", image: "right_side_plank.jpg", duration: "30 s", video: "NXr4Fw8q60o", description: "Lie on your right side with your forearm supporting your body. Hold your body in a straight line. This exercise targets the abdominal muscles and obliques.", gif: "right_side_plank.jpg"),
    WorkoutSubStruct(name: "Side Plank Left", image: "left_side_plank.jpg", duration: "30 s", video: "NXr4Fw8q60o", description: "Lie on your left side with your forearm supporting your body. Hold your body in a straight line. This exercise targets the abdominal muscles and obliques.", gif: "left_side_plank.jpg")
]



var arrAbsworkout = [
    WorkoutSubStruct(name: "Jumping Squats", image: "jumping_squats", duration: "30 s", video: "gijGpRSA9FI", description: "Start in the squat position, then jump up using your abdominal muscles for strength. This exercise works your abdomen.", gif: "jumping_squats_g"),
    WorkoutSubStruct(name: "Reverse Crunches", image: "reverse_crunches", duration: "30 s", video: "hyv14e2QDq0", description: "Lie on your back with your knees up at a 90 degree angle and your hands behind your head. Lift your upper body and thighs, and then stretch out. Repeat this exercise.", gif: "reverse_crunches_g"),
    WorkoutSubStruct(name: "Straight Arm Plank", image: "straight_arm_plank.jpg", duration: "30 s", video: "17ydV85ihp8", description: "Start in the push-up position, but keep your arms straight. This exercise strengthens your abdomen and back muscles.", gif: "straight_arm_plank.jpg"),
    WorkoutSubStruct(name: "Russian Twist", image: "russian_twist", duration: "30 s", video: "wkD8rjkodUI", description: "Sit on the floor with your knees bent, feet lifted a little bit and back tilted backwards.Then hold your hands together and twist from side to side", gif: "russian_twist_g"),
    WorkoutSubStruct(name: "Bird Dog", image: "bird_dog", duration: "30 s", video: "zL0YEtJulBs", description: "Start with your knees under your butt and your hands under your shoulders. Then stretch your right leg and left arm at the same time. Hold for five seconds, then go back and repeat with the other side.", gif: "bird_dog_g"),
    WorkoutSubStruct(name: "Burpees", image: "burpees", duration: "30 s", video: "JZQA08SlJnM", description: "Stand with your feet shoulder width apart, then put your hands on the ground and kick your feet backward. Do a quick push-up and then jump up.", gif: "burpees_g"),
    WorkoutSubStruct(name: "Long Arm Crunches", image: "long_arm_crunches", duration: "30 s", video: "3fDjzzfovZE", description: "Lie on your back with knees bent and feet flat on the floor. Put your arms straight over the top of your head. Lift your upper body off the floor, then slowly go back to the start position. The exercise increases abdominal endurance.", gif: "long_arm_crunch"),
    WorkoutSubStruct(name: "One Leg Bridge", image: "one_leg_bridge", duration: "30 s", video: "nYJNZwm1tPY", description: "Lie on the floor, bend one leg and lift the other leg. Then lift your hips off the floor. Hold the position for five seconds and switch to the other leg. This exercise works your abdomen and hips.", gif: "one_leg_bridge_g"),
    WorkoutSubStruct(name: "One Leg Push-Ups", image: "one_leg_push", duration: "30 s", video: "kvV6Mfchga4", description: "Start in the classic push-up position but lift one leg up. Then do a few push-ups and switch to the other leg. This works on your lower-abdominal muscles", gif: "one_leg_push_ups"),
    WorkoutSubStruct(name: "Plank", image: "plank.jpg", duration: "30 s", video: "pSHjTRCQxIw", description: "Lie on the floor with your toes and forearms on the ground. Keep your body straight and hold this position as long as you can. This exercise strengthens the abdomen, back and shoulders.", gif: "plank.jpg"),
    WorkoutSubStruct(name: "Cross Arm Crunches", image: "cross_arm_crunches", duration: "30 s", video: "mK_VURuFYyQ", description: "Lie down and bend your knees with your feet flat on the floor. Cross your arms in front of your chest. Then lift your head and shoulders up to make a 30 degree angle with the ground. It primarily works on the rectus abdominis muscle and obliques.", gif: "cross_arm_crunches_g"),
    WorkoutSubStruct(name: "Mountain Climber", image: "mountain_climber", duration: "30 s", video: "DyeZM-_VnRc", description: "Start in the push-up position. Bend your right knee towards your chest and keep your left leg straight, then quickly switch from one leg to the other. This exercise strengthens multiple muscle groups.", gif: "mountain_climber_g"),
    WorkoutSubStruct(name: "Bridge", image: "bridge.jpg", duration: "30 s", video: "oje869YCAL4", description: "Lie flat on the floor, and lift your hips off the floor while keeping your back straight. Hold this position as long as you can. The bridge exercise strengthens the whole abdomen, the lower back and the glutes.", gif: "bridge.jpg"),
    WorkoutSubStruct(name: "Bicycle Crunches", image: "bicycle_crunches_g", duration: "30 s", video: "1we3bh9uhqY", description: "Lie on the floor with your hands behind your ears. Raise your knees and close your right elbow toward your left knee, then close your left elbow toward your right knee. Repeat the exercise.", gif: "bicycle_crunches_g.png")
]


var arrButtworkout = [
    WorkoutSubStruct(name: "Squats", image: "squats", duration: "30 s", video: "SU2UmCkiKC8", description: "Stand with your feet shoulder width apart and your arms stretched forward, then lower your body until your thighs are parallel with the floor. Your knees should be extended in the same direction as your toes. Return to the start position and do the next rep. This works the thighs, hips buttocks, quads, hamstrings and lower body.", gif: "squats_g"),
    WorkoutSubStruct(name: "Froggy Glute Lifts", image: "forgy_gults_lift", duration: "30 s", video: "wJnFpjOdEMg", description: "Lie on your stomach with your knees bent and heels squeezed together.Then lift your feet up and down. The exercise is very effective at squeezing your butt.", gif: "frogy_gults_lift"),
    WorkoutSubStruct(name: "Lunges", image: "lunges", duration: "30 s", video: "Z2n58m2i4jg", description: "Stand with your feet shoulder width apart and your hands on your hips. Take a step forward with your right leg and lower your body until your right thigh is parallel with the floor. Then return and switch to the other leg. This exercise strengthens the quadriceps, gluteus maximus and hamstrings.", gif: "lunges_g"),
    WorkoutSubStruct(name: "Butt Bridge", image: "butt_bridge", duration: "30 s", video: "NCStg202rLU", description: "Lie on your back with knees bent and feet flat on the floor. Put your arms flat at your sides. Then lift your butt up and down.", gif: "butt_bridge_g.png"),
    WorkoutSubStruct(name: "Donkey Kicks Left", image: "donky_kick_left", duration: "30 s", video: "SJ1Xuz9D-ZQ", description: "Start on all fours with your knees under your butt and your hands under your shoulders. Then lift your left leg and squeeze your butt as much as you can. Go back to the start position and repeat the exercise.", gif: "donkey_kick_left"),
    WorkoutSubStruct(name: "Split Squat Right", image: "split_squat_right", duration: "30 s", video: "AMfbdugbcL8", description: "Take a big step forward with your right leg and keep your upper body straight. Then make your body go straight down and up.", gif: "donkey_kicks_right"),
    WorkoutSubStruct(name: "Fire Hydrant Left", image: "fire_hydrent_left", duration: "30 s", video: "La3xYT8MGks", description: "Start on all fours with your knees under your butt and your hands under your shoulders. Then lift your left leg to the side at a 90 degree angle.", gif: "fire_hydrent_left_g"),
    WorkoutSubStruct(name: "Fire Hydrant Right", image: "fire_hydrent_right", duration: "30 s", video: "La3xYT8MGks", description: "Start on all fours with your knees under your butt and your hands under your shoulders. Then lift your right leg to the side at a 90 degree angle.", gif: "fire_hydrent_right_g"),
    WorkoutSubStruct(name: "Plie Squats", image: "plie_squats", duration: "30 s", video: "hdiRghh0BTg", description: "Stand with your hands on your hips and feet a little wider than shoulder width apart.Then lower your body until your thighs are parallel to the floor. Your knees should be extended in the same direction as your tiptoes.", gif: "plie_squats.png") ,
    WorkoutSubStruct(name: "Donkey Kicks right", image: "donky_kick_right", duration: "30 s", video: "SJ1Xuz9D-ZQ", description: "Start on all fours with your knees under butt and your hands under shoulders. Then lift your right leg and squeeze your butt as much as you can. Go back to the start position and repeat the exercise.", gif: "donkey_kicks_right"),
    WorkoutSubStruct(name: "Sumo Squat Calf Raises", image: "sumo_squats_calf_raise", duration: "30 s", video: "QWgISh-t4W0", description: "Stand with your hands on your hips and your feet a little wider than shoulder width apart.Then lower your body until your thighs are parallel to the floor. Lift your heels up and down.", gif: "sumo_squats_calf_rise"),
    WorkoutSubStruct(name: "Split Squat left", image: "split_squat_left", duration: "30 s", video: "AMfbdugbcL8", description: "Take a big step forward with your left leg and keep your upper body straight. Then make your body go straight down and up.", gif: "split_squats_left_g")
]



var arrLegWorkout = [
    WorkoutSubStruct(name: "Calf raises", image: "claf_raises", duration: "30 s", video: "z__UzseazqA", description: "Stand straight with feet together. Lift the heels, and stand on your tip toe. Then drop heels down. Repeat lifting the heels up and down for 10-15 times as a set.", gif: "calf_rises"),
    WorkoutSubStruct(name: "Curtsy lunges", image: "crusty_lunges", duration: "30 s", video: "wzHjHs6jlIA", description: "Stand straight up. Then step back with your left leg to the right, and bend your knees at the same time. Go back to the start position and switch to the other side.", gif: "cursty_lungs"),
    WorkoutSubStruct(name: "Single Left Leg calf Raises", image: "single_right_leg_calf", duration: "30 s", video: "b2t5oTCch-0", description: "Stand with arms against a wall. Put your right foot on your left ankle, then lift your left heel up and down.", gif: "single_left_leg_calf"),
    WorkoutSubStruct(name: "Side Lunges", image: "side_lunges", duration: "30 s", video: "zCG7YcjggVo", description: "Stand straight with your feet together. Move your right leg to the side, then lower your body while keeping your left leg straight. Go back to the start position and switch to the other side.", gif: "side_lungs"),
    WorkoutSubStruct(name: "Left Lunge Knee Hops", image: "left_lung_knee_hopes", duration: "30 s", video: "iJsqhnRvAVE", description: "Stand straight up. Then step your left leg back and lower your body. When you come up, raise your left knee as high as you can. Go back to the start position, and repeat the exercise.", gif: "left_lung_knee_hopes_g"),
    WorkoutSubStruct(name: "Single Right Leg Calf Raises", image: "single_right_leg_calf", duration: "30 s", video: "b2t5oTCch-0", description: "Stand with arms against a wall. Put your left foot on your right ankle, then lift your right heel up and down.", gif: "single_right_leg_calf_g"),
    WorkoutSubStruct(name: "Bottom Leg Lift Left", image: "bottom_leg_lift_left", duration: "30 s", video: "9a8r12qqFHs", description: "Lie on your left side with your head resting on your left hand. Then put your right foot forward on the floor. Lift your left leg up and down.", gif: "bottom_leg_lift_left_g"),
    WorkoutSubStruct(name: "Bottom Leg Lift Right", image: "bottom_leg_lift_right", duration: "30 s", video: "9a8r12qqFHs", description: "Lie on your right side with head resting on your right hand. Then put your left foot forward on the floor. Lift your right leg up and down.", gif: "bottom_leg_lift_right_g"),
    WorkoutSubStruct(name: "Right Lunge Knee Hops", image: "right_lunge_knee_hops", duration: "30 s", video: "iJsqhnRvAVE", description: "Stand straight up. Then step your right leg back and lower your body. When you come up, raise your right knee as high as you can. Go back to the start position, and repeat the exercise.", gif: "right_lunge_knee_hops_g"),
    WorkoutSubStruct(name: "Side leg circle left", image: "side_leg_circle_left", duration: "30 s", video: "VgysBPnVJWg", description: "Lie on your right side with your head resting on your right hand. Then lift your left leg and rotate your foot in circles.", gif: "side_leg_circle_left_g"),
    WorkoutSubStruct(name: "Side leg circle right", image: "side_leg_circle_right", duration: "30 s", video: "VgysBPnVJWg", description: "Lie on your left side with your head resting on your left hand. Then lift your right leg and rotate your foot in circles.", gif: "side_leg_circle_right_g"),
    WorkoutSubStruct(name: "Backward lunge with front kick left", image: "backward_left", duration: "30 s", video: "0_bTYQCxgMg", description: "Stand straight up. Then step back with your left leg and lower your body. When you come up, kick your left leg upward. Go back to the start position, and repeat the exercise.", gif: "backward_lunge_with_front_kick_left"),
    WorkoutSubStruct(name: "Backward lunge with front kick right", image: "backward_right", duration: "30 s", video: "0_bTYQCxgMg", description: "Stand straight up. Then step back with your right leg and lower your body. When you come up, kick your right leg upward. Go back to the start position, and repeat the exercise.", gif: "backward_lunge_with_front_kick_right"),
]


var arrArmWorkout = [
    WorkoutSubStruct(name: "Side Arm Raise", image: "side_arm_raise", duration: "30 s", video: "ww0r9xZunDM", description: "Stand with your feet shoulder width apart.Raise your arms to the sides at shoulder height, then put them down. Repeat the exercise. Keep your arms straight during the exercise.", gif: "side_arm_raise_g"),
    WorkoutSubStruct(name: "Push-Ups", image: "pushup", duration: "30 s", video: "Eh00_rniF8E", description: "Lay prone on the ground with arms supporting your body. Keep your body straight while raising and lowering your body with your arms. This exercise works the chest, shoulders, triceps, back and legs.", gif: "pushups_g"),
    WorkoutSubStruct(name: "Triceps Dips", image: "tricepdips", duration: "30 s", video: "6kALZikXxLc", description: "For the start position, sit on the chair. Then move your hip off the chair with your hands holding the edge of the chair. Slowly bend and stretch your arms to make your body go up and down. This is a great exercise for the triceps.", gif: "triceps_dips_g"),
    WorkoutSubStruct(name: "Diamond Push-Ups", image: "diamond_push_up", duration: "30 s", video: "J0DnG1_S92I", description: "Start on all fours with your knees under your butt and your hands under your shoulders. Make a diamond shape with your forefingers and thumbs together directly under your face, then push your body up and down. Remember to keep your body straight.", gif: "diamond_push_ups_g"),
    WorkoutSubStruct(name: "Punches", image: "punches", duration: "30 s", video: "NJxjWnbCEJk", description: "Stand with your legs shoulder width apart and your knees bent slightly.Bend your elbows and clench your fists in front of your face.Extend one arm forward with the palm facing the floor. Take the arm back and repeat with the other arm.", gif: "punches_g"),
    WorkoutSubStruct(name: "Up and Down Plank", image: "up_down_plank", duration: "30 s", video: "L4oFJRDAU4Q", description: "Start in the straight arm plank position. Then bend your right arm and place your forearm on the ground with your elbow under your shoulder, then bend your left arm and come down into the traditional plank position. Then reverse and come back to the start position. Repeat the exercise.Keep your body straight during the exercise. Inhale when you come down and exhale when you come up.It's a great exercise for the quadriceps, triceps and abdominal muscles.", gif: "up_down_plank_g"),
    WorkoutSubStruct(name: "Shoulder Stretch", image: "shoulder_strech", duration: "30 s", video: "GTGMeddgkOo", description: "Place one arm across your body, parallel to the ground, then use the other arm to pull the parallel arm toward your chest. Hold for a while, switch arms and repeat the exercise.Keep the inside arm straight during the exercise.", gif: "shoulder_strech_g"),
    WorkoutSubStruct(name: "Arm Circles", image: "arm_circles", duration: "30 s", video: "6KPD7Mr7Yjk", description: "Stand on the floor with your arms extended straight out to the sides at shoulder height. Move your arms forward in circles, and then move backwards.", gif: "arm_circles_g"),
    WorkoutSubStruct(name: "Reverse Push-Ups", image: "reverse_push_up", duration: "30 s", video: "a00N2M7I1_o", description: "Start in the regular push-up position. Lower your body down, then bend your knees and move your hips backward with your arms straight. Go back to the push-up position and repeat.", gif: "reverse_pushups_g"),
    WorkoutSubStruct(name: "Punches", image: "punches", duration: "30 s", video: "NJxjWnbCEJk", description: "Stand with your legs shoulder width apart and your knees bent slightly.Bend your elbows and clench your fists in front of your face.Extend one arm forward with the palm facing the floor. Take the arm back and repeat with the other arm.", gif: "punches_sec_g"),
    WorkoutSubStruct(name: "One leg Push-Ups", image: "one_leg_pushup", duration: "30 s", video: "kvV6Mfchga4", description: "Start in the classic push-up position but lift one leg up. Then do a few push-ups and switch to the other leg. This works on your lower-abdominal muscles.", gif: "one_leg_pushups_g"),
    WorkoutSubStruct(name: "Plank Taps", image: "planks_tap", duration: "30 s", video: "hEGUul8mWnU", description: "Start in the straight arm plank position.Lift your right hand to tap your left shoulder. Return to the start position and repeat with the other hand.", gif: "planks_taps_g"),
    WorkoutSubStruct(name: "Triceps Stretch Left", image: "tricep_stretch_left.jpg", duration: "30 s", video: "yAvpW_zKJmI", description: "Put your left hand on your back, use your right hand to grab your left elbow and gently pull it. Hold this position for a few seconds.", gif: "tricep_stretch_left.jpg"),
    WorkoutSubStruct(name: "Triceps Stretch Right", image: "tricep_stretch_right.jpg", duration: "30 s", video: "yAvpW_zKJmI", description: "Put your right hand on your back, use your left hand to grab your right elbow and gently pull it. Hold this position for a few seconds.", gif: "tricep_stretch_right.jpg"),
]



var arrSleepyTimeStretch = [
    WorkoutSubStruct(name: "Kneeling Lunge Stretch Left", image: "kneelinglungestretch.jpg", duration: "30 s", video: "wk-FCPrR9sw", description: "Start in a push-up position. Bring your left knee forward and drop your right knee on the floor. Raise your upper body and put your hands on your waist. Then push your hips forward while keeping your upper body straight. Please make sure your front knee won’t go over your toes. Hold this position for a few seconds.", gif: "kneelinglungestretch.jpg"),
    WorkoutSubStruct(name: "Kneeling Lunge Stretch Right", image: "kneelinglungestretchright.jpg", duration: "30 s", video: "wk-FCPrR9sw", description: "Start in a push-up position. Bring your right knee forward and drop your left knee on the floor. Raise your upper body and put your hands on your waist. Then push your hips forward while keeping your upper body straight. Please make sure your front knee won’t go over your toes. Hold this position for a few seconds.", gif: "kneelinglungestretchright.jpg"),
    WorkoutSubStruct(name: "Calf Stretch Left", image: "calfstretchleft.jpg", duration: "30 s", video: "ZEXriW_Bx4E", description: "Stand one big step away in front of a wall. Step forward with your right foot and push the wall with your hands. Please make sure your left leg is fully extended and you can feel your left calf stretching. Hold this position for a few seconds.", gif: "calfstretchleft.jpg"),
    WorkoutSubStruct(name: "Calf Stretch Right", image: "calfstretchright.jpg", duration: "30 s", video: "ZEXriW_Bx4E", description: "Stand one big step away in front of a wall. Step forward with your left foot and push the wall with your hands. Please make sure your right leg is fully extended and you can feel your right calf stretching. Hold this position for a few seconds.", gif: "calfstretchright.jpg"),
    WorkoutSubStruct(name: "Triceps Stretch Left", image: "tricepstretchleft.jpg", duration: "30 s", video: "yAvpW_zKJmI", description: "Put your left hand on your back, use your right hand to grab your left elbow and gently pull it. Hold this position for a few seconds.", gif: "tricepstretchleft.jpg"),
    WorkoutSubStruct(name: "Triceps Stretc Right", image: "tricepstretchright.jpg", duration: "30 s", video: "yAvpW_zKJmI", description: "Put your right hand on your back, use your left hand to grab your right elbow and gently pull it. Hold this position for a few seconds.", gif: "tricepstretchright.jpg"),
    WorkoutSubStruct(name: "Cat Cow Pose", image: "cat_cow_pose", duration: "30 s", video: "kqnua4rHVVA", description: "Start on all fours with your knees under your butt and your hands directly under your shoulders. Then take a breath and make your belly fall down, shoulders roll back and head come up towards the ceiling. As you exhale, curve your back upward and let your head come down. Repeat the exercise.Do it slowly with each step of this exercise.", gif: "cat_cow_pose_g"),
    WorkoutSubStruct(name: "Cobra Stretch", image: "cobrastretch.jpg", duration: "30 s", video: "JDcdhTuycOI", description: "Lie down on your stomach and bend your elbows with your hands beneath your shoulders. Then push your chest up off the ground as far as possible. Hold this position for seconds.", gif: "cobrastretch.jpg"),
    WorkoutSubStruct(name: "Child's Pose", image: "childpose.jpg", duration: "30 s", video: "eqVMAPM00DM", description: "Start with your knees and hands on the floor. Put your hands a little forward, widen your knees and put your toes together. Take a breath, then exhale and sit back. Try to make your butt touch your heels. Relax your elbows, make your forehead touch the floor and try to lower your chest close to the floor. Hold this position.Keep your arms stretched forward as you sit back. Make sure there is enough space between your shoulders and ears during the exercise.", gif: "childpose.jpg"),
    WorkoutSubStruct(name: "Spine Lumbar Twist Stretch left", image: "spinelumbertwiststretchleft.jpg", duration: "30 s", video: "4DUaXUtmCNo", description: "Lie on your back with your legs extended. Lift your left leg up and use your right hand to pull your left knee to the right, but keep your other arm extended to the side on the floor. Hold this position for a few seconds.", gif: "spinelumbertwiststretchleft.jpg"),
    WorkoutSubStruct(name: "Spine Lumbar Twist Stretch right", image: "spinelumbertwiststretchright.jpg", duration: "30 s", video: "4DUaXUtmCNo", description: "Lie on your back with your legs extended. Lift your right leg up and use your left hand to pull your right knee to the left, but keep your other arm extended to the side on the floor. Hold this position for a few seconds.", gif: "spinelumbertwiststretchright.jpg")
]


var arrHomeList = [
    WorkoutMainStruct(image: "ic_work1", strCount: "No. of workout 13", strName: "Classic Workout", strDescription: "Scientifically proven to assist weight loss and improve cardiovascular functions.", arrResult: arrClassic),
    WorkoutMainStruct(image: "ic_work2", strCount: "No. of workout 14", strName: "Abs Workout", strDescription: "Get sexy, flat and firm abdominal muscles using effective abs training methods.", arrResult: arrAbsworkout),
    WorkoutMainStruct(image: "ic_work3", strCount: "No. of workout 12", strName: "Butt Workout", strDescription: "In only 7 minutes, these 12 typical exercises will give you the right butt you've always dreamed of.", arrResult: arrButtworkout),
    WorkoutMainStruct(image: "ic_work4", strCount: "No. of workout 13", strName: "Leg Workout", strDescription: "Want slim and sexy legs? Strengthen and tighten your lower body now!", arrResult: arrLegWorkout),
    WorkoutMainStruct(image: "ic_work5", strCount: "No. of workout 14", strName: "Arm Workout", strDescription: "Several minutes a day to have nice and toned arms in no time!", arrResult: arrArmWorkout),
    WorkoutMainStruct(image: "ic_work6", strCount: "No. of workout 11", strName: "Sleepy Time Stretch", strDescription: "Relax yourself and get a high-quality sleep.", arrResult: arrSleepyTimeStretch),

]
