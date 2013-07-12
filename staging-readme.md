Create a heroku app for staging  *(Only done once when setting up a heroku app for staging)*
-------------------------------

        $ heroku apps:create staging-lab-im -r staging

        heroku apps:create staging-lab-im
        Creating staging-lab-im... done, region is us
        http://staging-lab-im.herokuapp.com/ | git@heroku.com:staging-lab-im.git

*This will create a remote git repo on heroku that is tracked locally by using
this setting in the .git/config file*

       [remote "staging"]
	url = git@heroku.com:staging-lab-im.git
	fetch = +refs/heads/*:refs/remotes/staging-lab-im/*


Create a backup for the database on heroku  *(Only done once when setting up a heroku app for staging)*
-------------------------------------
See [Heroku PGbackups](https://devcenter.heroku.com/articles/pgbackups#importing_from_a_backup)

        $ heroku addons:add pgbackups

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


Create and work in a temporay branch for deployment
---------------------------------------
We use a temp branch so we don't have to push all the lab file/assets
to this project remote repo on github.
*TODO: look for better asset handling.*

        $ git branch -b heroku_tmp

Initialize the DB on Heroku
---------------------------------
        # drop the remote Heroku DB
        $ heroku pg:reset  HEROKU_POSTGRESQL_OLIVE_URL --confirm staging-lab-im

        # Run the DB migrations on heroku
        $ heroku run rake db:migrate

Add the Lab framework files into this local temporary branch
---------------------------
*Note: This uses a specific archive version that is created by the lab framework and identified by the git short SHA 2666763*

       $ rails generate lab:download_lab http://lab.dev.concord.org/version/2666763.tar.gz

Update the Rails models to match the lab framework's metadata
---------------------------
     $ rails generate lab:interactive_store
     $ rails generate lab:md2d_store

Commit these lab files locally in this temporary branch
---------------------------------
Change .gitignore so that it does *not* ignore all the files in the public direcotry.
This will allow us to git commit *all* the labs file we just downloaded
in the public dir.

In the .gitignore file change /public/* to #/public/*

Git add and commit the lab files to this temporary branch

       $ git add .
       $ git commit . -m 'Add lab framework files to the public dir'


Push and deploy this local branch, heroku_tmp, into the heroku master branch
---------------------------------

       $ git push -f staging heroku_tmp:master

(this may take a couple of minutes)

Initialize the DB on Heroku
---------------------------------
Initialize the heroku DB with "examplar" interactives and models provided by a lab server.
*Note: the 2666763 identifies a specific version of the lab framework. One may also use a more
tradional release number such as 0.5.1.*

       $ heroku run rails generate lab:import_interactives http://lab.dev.concord.org/version/2666763

*This may take some time, there are many interactives and models to load.*

View LabIm running on heroku
----------------------------

        $ heroku open

Remove the Lab framework files.
-------------------------------
We don't want to add the lab  framework files into this project repo.
We added them temporarily to this branch *only" so we could update our
heroku app.

*TODO: find a better way to deploy Lab framework files to heroku*

        $ git reset --hard HEAD~1

Or use this temporary branch *only* to push to heroku.