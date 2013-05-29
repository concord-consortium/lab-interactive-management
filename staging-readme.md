Create a heroku app for staging
-------------------------------

        $ heroku apps:create staging-lab-im

        heroku apps:create staging-lab-im
        Creating staging-lab-im... done, region is us
        http://staging-lab-im.herokuapp.com/ | git@heroku.com:staging-lab-im.git

*(Optional)* Setup Git to point to this heroku app
-------------------------------------

Change the below in .git/config to allow updating, with git push , to
the staging application, staging-lab-im.

            [remote "heroku"]
            	url = git@heroku.com:staging-lab-im.git
                fetch = +refs/heads/*:refs/remotes/staging-lab-im/*

*(Optional)* View the info for this app
-------------------------------------
        $ heroku apps:info --app staging-lab-im
        === staging-lab-im
        Git URL:       git@heroku.com:staging-lab-im.git
        Owner Email:   tdyer1@gmail.com
        Region:        us
        Stack:         cedar
        Tier:          Legacy
        Web URL:       http://staging-lab-im.herokuapp.com/


Update this app from the staging branch
---------------------------------------

        $ git push -f heroku staging:master

Run database migrations on Heroku
---------------------------------

        $ heroku run rake db:migrate

Add the Lab framework files
---------------------------
*Note: This uses a specific archive version that is created by the lab framework and identified by the  git commit ab633d2*

        $ rails generate lab:update_lab https://lab-staging.s3.amazonaws.com/lab_ab633d2.tar.gz

Commit the Lab framework files and push them to Heroku
-----------------------------------------------------
 **WARNING:**  *Do not push these files to the LabIm git repo*

        $ git add public; git commit public -m 'Add lab framework files to the public dir'; git push heroku master

Populate/Initialize the DB
--------------------------

        $ heroku run rails generate lab:import_interactives

View LabIm running on heroku
----------------------------

        $ heroku open

Remove the Lab framework files.
-------------------------------
We don't want to add the lab  framework files into this project. We
added them temporarily so we  could update our Heroku app.

*TODO: find a better way to deploy Lab framework files to heroku*

        $ git reset --hard HEAD~1
