## Build tools & versions used
This app was built using Xcode 13.2.1, with iOS 15 as the focus.

## Steps to run the app
Simply clone/download and run! 

## What areas of the app did you focus on?
UX, business logic and the requirements for the challenge.

## What was the reason for your focus? What problems were you trying to solve?
I wanted to keep the focus on iOS 12 per the footnote in the challenge doc, so with that in mind I specifically avoided using SwiftUI and Combine. This was also a good opportunity to focus on areas where the improvement would be welcome, such as working with image caching.

## How long did you spend on this project?
Nearly 4 and a half hours, with a small break in between.

## Did you make any trade-offs for this project? What would you have done differently with more time?
My initial focus was to support SwiftUI and Combine, but noting the iOS 12 minimum version, I avoided using those two. If I were to make adjustments though, I would've added @available checks for at least combine, with delegate method fallbacks for support. Combine is a powerful tool and something I leverage at my work regularly, so it took a bit of getting used to not using it.

## What do you think is the weakest part of your project?
The UI can definitely use more work, and there's definitely more cases I can cover with my unit tests. The business logic concerning the list view controller is too tight knit as well (the view knows too much), I want to go back and separate that more.

## Did you copy any code or dependencies? Please make sure to attribute them here!
A few!
Apple's provided Image Caching example was fantastic for providing the example.
The string extension used in String+Extensions.
The Error class was pulled in from one of my personal projects and updated.
The UIApplication extension was pulled from one of my personal projects, and updated to support iOS 15 scenes.

## Is there any other information you’d like us to know?
I had a ton of fun working on this project, I'm already brainstorming a bunch of different ways to improve/clean up and to add more functionality and testing cases. It was open ended enough and more than anything, I definitely felt excited writing it!
