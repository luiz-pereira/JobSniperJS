* move scrape to services

* fix oauth

* new/edit request
- Fix the job_titles once again. i.e. create join table job_titles_request.
- try to implement a suggestion for - jobtitles.
- include as many job titles as you want
- one nice way to includes and excludes, with one text_field two buttons.

* list requests
- show it nicely
- maybe allow for editing in loco?
- grab through API
- show titles has_many
- show number of jobs has_many

* list jobs (show page request)
- show page
- show it nicely

* update request
- try to do it asynchronous (with current status). through rails api and then?. method update() in JS class Request.

* write some tests

* pmi emails
- change it to a one page application with JS