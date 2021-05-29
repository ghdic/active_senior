// SCROLLMAGIC
const controller = new ScrollMagic.Controller();

// --- Section 1 Start ---
const section1 = document.querySelector('#section1')
const video1 = section1.querySelector('#active_senior1')
// const text1 = section1.querySelector('#text1')

// Scenes1
let scene1 = new ScrollMagic.Scene({
    duration: 7000,
    triggerElement: section1,
    triggerHook: 0
})
.setPin(section1)
.addTo(controller)

// Text Animation 1
// const textAnim1 = TweenMax.fromTo(text1, 7, {opacity: 1}, {opacity: 0})

// let text_scene1 = new ScrollMagic.Scene({
//     duration: 7000,
//     triggerElement: section1,
//     triggerHook: 0
// })
// .setTween(textAnim1)
// .addIndicators()
// .addTo(controller)

// --- Section 1 End ---

// --- Section 2 Start ---
const section2 = document.querySelector('#section2')
const video2 = section2.querySelector('#active_senior2')

// Scenes2
let scene2 = new ScrollMagic.Scene({
    duration: 7500,
    triggerElement: section2,
    triggerHook: 0
})
.setPin(section2)
.addTo(controller)

// Text Animation 2
const textAnim2 = TweenMax.staggerFrom("#text2", 2, {
    ease:Back.easeOut,
    opacity: 0,
    y: 200,
    delay: 0.5
}, 0.2);

let text_scene2 = new ScrollMagic.Scene({
    triggerElement: section2,
    triggerHook: 0
})
.setTween(textAnim2)
.addTo(controller)

// --- Section 2 End ---


// --- Section 3 Start ---
const section3 = document.querySelector('#section3')
const video3 = section3.querySelector('#active_senior3')

// Scenes3
let scene3 = new ScrollMagic.Scene({
    duration: 9500,
    triggerElement: section3,
    triggerHook: 0
})
.setPin(section3)
.addTo(controller)

// Text Animation 3
const textAnim3 = TweenMax.staggerFrom("#text3", 2, {
    ease:Back.easeOut,
    opacity: 0,
    y: 200,
    delay: 0.5
}, 0.2);

let text_scene3 = new ScrollMagic.Scene({
    triggerElement: section3,
    triggerHook: 0
})
.setTween(textAnim3)
.addTo(controller)

// --- Section 3 End ---


// --- Section 4 Start ---
const section4 = document.querySelector('#section4')
const video4 = section4.querySelector('#active_senior4')

// Scenes4
let scene4 = new ScrollMagic.Scene({
    duration: 7000,
    triggerElement: section4,
    triggerHook: 0
})
.setPin(section4)
.addTo(controller)

// Text Animation 4
const textAnim4 = TweenMax.staggerFrom("#text4", 2, {
    ease:Back.easeOut,
    opacity: 0,
    y: 200,
    delay: 0.5
}, 0.2);

let text_scene4 = new ScrollMagic.Scene({
    triggerElement: section4,
    triggerHook: 0
})
.setTween(textAnim4)
.addTo(controller)

// --- Section 4 End ---


// --- Section 5 Start ---
const section5 = document.querySelector('#section5')
const video5 = section5.querySelector('#active_senior5')

// Scenes5
let scene5 = new ScrollMagic.Scene({
    duration: 7000,
    triggerElement: section5,
    triggerHook: 0
})
.setPin(section5)
.addTo(controller)

// Text Animation 5
const textAnim5 = TweenMax.staggerFrom("#text5", 2, {
    ease:Back.easeOut,
    opacity: 0,
    y: 200,
    delay: 0.5
}, 0.2);

let text_scene5 = new ScrollMagic.Scene({
    triggerElement: section5,
    triggerHook: 0
})
.setTween(textAnim5)
.addTo(controller)

// --- Section 5 End ---


// --- Section 6 Start ---
const section6 = document.querySelector('#section6')
const video6 = section6.querySelector('#active_senior6')

// Scenes6
let scene6 = new ScrollMagic.Scene({
    duration: 7000,
    triggerElement: section6,
    triggerHook: 0
})
.setPin(section6)
.addTo(controller)

// Text Animation 6
const textAnim6 = TweenMax.staggerFrom("#text6", 2, {
    ease:Back.easeOut,
    opacity: 0,
    y: 200,
    delay: 0.5
}, 0.2);

let text_scene6 = new ScrollMagic.Scene({
    triggerElement: section6,
    triggerHook: 0
})
.setTween(textAnim6)
.addTo(controller)

// --- Section 6 End ---


// Video Animation
let accelamount = 0.1
let scrollpos = 0
let delay = 0


scene1.on('update', (e) => {
    scrollpos = e.scrollPos / 1000;
})


setInterval(() => {
    delay += (scrollpos - delay) * accelamount
    video1.currentTime = delay // 부드럽게 멈추게하기 위해서 scrollpos가 아닌 delay 사용
    video2.currentTime = delay - 7;
    video3.currentTime = delay - 16;
    video4.currentTime = delay - 26;
    video5.currentTime = delay - 34;
    video6.currentTime = delay - 42;
}, 33.3)



