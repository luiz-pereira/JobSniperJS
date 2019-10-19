# JobSniperJS
JobSniper converted to Rails

The idea of this webapp is to help the user go searching through thousands of job posts in indeed.com with better queries and keep track of different requests.

Hopefully, it will help short-list the postings that more closely suits the user, by removing the ones that doesn't conform to the stated requests.

(this) is the JS version of the app. I have included some nice JS features.

- The application will store job postings linked to an user's request
- each user can see all their requests and update with new information from indeed and linkedin
- a link to the actual job posting is provided
- when you click more, the full description is shown

Views:
- signup: simple form for creating a customer's account. contains e-mail and password and allows for oauth through linkedin
- log in: simple log in form with OAuth
- index: will show all user's requests and click on them. Each request is a card with JS functionality for updating the request (through API) and deleting (through API). Each request can be updated in an asynchronous manner.
- make request: starts a new request with several parameters on the same page. The new request is done through a modal pop-up

models:
- users: has password and e-mail (has_many requests, has_many job_postings through requests)
- request: has a user-id (belongs_to users, has_many job postings)
- job: has a request_id, title and content
- parameters: to be used in conjunction with requests (belongs_to requests).

controllers:
- appcontroller: overall handling of the application
- usercontroller: handles requests related to users
- requestcontroller:handles requests related to requests
- jobcontroller:handles requests related to jobs

Other things:

- The website is alive in heroku (www.jobsniper.ca).

install:
-run bundle install
-run rails s in terminal
-navigate to localhost:3000

License: https://opensource.org/licenses/MIT
