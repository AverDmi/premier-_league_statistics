# Premier Ligue football statistics
___

In this project we use data about football matches that have been played in the last 10 years in the English Premier League. The data was taken from the website [Football-Data.co.uk](https://www.football-data.co.uk/englandm.php).
Based on these data, a [dashboard](https://datastudio.google.com/reporting/066249a1-e80a-4702-af10-3beac3f14c2d) was built that helps us answer several questions:
* Which 5 teams most often pleased their fans and scored the most goals playing at their home stadium
* Match outcome ratio
* Number of red cards by year. Has their number changed since the introduction of the VAR (Video Assistant Referee) system in 2019?

## Instructions how to run code
___

### Terraform
#### Execution steps
1. `terraform init`:
    * Initializes & configures the backend, installs plugins/providers, & checks out an existing configuration from a version control
2. `terraform plan`:
    * Matches/previews local changes against a remote state, and proposes an Execution Plan.
3. `terraform apply`:
    * Asks for approval to the proposed plan, and applies changes to cloud
___

### Google Cloud Platform (GCP)
1. Create an account with your Google email ID
2. Setup your first project if you haven't already
    * eg. "DTC DE Course", and note down the "Project ID" (we'll use this later when deploying infra with TF)
3. Setup service account & authentication for this project
    * Grant Viewer role to begin with.
    * Download service-account-keys (.json) for auth.
4. Download SDK for local setup
5. Set environment variable to point to your downloaded GCP keys:
```
export GOOGLE_APPLICATION_CREDENTIALS="<path/to/your/service-account-authkeys>.json"

# Refresh token/session, and verify authentication
gcloud auth application-default login
```
#### Setup for Access
1. IAM Roles for Service account:

    * Go to the IAM section of IAM & Admin https://console.cloud.google.com/iam-admin/iam
    * Click the Edit principal icon for your service account.
    * Add these roles in addition to Viewer : Storage Admin + Storage Object Admin + BigQuery Admin
2. Enable these APIs for your project:

    * https://console.cloud.google.com/apis/library/iam.googleapis.com
    * https://console.cloud.google.com/apis/library/iamcredentials.googleapis.com
3. Please ensure GOOGLE_APPLICATION_CREDENTIALS env-var is set.
```
export GOOGLE_APPLICATION_CREDENTIALS="<path/to/your/service-account-authkeys>.json"
```
___

### Airflow
#### Execution steps
1. Build the image (only first-time, or when there's any change in the Dockerfile, takes ~15 mins for the first-time):
```
docker-compose build
```
2. Initialize the Airflow scheduler, DB, and other config
```
docker-compose up airflow-init
```
3. Kick up the all the services from the container:
```
docker-compose up
```
4. Login to Airflow web UI on `localhost:8080` with default creds: `airflow/airflow`
5. Run DAG on the Web Console.
___

### BigQuery
#### Execution steps
1. Create external table in Storage
```
CREATE OR REPLACE EXTERNAL TABLE '<your project id>.football_data.premier_league_statistics'
OPTIONS (
  format = 'parquet',
  uris = ['gs://<your project Bucket>/raw/football/*']
);
```
___

### DBT
#### Create a dbt cloud project
1. Create a dbt cloud account [from their](https://www.getdbt.com/pricing/) website (free for solo developers)
2. Once you have logged in into dbt cloud you will be prompt to create a new project
3. Name your project
4. Choose Bigquery as your data warehouse:
5. Upload the key you downloaded from BQ on the create from file option. This will fill out most fields related to the production credentials. Scroll down to the end of the page and set up your development credentials
6. Click on Test and after that you can continue with the setup
#### Add GitHub repository
Note: This step could be skipped by using a managed repository if you don't have your own GitHub repo for the course.
1. Select git clone and paste the SSH key from your repo.
2. You will get a deploy key, head to your GH repo and go to the settings tab. Under security you'll find the menu deploy keys. Click on add key and paste the deploy key provided by dbt cloud. Make sure to tikce on "write access"
#### Tranform data and create a table
1. You shoul copy code from [this folder](https://github.com/AverDmi/premier_league_statistics/tree/master/dbt)
2. Run command
```
dbt build
```
___

### Goolge Data Studio
1. To create a dashboard follow the [link](https://datastudio.google.com/)
2. Click `Create` and choose data source
3. Choose `BigQuery` and select your project