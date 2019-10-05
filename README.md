# JobSniperJS
JobSniper converted to Rails

The idea of this webapp is to help the user go searching through thousands of job posts in indeed.com with better queries and keep track of different requests.

Hopefully, it will help short-list the postings that more closely suits the user, by removing the ones that doesn't conform to the stated requests.

(this) is the JS version of the app. I'll try to include nice JS features.


- The application will store job postings linked to an user's request
- each user can see all their requests and update with new information from indeed
- a link to the actual job posting is provided

Views:
- signup: simple form for creating a customer's account. contains e-mail and password
- log in: simple log in form
- index: will show all user's requests and click on them
- request: show a request details and allow the user to click on job postings
- make request: starts a new request with several parameters

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
-run shotgun in terminal
-navigate to localhost:9393

License: https://opensource.org/licenses/MIT
