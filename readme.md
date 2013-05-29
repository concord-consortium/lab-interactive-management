Lab Interactive Management (LabIM)
===================================
A Rails 4 application that manages [Next Gen MW](https://github.com/concord-consortium/lab), i.e. lab framework, interactives.

* <i>NOTE: the Code Generation, Import Lab framework files and Database
  creation steps below **MUST** all be based on the same release or
  version, git commit, of the lab framework.</i>


Install
-------

        $ git clone git@github.com:concord-consortium/lab-interactive-management.git

Dependencies
------------
All of these dependencies are installed and managed by [Bundler](http://gembundler.com/)

- Rails - version 4.0. Currently using 4.0.0.rc1.
- Ruby - version 1.9.3. (Should be able to run on Ruby 2.0)
- PostgreSQL
- *See Gemfile*

Import Lab framework files
----------------------------------
The lab framework provides a set of interactive files that **MUST** be
imported. These files can be imported from a Lab framework release or from an archive that is remotely available at a URL.

- From a remote archive created by the lab framework. *Note: the name of the archive includes the git commit hash of these files from the lab framework, ab633d2.*:

       $ rails generate lab:update\_lab https://lab-staging.s3.amazonaws.com/lab_ab633d2.tar.gz

- From a lab framework release *TODO: not implemented*:

Code Generation
---------------
As the definitions/metadata of the interactives and models change in the lab
framework we'll need to update a small amount of code in LabIM. There
are two rails generators that make these updates.

- To re-generate the metadata for interactives:

     $ rails generate interactive_store

- To re-generate the metadata for md2d models:

     $ rails generate md2d_store

Database creation
-----------------
1. $ rake db:create:all
2. $ rake db:migrate

Database initialization
------------------------
Interactives can be imported into the DB in two ways.

- From a remote version of LabIM at a URL:

       $ rails generate lab:import_interactives http://lab3.dev.concord.org

- From the local filesystem. **Prerequisite: Import Lab framework files **:

       $ rails generate lab:import_interactives

Deployment
----------
### Heroku
#### [Deploy to Staging](staging-readme.md)

#### Deploy to Production

1. Install the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-command#installing-the-heroku-cli).


* Create an app for LabIM on heroku *Note: this will also create a remote heroku git repo*

       $ heroku apps:create my-lab-im


* Deploy.
  This will use Bundler to install all the dependencies/gems,
  precompile the assets, etc. See [Getting starting with Rails3.x](https://devcenter.heroku.com/articles/rails3)
  for more info on installing Rails apps on Heroku.

  1. Deploy master branch

       $ git push heroku master

       * *(Only if not deploying master branch)* Deploy branch named 'heroku_branch'

          $ git push heroku heroku_branch:master

  * Run database migrations on Heroku

        $ heroku run rake db:migrate

  * Add the Lab framework files *Note: This uses a specific archive version that is created by the lab framework and identified by the  git commit ab633d2*`

        $ rails generate lab:update\_lab https://lab-staging.s3.amazonaws.com/lab_ab633d2.tar.gz

  * Commit the Lab framework files and push them to Heroku *Note: do not push these files to the LabIm git repo*

        $ git add public; git commit public -m 'Add lab framework files to the public dir'; git push heroku master

  * Populate/Initialize the DB

        $ heroku run rails generate lab:import_interactives

  * View LabIm running on heroku

        $ heroku open

  * Remove the Lab framework files. We don't want to add the lab
   framework files into this project. We added them temporarily so we
   could update our Heroku app. *TODO: find a better way to deploy Lab
   framework files to heroku*

        $ git reset --hard HEAD~1
