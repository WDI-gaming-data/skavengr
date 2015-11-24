# Skavengr

<http://www.skavengr.herokuapp.com/>

[Wireframes, ERD & User Stories](https://www.dropbox.com/sh/pv2ooa9rpok8t19/AACkBfOAKADkZxjo7DP4ZovMa?dl=0)

## Basic Info
Skavengr is a full-stack web application for creating and managing scavenger hunts.  Users, once they have signed up, can create a scavenger hunt. Our creation wizard allows users to drop different locations as pins on a map that dynamically updates with each location added, and add clues for players to find said spot.  Once on a quest, a users location will be constantly updated until they arrive at the quest location, at which point they will complete that objective.  Quest creators are able to track the progress of all users particapating in thier quests. Once all locations for a quest are completed, users are redirected to a page showing them who finished first and where they rank amongst finishers.  

## Approach taken
We started by brainstorming a project idea.  Joe created a scrum board before our first meeting, so he was made project manager.  Carl has the most GitHub experience, so we made him git master.  We spent the first day fleshing out our idea, researching the technologies we would need, and creating wireframes, user stories, and an ERD. We did not write any code day one.

Once we agreed on the basic flow of our application, Joe created a number of tasks on our scrum board.  We identified which of these components were most critical to our MVP, and scoped out a tentative delivery schedule.  We were worried about database configuration issues, but we managed to solve that issue pretty painlessly. Joe took over database setup while Carl started figuring out our complicated front-end javascript and Alec worked on the routing and styling.

We maintained these roles pretty much without incident throughout the project.  We were able to hit our deliverable schedule without fail for every major component, and did not run into any major roadblocks.  Multiple daily standups kept us focused on the most important tasks at all times, and Carl was vigilant about letting us know we needed to pull every thime he merged into the master branch. 

If we more time, we would love to do more user testing, and we have some awesome features(detailed below) we really wanted to add, but we simply ran out of time.  Also, a few more days for styling would be useful.  All in all, however, we are proud of what we have created.

## Installing dependencies
Nothing special. ````bundle install ```` should do the trick.

## Technologies used
* Built on Ruby on Rails
* HTML / CSS / JavaScript
* BootStrap 3
[Bootstrap form helper](https://github.com/bootstrap-ruby/rails-bootstrap-forms)
* Maps generated using [Google Maps API](https://developers.google.com/maps/?hl=en)
* Model validations created with help from the [timeliness gem](https://github.com/adzap/validates_timeliness/tree/master), the [date time validator gem](https://github.com/travisjeffery/validates_phone_number/blob/master/README.markdown), and the [email validator gem](https://github.com/balexand/email_validator)
* gon for asset piping
* jQuery/sweetAlert


## Known Issues
* The quest creation wizard acts wonky if users try and go back from the heroes page to the location page
* The maps fail to load occasionally when modals first pop up
*The dot showing current location does not scale up in size with map zoom
*The app is only configured to adjust to the Pacific Time Zone right now.


## Wishlist
* Alert users via text message when quests they are added to are starting, won, nearing completion, and completed
* Advanced stat tracking, showing how many users completed each task, what order tasks were typically created in, etc
* generate routes taken by players, then on completion show players the best possible route
* Include either Google Places or 4Square API and a textahead so creators can add locations without manually dropping a pin.  
* Allow sign up via Facebook, Twitter, etc.
* Allow users to upload photo clues instead of just text clues.
* Update users with a hotter or colder indicator every couple seconds while they are questing.

## Contributors
* Alec McGovern
* Joe Rehfuss
* Carl Reiner