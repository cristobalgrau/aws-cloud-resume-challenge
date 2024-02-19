# The Cloud Resume Challenge

The [Cloud Resume Challenge](https://cloudresumechallenge.dev/) is a challenge created by [Forrest Brazeal](https://forrestbrazeal.com/), where you have to develop 16 steps to create a Static Web page hosted in the cloud to showcase your Resume. With this Challenge, you can show your skills as a Cloud Architect / DevOps demonstrating hands-on on the Cloud, Serverless, Infrastructure as Code (IaC), Source Control, and CI/CD.

## My Architecture diagram

![image](https://github.com/cristobalgrau/aws-cloud-resume-challenge/assets/119089907/751ef6dc-2cdc-43ec-963f-c7589be32d47)

## Step 1. Certification

Before even knowing about the Cloud Resume Challenge I undertook the essential first step of obtaining two AWS Certifications:

- [AWS Certified Cloud Practitioner](https://www.credly.com/badges/aa4eb28a-5b1f-4d94-b2b3-891eabeabf48/public_url) (March 13th, 2022)
- [AWS Certified Solutions Architect - Associate](https://www.credly.com/badges/9bc1aeec-6e7b-4be7-a952-548ea685135d/public_url) (August 12th, 2023)

These certifications would lay a strong foundation for the challenges that awaited in the Cloud Resume Challenge.

## Steps 2 & 3. HTML and CSS

To overcome my initial lack of proficiency in HTML and CSS, I opted to leverage a free template and tailor it to suit my resume. After exploring various options, I settled on a template from [TemplateFlip](https://templateflip.com/), that not only appealed to me aesthetically but also came equipped with a CSS stylesheet.

Acknowledging my limited knowledge of HTML and CSS, I delved into the basics of these languages. Armed with newfound insights, I began customizing the template. This involved a meticulous process of modifying the source code—altering colors, integrating images, adjusting backgrounds, and embedding my AWS certification badges. Additionally, I incorporated links to my LinkedIn and GitHub accounts.

## Steps 4, 5 & 6. Static Website, HTTPS, and DNS

To continue with this step you have to have your domain name. I decided to buy one from Namecheap to add a little bit more challenge to the project because you have to set the AWS DNS on your domain name registrar to make it work.

Initiating this phase involved the creation of an S3 bucket to host the HTML code for my resume. The site should use HTTPS for security. To achieve this it is needed to create a CloudFront Distribution, an Origin Access Identity (OAI) to point toward the S3 bucket, configuration of a custom SSL Certificate, and formulation of a bucket policy enabling the CloudFront Distribution to access the HTML code within the bucket.

![image](https://github.com/cristobalgrau/aws-cloud-resume-challenge/assets/119089907/dba430a3-5c7a-49f2-8adf-1bf4b99261bb)

With the entire system converging on the S3 bucket, the focus shifted to Route 53 for efficient traffic management under the domain name, rather than relying on the CloudFront Distribution address. This entailed the creation of a hosted zone, coupled with the generation of corresponding records for the domain. With this last step, we obtained the necessary DNS information to configure the domain name registrar from which I purchased my domain name.

![image](https://github.com/cristobalgrau/aws-cloud-resume-challenge/assets/119089907/0f277b36-26ec-412e-ad84-4403e75445c5)

## Steps 7 & 8. Javascript and Database

In the subsequent steps, the challenge introduced the task of implementing a visitor counter for the webpage and displaying this information dynamically. To efficiently manage and update the visitor count I decided to use DynamoDB.

It was created a DynamoDB table with two fields to store the counter. 

![image](https://github.com/cristobalgrau/aws-cloud-resume-challenge/assets/119089907/bee30426-6be7-40f3-94fb-54523652b06d)

Then we need a Lambda Function that can interact with the database to get the counter value and update it on the database.

![image](https://github.com/cristobalgrau/aws-cloud-resume-challenge/assets/119089907/d25431f9-59e1-484d-b049-330af48ef3a1)

Creating the Javascript code was a little hard because I didn't know the javascript programming language. Armed with newfound knowledge gleaned from research and the assistance of ChatGPT, I created a very basic javascript code to make the API call and show the views counter on the webpage.

## Steps 9 & 10. API and Python

The implementation of the Lambda Function required a programming language code, I decided to use Python to code with the library boto3 for AWS to interact with my AWS resources, particularly the DynamoDB table responsible for storing the visitor count.

To make it more professional the project is better to interact with the DynamoDB table using an API instead of a direct connection between the javascript code and DynamoDB to retrieve the visitor's counter. In my case, I use a GET method to invoke the lambda function to retrieve the visitor's counter and then my javascript code can make the call to this API.

![image](https://github.com/cristobalgrau/aws-cloud-resume-challenge/assets/119089907/84d4d0f0-9f51-41a7-b0ba-58d6dcb8a40f)

This API-driven architecture not only improved the project's overall structure but also adhered to best practices in software design.

## 11. Tests

This is something I can create in the future, due to this project I couldn't see anything to test on my Python code, because this code only fetches a number from a DynamoDB table, and this is something that is initialized during the creation of the table, so there is no way to have something different than a number. 

Maybe it can be created just to follow the CloudResumeChallenge. Establishing a testing framework remains a valuable investment for future iterations and expansions of the project. Even in scenarios where the expected outcome is consistently a numerical value, the inclusion of tests can serve as documentation, ensuring the code's reliability, and fostering a culture of best development practices.

## 12 & 13. Infrastructure as a Code and Source Control

For the Source control, I established a dedicated GitHub repository, facilitating systematic changes and updates to my code. Employing Git commands such as pulls and pushes, I maintained a meticulous version control system, ensuring a streamlined workflow during Infrastructure as Code (IaC) programming. This approach enabled me to comprehensively track modifications and updates.

For the Infrastructure as a Code, I opted for Terraform to orchestrate the backend infrastructure for the Cloud Resume. This pivotal step involves the creation of essential components such as the Database, Lambda Function, API Gateway, and the required IAM roles and policies. Terraform's declarative syntax and infrastructure management capabilities help to define and deploy the architecture consistently, eliminating manual interventions and ensuring a reproducible environment.

As a valuable output, the Terraform code provides the API URL required in the JavaScript code. This URL becomes integral in making API calls, fetching the views counter, and dynamically updating the webpage.

## 14 & 15. CI/CD: Back-End and Front-End

For my Continuous Integration (CI) and Continue Delivery/Deployment (CD) step, I chose to do it with GitHub Actions.

In this step, I had to learn about the format of GitHub Actions workflows, the use of the YAML language, and the structure they should have to automate the work. I played around with GitHub Marketplace to find actions to do the necessary work. After reading the documentation, running my YAML code several times, and fixing the issues found, I was able to create 2 successful workflows, one for the back end and one for the front end. They will be run automatically every time a Git Push is made to the master branch and a manual trigger was added for testing purposes.

In my case, for the Front-End workflow I had to learn a little more about the AWS CLI commands for CloudFromation and the language used to perform the queries, which in this case is JMESPath, a query language used to interact with JSON documents. I used the documentation on their website [JMESPath](https://jmespath.org/tutorial.html). All this is to achieve CloudFront invalidation every time we update the website code.

![image](https://github.com/cristobalgrau/aws-cloud-resume-challenge/assets/119089907/f6a89d39-b6f2-47ba-808a-999c4d00ae95)

![image](https://github.com/cristobalgrau/aws-cloud-resume-challenge/assets/119089907/041b21b2-69a7-4cc0-96dd-07da1aa7b434)

## 16. Blog Post

Embarking on the Cloud Resume Challenge was a journey that exceeded my expectations. At first glance, creating a resume website and deploying it using AWS cloud services may seem like a simple task. However, as I delved deeper into the challenge, I quickly realized that it was a complex and multifaceted endeavor in my AWS technical skills.

What stood out to me the most was the way the challenge forced me to open my mind to new concepts and methodologies. It wasn't merely about executing predefined tasks but about understanding the underlying principles of cloud computing, infrastructure as code, and DevOps.

As I progressed through each step, from obtaining AWS certifications to implementing CI/CD pipelines using GitHub Actions, I found myself grappling with new concepts and methodologies, the complexities of implementing a dynamic website with serverless architecture, implementing HTTPS, integrating a database, and orchestrating the entire infrastructure using Terraform. All of these facets require a holistic understanding and a creative problem-solving mindset.
